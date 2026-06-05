# Contrato de comunicação com o back-end

Este documento descreve **tudo o que o app envia ao back-end (Spring)** e **tudo o que
ele precisa receber**, no contexto da autenticação e das notificações push (FCM) /
tratamento do toque na notificação.

> Autenticação: exceto o login e o cadastro, toda requisição leva o JWT do cliente
> logado no header `Authorization: Bearer <jwt>`. O JWT é guardado pelo app via
> `flutter_secure_storage` (key `jwt_token`) — ver `ClienteService`.

> Valores de `plataforma`: `ANDROID`, `IOS` ou `OUTRO` (ver `NotificationService._plataforma`).
> Valores de `status` de pedido: `Finalizado`, `Cancelado pelo quiosque`,
> `Cancelado pelo cliente` (ver `StatusPedido` em `avaliar_pedidos.dart`).

> **Estado atual:** as chamadas HTTP de notificação/pedido já existem no app (modo
> mock) e o login/cadastro ainda usam um JWT fixo (`mock_jwt_token`). Os endpoints
> de autenticação abaixo são o **contrato esperado** para quando o back-end for ligado.

---

## 1. Autenticação

### 1.1. Login
O app envia o identificador (e-mail **ou** telefone) e a senha; recebe de volta o
JWT e os dados do cliente.

**Arquivos:**
- `lib/src/modules/login/pages/login.dart` — tela / coleta dos dados.
- `lib/providers/cliente_provider/cliente_provider.dart` — `ClienteNotifier.login` (onde a chamada acontece).
- `lib/data/services/cliente_service.dart` — salva o JWT (`salvarJWT`) e os dados do cliente.

```
POST /api/auth/login
Content-Type: application/json
```

**Body (envia):**
```json
{
  "login": "teste@gmail.com",
  "senha": "123"
}
```
- `login` aceita e-mail ou telefone (o campo único da tela de login).

**Resposta esperada (recebe) — `200 OK`:**
```json
{
  "token": "jwt-gerado-pelo-backend",
  "cliente": {
    "nomeCompleto": "Maria Silva",
    "email": "teste@gmail.com",
    "telefone": "(13) 99999-9999"
  }
}
```
- `token` é salvo no secure storage e usado em todas as outras chamadas.
- `cliente` alimenta o `ClienteModel` (ver seção 1.3).

**Erros esperados:** `401 Unauthorized` (credenciais inválidas).

---

### 1.2. Cadastro
Cria a conta e, idealmente, já retorna o JWT (login automático).

**Arquivos:**
- `lib/src/modules/cadastro/pages/cadastro.dart` — tela / coleta dos dados.
- `lib/providers/cliente_provider/cliente_provider.dart` — `ClienteNotifier.login` (chamado após o cadastro).
- `lib/data/services/cliente_service.dart` — salva o JWT e os dados do cliente.

```
POST /api/auth/cadastro
Content-Type: application/json
```

**Body (envia):**
```json
{
  "nomeCompleto": "Maria Silva",
  "email": "maria@gmail.com",
  "telefone": "(13) 99999-9999",
  "cpf": "123.456.789-00",
  "senha": "123"
}
```
- A confirmação de senha é validada **no app**, não é enviada.

**Resposta esperada (recebe) — `200 OK` / `201 Created`:** mesmo formato do login
(`{ "token": ..., "cliente": {...} }`).

**Erros esperados:** `409 Conflict` (e-mail/CPF já cadastrado), `400 Bad Request`
(dados inválidos).

---

### 1.3. Modelo do cliente
Objeto `cliente` retornado no login/cadastro.

**Arquivos:**
- `lib/src/shared/models/cliente_model.dart` — `ClienteModel.fromMap` (desserialização).

| Campo         | Tipo           | Obrigatório | Observações                                  |
|---------------|----------------|-------------|----------------------------------------------|
| `nomeCompleto`| string         | Sim         |                                              |
| `email`       | string         | Sim         |                                              |
| `telefone`    | string         | Sim         |                                              |
| `fotoPath`    | string \| null | Não         | Caminho/URL da foto de perfil.               |

> `id` existe apenas no armazenamento local (sqflite) e não precisa vir do back-end.

---

## 2. Outros dados que o APP ENVIA ao back-end

