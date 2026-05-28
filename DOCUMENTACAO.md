# Documentação do projeto `client_app` — Pôr-do-Sol

App Flutter para clientes realizarem pedidos em quiosques de praia.

---

## Visão geral da arquitetura

```
lib/
├── main.dart                    # Ponto de entrada
├── MyApp.dart                   # App root + roteamento
├── data/
│   ├── database/                # SQLite (sqflite)
│   ├── repositories/            # Acesso direto ao banco
│   └── services/                # Regras de negócio de dados
├── providers/                   # Estado global (Riverpod)
└── src/
    ├── modules/                 # Páginas por funcionalidade
    └── shared/                  # Widgets, models e utils reutilizáveis
```

**Stack:** Flutter + Riverpod (estado) + go_router (rotas) + sqflite (banco local) + flutter_secure_storage (JWT) + geolocator.

---

## `main.dart`

Ponto de entrada. Envolve o app com `ProviderScope` do Riverpod, habilitando acesso a todos os providers na árvore de widgets.

---

## `MyApp.dart`

Configura duas coisas principais:

**Roteamento (`GoRouter`)** — define todas as rotas do app:

| Rota | Página | Observação |
|------|--------|------------|
| `/login` | `Login` | Sem NavBar |
| `/cadastro` | `Cadastro` | Sem NavBar |
| `/quiosquePage` | `QuiosquePage` | Recebe `QuiosqueModel` via `extra` |
| `/itemPage` | `ItemPage` | Recebe record `(item, quiosque, desabilitado)` via `extra` |
| `/ajuda`, `/ajudaTopico` | `AjudaPage`, `AjudaTopico` | Sem NavBar |
| `/historicoPedidos` | `HistoricoPedidos` | Sem NavBar |
| `/modificarPerfil` | `ModificarPerfilPage` | Sem NavBar |
| `/inicio`, `/carrinho`, `/pedidos`, `/perfil` | Abas do NavBar | Compartilham `CustomNavBar` via `StatefulShellRoute` |

**Tema (`ThemeData`)** — paleta de cores quente (terracota/coral), fonte Poppins, Material 3.

---

## Camada `data/`

### `database/database_helper.dart`

Singleton que abre/cria o banco SQLite `cliente.db` (versão 2).

- **`_createDB`** — cria as tabelas `pedidos` e `clientes` na primeira instalação.
- **`_onUpgradeDB`** — migração para versão 2: cria a tabela `clientes` caso ela não exista (upgrade de versão 1).
- **`database`** (getter) — retorna a instância do banco, abrindo-a lazily na primeira chamada.

**Esquema da tabela `pedidos`:**
`idPedido | idProduto | idQuiosque | codigoPedido | nomeQuiosque | imgBannerQuiosque | nomeItem | valorTotal | ingredientes (JSON) | adicionais (JSON) | qtdeItem | status | horaPedido`
PK composta: `(idPedido, idProduto, idQuiosque)`

**Esquema da tabela `clientes`:**
`id (AUTOINCREMENT) | nomeCompleto | email | telefone | fotoPath`

---

### `repositories/cliente_repository.dart`

Singleton. Operações CRUD da tabela `clientes`.

| Método | O que faz |
|--------|-----------|
| `buscarCliente()` | Retorna o primeiro (e único) registro de cliente, ou `null` |
| `inserirCliente(cliente)` | Insere novo cliente com `ConflictAlgorithm.replace` |
| `atualizarCliente(cliente)` | Atualiza pelo `id` |
| `deletarCliente()` | Remove todos os registros (logout/exclusão de conta) |

---

### `repositories/pedido_repository.dart`

Singleton. Operações CRUD da tabela `pedidos`.

| Método | O que faz |
|--------|-----------|
| `listarPedidos()` | Retorna todos os pedidos como `List<Map>` |
| `inserirItem(dadosPedido)` | Insere uma linha (um item de um pedido) |
| `atualizarStatus(idPedido, novoStatus)` | Atualiza o status de todas as linhas de um pedido |
| `deletarPedido()` | Apaga todos os pedidos |
| `deletarPedidoIdPedidoIdQuiosque(idPedido)` | Apaga todas as linhas de um pedido específico |
| `finalizarTodos()` | Marca como "Finalizado" tudo que não está finalizado |

---

### `services/cliente_service.dart`

Singleton. Orquestra o repositório de clientes e o armazenamento seguro do JWT.

| Método | O que faz |
|--------|-----------|
| `salvarJWT(token)` | Salva o token no `FlutterSecureStorage` |
| `obterJWT()` | Lê o token salvo |
| `deletarJWT()` | Remove o token (logout) |
| `estaLogado()` | Retorna `true` se existe um token não-vazio |
| `buscarCliente()` | Delega ao repositório |
| `salvarCliente(cliente)` | Insere ou atualiza o cliente (upsert manual) |
| `deletarDadosCliente()` | Apaga JWT + dados do cliente (logout/exclusão) |
| `obterLocalizacao()` | Solicita permissão e retorna a `Position` atual via `geolocator` |

