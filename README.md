# Mercadex

Aplicativo colaborativo para comparação de preços em supermercados.

## Estrutura

```text
mercadex-lddm/
├── backend/    # Reserved for backend setup
├── mobile/     # Aplicativo Flutter
└── docker/     # Arquivos auxiliares de infraestrutura
```

## Tecnologias

**Mobile:** Flutter / Dart

**Banco:** PostgreSQL/PostGIS

**Infra:** Docker / Docker Compose

## Requisitos

- Flutter
- Docker Desktop / Docker Engine
- Docker Compose

A versão de Node do repositório está em `.nvmrc`. O backend exige `>=22.22.3` (Nest CLI / Angular DevKit).

## Desenvolvimento

### Docker

Use o `.env` da raiz para infraestrutura do Postgres e portas publicadas. A porta do Postgres no host é `POSTGRES_PORT` (padrão `5432`); internamente o banco continua em `5432`. Se `5432` já estiver em uso, defina outra porta no `.env`.

```bash
cp .env.example .env
docker compose up --build
```

### Flutter

```bash
cd mobile
flutter pub get
flutter run
```

## Variáveis de ambiente

`.env.example` da raiz define banco e portas do Compose.

Não versione secrets. Copie os exemplos para `.env` localmente.
