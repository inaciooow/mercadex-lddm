# Mercadex

Aplicativo colaborativo para comparação de preços em supermercados.

## Estrutura

```text
mercadex-lddm/
├── backend/    # API REST (NestJS + Prisma)
├── mobile/     # Aplicativo Flutter
└── docker/     # Arquivos auxiliares de infraestrutura
```

## Tecnologias

**Mobile:** Flutter / Dart

**Backend:** NestJS / TypeScript / Prisma

**Banco:** PostgreSQL/PostGIS

**Cache:** Redis

**Infra:** Docker / Docker Compose

## Requisitos

- Node.js 22.22.3 ou compatível com os engines definidos
- Flutter
- Docker Desktop / Docker Engine
- Docker Compose

A versão de Node do repositório está em `.nvmrc`. O backend exige `>=22.22.3` (Nest CLI / Angular DevKit).

## Desenvolvimento

### Docker

Use o `.env` da raiz para infraestrutura (Postgres, Redis e portas publicadas). O Compose injeta no container da API o host `postgres` e no Redis o host `redis`. A porta do Postgres no host é `POSTGRES_PORT` (padrão `5432`); internamente o banco continua em `5432`. Se `5432` já estiver em uso, defina outra porta no `.env`.

```bash
cp .env.example .env
docker compose up --build
```

- API: http://localhost:3001/api/health

### Flutter

```bash
cd mobile
flutter pub get
flutter run
```

### Backend fora do Docker

O backend local no macOS deve apontar para `localhost`, não para o hostname Docker `postgres`. Copie o exemplo de ambiente da API:

```bash
cd backend
cp .env.example .env
npm install
npm run start:dev
```

A API escuta em `PORT` (padrão `3000`) com prefixo `/api`. Se o Postgres/Redis estiverem no Docker, mantenha as portas `5432` e `6379` publicadas e use `DATABASE_URL` / `REDIS_HOST` de `backend/.env.example`.

## Variáveis de ambiente

Há dois arquivos de exemplo:

- `.env.example` (raiz): banco, Redis publicado e portas do Compose.
- `backend/.env.example`: `DATABASE_URL` e Redis para o Node rodando no host (`localhost`).

Não versione secrets. Copie os exemplos para `.env` localmente.
