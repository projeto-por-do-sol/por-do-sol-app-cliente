# Endpoints da API — Por do Sol

Base URL: `http://localhost:8080`

Todas as requisições autenticadas devem incluir o header:
```
Authorization: Bearer <token>
```

---

## Autenticação

| Método | Endpoint | Role |
|---|---|---|
| `POST` | `/auth/login` | público |
| `POST` | `/auth/register` | FUNCIONARIO, CLIENTE |
| `GET` | `/me` | FUNCIONARIO, CLIENTE |
| `PUT` | `/me` | FUNCIONARIO, CLIENTE |
| `PATCH` | `/me` | autenticado |
| `DELETE` | `/me` | FUNCIONARIO, CLIENTE |
| `POST` | `/me/notification-token` | FUNCIONARIO, CLIENTE |
| `POST` | `/me/imagem` | FUNCIONARIO, CLIENTE |
| `DELETE` | `/me/imagem` | FUNCIONARIO, CLIENTE |

---

## Quiosques

| Método | Endpoint | Role |
|---|---|---|
| `GET` | `/quiosques/nearby?latUsuario=&lonUsuario=&raioM=` | público |
| `GET` | `/quiosques/{id}` | público |
| `POST` | `/quiosques` | PROPRIETARIO |
| `GET` | `/quiosques/me` | FUNCIONARIO |
| `PUT` | `/quiosques/me` | GERENTE |
| `PATCH` | `/quiosques/me/status` | GERENTE |
| `DELETE` | `/quiosques/me` | PROPRIETARIO |
| `POST` | `/quiosques/me/imagem` | GERENTE |
| `DELETE` | `/quiosques/me/imagem` | GERENTE |

---

## Categorias

| Método | Endpoint | Role |
|---|---|---|
| `GET` | `/quiosques/{id}/categorias` | público |
| `POST` | `/quiosques/me/categorias` | FUNCIONARIO |
| `PUT` | `/quiosques/me/categorias/{id}` | FUNCIONARIO |
| `DELETE` | `/quiosques/me/categorias/{id}` | FUNCIONARIO |

---

## Itens

| Método | Endpoint | Role |
|---|---|---|
| `GET` | `/quiosques/itens/{id}` | público |
| `POST` | `/quiosques/me/categorias/{id_categoria}/itens` | FUNCIONARIO |
| `PUT` | `/quiosques/me/categorias/{id_categoria}/itens/{id}` | FUNCIONARIO |
| `DELETE` | `/quiosques/me/categorias/{id_categoria}/itens/{id}` | FUNCIONARIO |
| `POST` | `/quiosques/me/categorias/{id_categoria}/itens/{id}/imagem` | FUNCIONARIO |
| `DELETE` | `/quiosques/me/categorias/{id_categoria}/itens/{id}/imagem` | FUNCIONARIO |

---

## Acompanhamentos

| Método | Endpoint | Role |
|---|---|---|
| `GET` | `/quiosques/me/acompanhamentos` | FUNCIONARIO |
| `POST` | `/quiosques/me/acompanhamentos` | FUNCIONARIO |
| `PUT` | `/quiosques/me/acompanhamentos/{id}` | FUNCIONARIO |
| `DELETE` | `/quiosques/me/acompanhamentos/{id}` | FUNCIONARIO |

---

## Pedidos — Cliente

| Método | Endpoint | Role |
|---|---|---|
| `GET` | `/pedidos?status=` | CLIENTE |
| `GET` | `/pedidos/ativos` | CLIENTE |
| `POST` | `/pedidos` | FUNCIONARIO, CLIENTE |
| `POST` | `/pedidos/{id}/cancelar` | FUNCIONARIO, CLIENTE |
| `GET` | `/pedidos/{id}/codigo` | CLIENTE |
| `POST` | `/pedidos/{id}/avaliar` | CLIENTE |

---

## Pedidos — Quiosque / Entregador

| Método | Endpoint | Role |
|---|---|---|
| `GET` | `/pedidos/{id}` | FUNCIONARIO |
| `POST` | `/pedidos/{id}/validar-codigo` | FUNCIONARIO |
| `GET` | `/quiosques/me/pedidos?status=` | FUNCIONARIO |
| `GET` | `/quiosques/me/pedidos/ativos` | FUNCIONARIO |
| `GET` | `/quiosques/me/pedidos/entregar` | FUNCIONARIO |
| `POST` | `/quiosques/me/pedidos/{id}/entregador` | FUNCIONARIO |
| `PATCH` | `/quiosques/me/pedidos/{id}` | FUNCIONARIO |
| `PATCH` | `/quiosques/me/pedidos/{id}/rejeitar` | FUNCIONARIO |
| `POST` | `/quiosque/me/pedidos/{id}/cancelar` | FUNCIONARIO, CLIENTE |

---

## Funcionários

| Método | Endpoint | Role |
|---|---|---|
| `GET` | `/quiosques/me/funcionarios` | GERENTE |
| `POST` | `/quiosques/me/funcionarios` | GERENTE |
| `GET` | `/quiosques/me/funcionarios/{id}` | GERENTE |
| `PUT` | `/quiosques/me/funcionarios/{id}` | GERENTE |
| `DELETE` | `/quiosques/me/funcionarios/{id}` | GERENTE |
| `POST` | `/quiosques/me/funcionarios/{id}/reset-password` | GERENTE |
| `POST` | `/quiosques/me/funcionarios/{id}/imagem` | GERENTE |
| `DELETE` | `/quiosques/me/funcionarios/{id}/imagem` | GERENTE |