---

### `services/pedido_service.dart`

Singleton. Camada fina que delega todas as operações ao `PedidoRepository`. Serve como ponto único de acesso para os providers, isolando a camada de dados.

---

## Camada `providers/`

### `carrinho_provider/carrinho_provider.dart`

Estado: `Map<QuiosqueCarrinho, List<ItemCarrinho>>` — agrupa itens por quiosque.
`keepAlive: true` — persiste enquanto o app está aberto.

| Método | O que faz |
|--------|-----------|
| `adicionarItem(quiosque, item)` | Adiciona item ao mapa; se já existe (por `Equatable`), soma a quantidade. Retorna `bool` de sucesso |
| `removerItem(quiosque, item)` | Remove um item específico; remove o quiosque se a lista ficar vazia |
| `removerQuiosque(quiosque)` | Remove todos os itens de um quiosque |
| `limparCarrinho()` | Zera o estado (chamado no logout) |

> `ItemCarrinho` usa `Equatable` com props `[idProduto, idQuiosque, ingredientes, adicionais]` — dois itens do mesmo produto com ingredientes/adicionais diferentes são tratados como itens distintos.

---

### `cliente_provider/cliente_provider.dart`

Estado: `AsyncNotifierProvider<ClienteNotifier, ClienteModel?>` — `null` significa não logado.

| Método | O que faz |
|--------|-----------|
| `build()` | Verifica se está logado via JWT; se sim, carrega o cliente do banco |
| `login(...)` | Salva JWT + salva cliente no banco + atualiza o estado |
| `atualizarPerfil(cliente)` | Atualiza os dados e recarrega o estado |
| `logout()` | Deleta dados + limpa carrinho + limpa pedidos + estado → `null` |
| `deletarConta()` | Mesmo comportamento do logout (sem distinção no momento) |

---

### `pedido_provider/pedido_provider.dart`

Estado: `FutureOr<List<PedidosModel>>` — lista de pedidos ativos.
`keepAlive: true`.

| Método | O que faz |
|--------|-----------|
| `build()` | Carrega pedidos do banco e monta os `PedidosModel` agrupando linhas pelo `idPedido` |
| `criarPedido()` | Lê o carrinho, gera UUID para o pedido, salva cada item no banco, limpa o carrinho. Retorna `bool` |
| `mandarPedidoParaOBanco(pedido)` | Serializa ingredientes/adicionais como JSON e insere cada item individualmente |
| `alterarStatus(idPedido, novoStatus)` | Atualiza banco e estado em memória sem recarregar tudo |
| `apagarPedidos()` | Limpa estado e banco (chamado no logout) |
| `apagarPedidoPorIdPedidoIdQuiosque(idPedido)` | Cancela um pedido específico |
| `finalizarTodosPedidos()` | Marca todos como "Finalizado" no banco e no estado |

---

### `historico_provider/historico_provider.dart`

Estado: `AsyncNotifierProvider<HistoricoNotifier, List<PedidosModel>>`.
Faz a mesma leitura/agrupamento do `PedidoNotifier.build()`, mas é um provider separado — usado exclusivamente na tela de histórico para não interferir no estado dos pedidos ativos.

| Método | O que faz |
|--------|-----------|
| `_carregarHistorico()` | Lê o banco, decodifica JSON de ingredientes/adicionais e monta `PedidosModel` agrupados por `idPedido` |
| `refresh()` | Invalida o provider para recarregar (via `ref.invalidateSelf()`) |

---

## Modelos (`src/shared/models/`)

| Arquivo | Classe(s) | Descrição |
|---------|-----------|-----------|
| `cliente_model.dart` | `ClienteModel` | Dados do usuário (id, nome, email, telefone, fotoPath). Tem `copyWith`, `toMap`, `fromMap` |
| `item_carrinho.dart` | `ItemCarrinho`, `QuiosqueCarrinho` | Item no carrinho com ingredientes removidos e adicionais selecionados. Ambos usam `Equatable` para comparação por valor |
| `pedidos_model.dart` | `PedidosModel` | Agrupa itens de um mesmo pedido com quiosque, status e hora |
| `quiosque_model.dart` | `QuiosqueModel` | Dados completos de um quiosque (nome, imagens, avaliação, distância, horários, categorias) |
| `item_quiosque.dart` | `ItemQuiosque` | Item do cardápio do quiosque com preço (em centavos), ingredientes e adicionais disponíveis |
| `adicionaisItem.dart` | `AdicionaisItem` | Adicional com nome e preço. Tem `toJson` e `fromMap` usados na serialização para o banco |
| `ajuda_model.dart` | `AjudaModel` | Simples: tópico + descrição de ajuda |