### 2.1. Registrar / atualizar token FCM
Enviado após o login e sempre que o FCM rotaciona o token.

**Arquivos:**
- `lib/data/repositories/notification_repository.dart` — `registrarToken` (a chamada HTTP).
- `lib/data/services/notification_service.dart` — `sincronizarToken` (obtém o token e decide reenviar).
- `lib/providers/cliente_provider/cliente_provider.dart` — dispara após o login.

```
POST /api/dispositivos/registrar
Authorization: Bearer <jwt>
Content-Type: application/json
```

**Body:**
```json
{
  "token": "fcm_token_do_dispositivo",
  "plataforma": "ANDROID"
}
```

**Resposta esperada:** `200 OK` (corpo não é usado pelo app).

---

### 2.2. Remover token FCM
Enviado no logout / exclusão de conta, para o próximo usuário deste aparelho não
receber notificações do anterior.

**Arquivos:**
- `lib/data/repositories/notification_repository.dart` — `removerToken` (a chamada HTTP).
- `lib/data/services/notification_service.dart` — `removerToken` (orquestra antes de apagar o JWT).
- `lib/providers/cliente_provider/cliente_provider.dart` — dispara no `logout` / `deletarConta`.

```
DELETE /api/dispositivos/{token}
Authorization: Bearer <jwt>
```

**Resposta esperada:** `200 OK` ou `204 No Content`.

---

### 2.3. Buscar um pedido específico
Usado ao tocar numa notificação de um pedido que **não está mais salvo no aparelho**
(sqflite local).

**Arquivos:**
- `lib/data/services/pedido_service.dart` — `buscarPedidoNoBackend` (a chamada HTTP).
- `lib/providers/pedido_provider/pedido_provider.dart` — passthrough `buscarPedidoNoBackend`.
- `lib/src/shared/widget/notificacao_listener.dart` — onde o fallback é acionado.
- `lib/src/shared/models/pedidos_model.dart` — `PedidosModel.fromJson` (parse da resposta).

```
GET /api/pedidos/{idPedido}
Authorization: Bearer <jwt>
```

- `idPedido` = identificador único do pedido (UUID), o mesmo usado localmente.

**Respostas esperadas:**
- `200 OK` → JSON do pedido (formato na seção **3.2**).
- `404 Not Found` → o app trata como "pedido não encontrado" e abre a lista de pedidos.

---

## 3. Dados que o APP RECEBE do back-end

### 3.1. Notificação push (mensagem FCM)
Enviada pelo back-end via Firebase Admin SDK quando o status de um pedido muda.

**Arquivos:**
- `lib/data/services/notification_service.dart` — recebe a mensagem (`mostrarNotificacaoLocal` em foreground, `onMessageOpenedApp`, `getInitialMessage` e o `firebaseMensagemBackgroundHandler`).
- `lib/src/shared/widget/notificacao_listener.dart` — decide a navegação a partir do `data`.

Uma mensagem FCM tem duas partes:

**`notification`** — o que é exibido na tela (banner/título/corpo):
```json
{
  "title": "Seu pedido está preparando! 🎉",
  "body": "O quiosque está preparando seu pedido."
}
```

**`data`** — dados que o app usa para decidir a navegação. **Todos os valores são strings**
(exigência do FCM):
```json
{
  "idPedido": "uuid-do-pedido",
  "status": "Cancelado pelo quiosque",
  "tipo": "STATUS_PEDIDO"
}
```

| Campo      | Obrigatório | Uso no app                                                            |
|------------|-------------|-----------------------------------------------------------------------|
| `idPedido` | Sim         | Localiza o pedido (local ou via 2.3) para decidir a rota ao tocar.    |
| `status`   | Recomendado | Informativo / contexto.                                               |
| `tipo`     | Opcional    | Categorização da notificação (ex.: `STATUS_PEDIDO`).                  |

**Comportamento ao tocar na notificação** (`NotificacaoListener`):
- pedido **cancelado** (`Cancelado pelo quiosque` / `Cancelado pelo cliente`) → abre `/avaliarPedidos`;
- qualquer outro caso (ou `idPedido` ausente / pedido não encontrado) → abre `/pedidos`.

> Importante: o `idPedido` no `data` precisa ser o **UUID** do pedido (`idPedido`),
> não o código de 4 dígitos (`codigoPedido`).

---

