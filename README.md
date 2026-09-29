# Nexora
Language learning platform based on the supplied UI prototype.

- `apps/learner`: Flutter Android/iOS learner app
- `apps/admin`: Flutter Web admin console
- `apps/api`: NestJS API with Prisma/PostgreSQL contracts
- `docker-compose.yml`: PostgreSQL, SeaweedFS S3 storage, and API

Run `docker compose up --build`, `cd apps/learner && flutter run`, or `cd apps/admin && flutter run -d chrome`.
API health is at `http://localhost:3000/api/health`; the local S3 endpoint is `http://localhost:9000`.