---

## Utilitários (`src/shared/utils/`)

### `validator.dart`

Funções de validação de formulários:

| Classe | Método | O que valida |
|--------|--------|--------------|
| `cpfValidator` | `isValidCpf(cpf)` | Remove máscara, verifica tamanho, dígitos repetidos e os dois dígitos verificadores |
| `phoneValidator` | `phoneValidate(phone)` | Remove não-numéricos e verifica se tem exatamente 11 dígitos (DDD + número) |
| `emailValidator` | `emailValidate(email)` | Regex de e-mail |
| `phoneEmailValidator` | `phoneEmailValidate(value)` | Aceita telefone OU e-mail (usado no campo de login) |
| `passwordsValidator` | `equalsPassword(p1, p2)` | Verifica se duas senhas são iguais |

### `verificarHorario.dart`

| Função | O que faz |
|--------|-----------|
| `extrairHora(horaString, agora)` | Converte string `"HH:mm"` em `DateTime` |
| `verificarQuiosqueAberto(abertura, fechamento)` | Compara hora atual com intervalo; trata virada de meia-noite |
| `verificarCancelamentoPedidoHorario(horarioPedidoIso)` | Retorna `[passou30min, minutosRestantes]` — controla a janela de cancelamento de pedidos |

---

## Widgets compartilhados (`src/shared/widget/`)

| Arquivo | Widget | Descrição |
|---------|--------|-----------|
| `CustomNavBar.dart` | `CustomNavBar` | `BottomNavigationBar` com 4 abas (Início, Carrinho, Pedidos, Perfil). Ícone preenchido na aba ativa |
| `appBar.dart` | `CustomAppBar` | AppBar transparente com botão de voltar circular (usado em páginas com imagem de banner) |
| `button.dart` | `CustomButton` | Botão largo padronizado com label e ícone opcional à esquerda |
| `input.dart` | `CustomInput` | Campo de texto com validação integrada. Suporta flags: `isPassword`, `isEmail`, `isPhone`, `isCPF`, `isPhoneOrEmail`. Aplica máscaras automaticamente para CPF e telefone |
| `inputImagem.dart` | `InputFotoPerfil` | Seletor de foto de perfil. Abre bottom sheet com opção câmera/galeria, abre editor de corte (`image_cropper`) após seleção |
| `CardItens.dart` | `CardItens` | Card de item do quiosque com imagem, nome, descrição, preço e controle de quantidade (+/-). Toque navega para `ItemPage` |
| `CustomDivider.dart` | `CustomDivider` | Divisor horizontal com a cor secundária do tema |
| `categorias.dart` | `CategoriasQuiosques` | Chip colorido de categoria. Cada categoria tem um par de cores fixo (fundo + texto) |

---

## Módulos/Telas (`src/modules/`)

### `login/` — Autenticação

- **`login.dart` (`Login`)** — Formulário com e-mail/telefone + senha. Login hardcoded para `teste@gmail.com` / `123`, chama `clienteProvider.login()`. Botão para navegar ao cadastro.
- **`login_email.dart` (`LoginEmail`)** — Tela intermediária de fluxo de login alternativo (não está no roteamento atual, não utilizada).

### `cadastro/` — Cadastro

- **`cadastro.dart` (`Cadastro`)** — Formulário completo: nome, e-mail, telefone, CPF, senha, confirmação de senha e foto de perfil. Ao submeter chama `clienteProvider.login()` (cria a sessão diretamente).

### `inicio/` — Tela principal

- **`inicio.dart` (`HomePage`)** — Lista de quiosques (hardcoded, sem API). Ordena por distância no `initState`. Filtra por nome via `_listaFiltrada`. Separa quiosques que entregam dos que não entregam.
  - `_obterLocalizacao()` — solicita permissão de localização via `ClienteService`.
  - `_listaFiltrada` (getter) — filtra por `_termoBusca`.
  - Suporta ordenação por distância ou avaliação (crescente/decrescente) via `trocaFiltro`.

- **`card_quiosque.dart` (`CardQuiosque`)** — Card de quiosque com imagem, status aberto/fechado (ponto colorido), nota, tempo de espera, distância, horário e categorias. Toque navega para `QuiosquePage`.
  - `imagemBanner()`, `notaQuiosque()`, `infoQuiosque()`, `categoriasQuiosque()` — widgets internos de cada seção do card.

- **`Container_busca.dart` (`ContainerBusca`)** — Cabeçalho da tela de início com saudação, campo de busca e botões de filtro (distância/avaliação) + ordenação (crescente/decrescente).

### `quiosquePage/` — Cardápio do quiosque

