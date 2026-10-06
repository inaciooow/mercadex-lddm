# Arquitetura atual

O Mercadex é um protótipo de comparação colaborativa de preços em supermercados. A organização abaixo descreve o código desta branch, sem antecipar tecnologias que ainda não entram no fluxo.

## Mobile

- Flutter e Dart
- Riverpod para estado
- GoRouter, com `StatefulShellRoute` na navegação inferior
- Repositórios por feature (`auth`, `products`, `markets`)
- Dados vindos de mocks locais ou da API HTTP, escolhidos por `AppConfig`

`USE_MOCK_DATA` vale `true` por padrão. Com `USE_MOCK_DATA=false`, os repositórios usam `API_URL`.

O scanner de código de barras usa o pacote `mobile_scanner` e o widget `MobileScanner` na página do scanner. A lista de compras vive em memória, no provider da feature. O formulário de informar preço ainda não envia nem persiste o valor.

## Backend

- NestJS, organizado por domínio: `auth`, `favorites`, `markets`, `products`, `search` e `prisma`
- Prisma como acesso ao banco
- PostgreSQL

## Fluxo

```text
Flutter
  → Repository
  → Mock ou HTTP API
  → NestJS
  → Prisma
  → PostgreSQL
```

Novas tecnologias entram somente quando uma entrega precisar delas.