### 3.2. Pedido (JSON)
Retornado por `GET /api/pedidos/{idPedido}` (seção 2.3).

**Arquivos:**
- `lib/src/shared/models/pedidos_model.dart` — `PedidosModel.fromJson` (desserialização).
- `lib/data/services/pedido_service.dart` — `buscarPedidoNoBackend` (recebe a resposta).

```json
{
  "idPedido": "uuid-do-pedido",
  "codigoPedido": "A1B2",
  "status": "Cancelado pelo quiosque",
  "horaPedido": "2026-06-05T14:32:00.000",
  "motivoCancelamento": "Item em falta",
  "quiosque": {
    "idQuiosque": "uuid-do-quiosque",
    "nomeQuiosque": "Quiosque do Sol",
    "imgBannerQuiosque": "https://.../banner.jpg"
  },
  "itens": [
    {
      "idProduto": "uuid-do-produto",
      "idQuiosque": "uuid-do-quiosque",
      "nomeItem": "X-Salada",
      "valorTotal": 1500,
      "qtdeItem": 1,
      "ingredientes": ["Alface", "Tomate"],
      "adicionais": [
        { "nome": "Bacon", "preco": 200 }
      ]
    }
  ]
}
```

| Campo                       | Tipo            | Obrigatório | Observações                                              |
|-----------------------------|-----------------|-------------|----------------------------------------------------------|
| `idPedido`                  | string (UUID)   | Sim         | Identificador único do pedido.                           |
| `codigoPedido`              | string          | Sim         | Código curto (4 dígitos) exibido ao cliente.             |
| `status`                    | string          | Sim         | Um dos valores de `StatusPedido`.                        |
| `horaPedido`                | string ISO-8601 | Sim         | Parseado com `DateTime.parse`.                           |
| `motivoCancelamento`        | string \| null  | Não         | Exibido apenas em cancelamento pelo quiosque.            |
| `quiosque.idQuiosque`       | string          | Sim         |                                                          |
| `quiosque.nomeQuiosque`     | string          | Sim         |                                                          |
| `quiosque.imgBannerQuiosque`| string \| null  | Não         |                                                          |
| `itens[].idProduto`         | string          | Sim         |                                                          |
| `itens[].idQuiosque`        | string          | Sim         |                                                          |
| `itens[].nomeItem`          | string          | Sim         |                                                          |
| `itens[].valorTotal`        | int (centavos)  | Sim         | Em centavos (ex.: `1500` = R$ 15,00).                    |
| `itens[].qtdeItem`          | int             | Não         | Default `1`.                                             |
| `itens[].ingredientes`      | string[]        | Não         | Default `[]`.                                            |
| `itens[].adicionais`        | objeto[]        | Não         | Cada item: `{ "nome": string, "preco": int (centavos) }`.|

---

## 4. Resumo rápido

| Direção        | Operação                         | Endpoint / Canal                  | Arquivo principal (app)                                  |
|----------------|----------------------------------|-----------------------------------|----------------------------------------------------------|
| App ↔ Back-end | Login                            | `POST /api/auth/login`            | `lib/providers/cliente_provider/cliente_provider.dart`   |
| App ↔ Back-end | Cadastro                         | `POST /api/auth/cadastro`         | `lib/providers/cliente_provider/cliente_provider.dart`   |
| App → Back-end | Registrar token FCM              | `POST /api/dispositivos/registrar`| `lib/data/repositories/notification_repository.dart`     |
| App → Back-end | Remover token FCM                | `DELETE /api/dispositivos/{token}`| `lib/data/repositories/notification_repository.dart`     |
| App → Back-end | Buscar pedido por id             | `GET /api/pedidos/{idPedido}`     | `lib/data/services/pedido_service.dart`                  |
| Back-end → App | Notificação de mudança de status | Push FCM (`notification` + `data`)| `lib/data/services/notification_service.dart`            |
| Back-end → App | Dados do pedido                  | Resposta JSON do `GET` acima      | `lib/src/shared/models/pedidos_model.dart`               |

> Para ativar de verdade: definir a base URL (sugestão `--dart-define=API_BASE_URL=...`)
> e descomentar os blocos HTTP em `NotificationRepository` e `PedidoService`, além de
> ligar o login/cadastro reais no `ClienteNotifier` (hoje usam `mock_jwt_token`).