- **`quiosquePage.dart` (`QuiosquePage`)** — Exibe banner, status de funcionamento, nota, tempo/distância/horário e lista de itens (`CardItens`). Gerencia `_itensAdicionarCarrinho` (lista temporária antes de ir ao carrinho).
  - `funcionamentoQuiosque()` — badge "Aberto"/"Fechado".
  - `botaoAdicionar()` — botão flutuante animado que aparece quando há itens selecionados; mostra quantidade, "Adicionar ao carrinho" e preço total. Desabilitado se o quiosque estiver fechado ou não entregar.
  - Ao confirmar, chama `carrinhoProvider.adicionarItem()` para cada item e limpa a seleção.

### `itemPage/` — Detalhes do item

- **`itemPage.dart` (`ItemPage`)** — Página detalhada de um item com imagem, descrição, preço, seleção de ingredientes a remover, adicionais opcionais e controle de quantidade.
  - `caixaPreco()` — box com "A partir de R$ X,XX".
  - `alterarQuantidade()` — botões +/- com limites 1–99.
  - `botaoAdicionar()` — adiciona ao `carrinhoProvider` com todos os parâmetros (removidos, adicionais, quantidade). Reset completo do formulário ao adicionar com sucesso.

- **`widget/adicionais.dart` (`Adicionais`)** — Lista de checkboxes animados para selecionar adicionais. Mantém `Set<AdicionaisItem>` e notifica o pai via callback `onChanged`.

- **`widget/removerIngrediente.dart` (`RemoverIngrediente`)** — Lista de checkboxes para marcar ingredientes a remover. Item marcado exibe tachado + label "Removido". Notifica via `onChanged`.

### `carrinho/` — Carrinho de compras

- **`carrinho.dart` (`CarrinhoPage`)** — Exibe itens agrupados por quiosque. `_isSending` bloqueia a UI durante o envio com `ModalBarrier`.
  - `identificadorQuiosque()` — cabeçalho de cada grupo com botão para remover o quiosque inteiro.
  - `itensCarrinho()` — linha de item com nome, quantidade, valor e botão de deletar.
  - `botaoEnviarPedido()` — verifica se está logado antes de pedir; chama `pedidoProvider.criarPedido()` e redireciona para `/pedidos` em caso de sucesso.
  - `_mostrarLoginObrigatorio()` — bottom sheet que aparece se o usuário tentar pedir sem estar logado.

### `pedidos/` — Pedidos ativos

- **`pedidos.dart` (`PedidosPage`)** — Lista os pedidos em andamento do `pedidoProvider`. AppBar tem botão "Finalizar todos" quando há pedidos não-finalizados.
  - `identificadorQuiosque()` — exibe quiosque + status + botão de cancelar.
  - `showBottomModal()` — lógica de cancelamento com 3 estados: antes de 30 min (pode cancelar), dentro dos 30 min (mostra tempo restante), após 30 min (pode cancelar novamente). Usa `verificarCancelamentoPedidoHorario`.
  - `caixaCodigoPedido()` — exibe o código único do pedido em destaque.

### `perfil/` — Perfil do usuário

- **`perfilPage.dart` (`PerfilPage`)** — Exibe nome e foto do usuário. Lista de opções varia conforme login:
  - **Logado:** Modificar perfil, Histórico de pedidos, Ajuda, Sair, Excluir conta.
  - **Deslogado:** Entrar, Cadastrar-se, Ajuda.
  - `confirmarLogout()` e `confirmarExcluirConta()` — bottom sheets de confirmação.

### `modificar_perfil/` — Edição de perfil

- **`modificarPerfilPage.dart` (`ModificarPerfilPage`)** — Formulário pré-preenchido com dados atuais do cliente. `_carregado` evita sobrescrever os controllers enquanto o usuário digita. Salva via `clienteProvider.atualizarPerfil()`.

### `ajuda/` — Central de ajuda

- **`ajudaPage.dart` (`AjudaPage`)** — Lista 5 tópicos de ajuda hardcoded. Cada botão navega para `AjudaTopico`.
- **`ajudaTopico.dart` (`AjudaTopico`)** — Exibe o título do tópico em destaque e a descrição completa.

### `historicoPedidos/` — Histórico

- **`historicoPedidosPage.dart` (`HistoricoPedidos`)** — Usa `historicoProvider` (separado do `pedidoProvider`). Exibe todos os pedidos com data formatada `dd/MM/yyyy`. Para pedidos finalizados mostra o valor total; para outros, mostra o status.
  - `calcularValorTotalPedido(itens)` — soma `valorTotal` de todos os itens e converte de centavos para reais.

---

## Fluxo de dados resumido

```
UI (Widget)
  ↕ watch/read
Provider (Riverpod)
  ↕ chama
Service (regra de negócio)
  ↕ delega
Repository (CRUD)
  ↕ SQL
DatabaseHelper (sqflite)
```