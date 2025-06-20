# Deploy do Chatwoot na Railway

Este guia mostra como fazer o deploy do Chatwoot na Railway.

## Pré-requisitos

1. Conta na Railway (railway.app)
2. CLI da Railway instalado: `npm install -g @railway/cli`
3. Fazer login: `railway login`

## Configuração dos Serviços

### 1. Banco de Dados PostgreSQL

Na Railway, adicione o PostgreSQL:
```bash
railway add --service postgresql
```

### 2. Redis

Adicione o Redis para cache e filas:
```bash
railway add --service redis
```

## Variáveis de Ambiente Necessárias

Configure as seguintes variáveis no painel da Railway:

### Obrigatórias:
- `RAILS_ENV=production`
- `RACK_ENV=production`
- `SECRET_KEY_BASE` (gere uma chave secreta)
- `FRONTEND_URL` (URL do seu app na Railway)
- `INSTALLATION_ENV=railway`

### Redis (configurado automaticamente pela Railway):
- `REDIS_URL` (fornecido pelo serviço Redis)
- `REDIS_OPENSSL_VERIFY_MODE=none`

### PostgreSQL (configurado automaticamente pela Railway):
- `DATABASE_URL` (fornecido pelo serviço PostgreSQL)

### Opcionais para produção:
- `RAILS_LOG_TO_STDOUT=enabled`
- `RAILS_SERVE_STATIC_FILES=true`
- `DISABLE_SPRING=1`

## Deploy

### Método 1: Via CLI

1. Conecte ao projeto Railway:
```bash
railway link
```

2. Deploy:
```bash
railway up
```

### Método 2: Via GitHub

1. Conecte seu repositório GitHub no painel da Railway
2. Configure auto-deploy no branch main
3. Push para o repositório

## Configuração de Domínio

1. No painel da Railway, vá em Settings > Domains
2. Adicione seu domínio personalizado ou use o domínio fornecido
3. Configure `FRONTEND_URL` com o domínio correto

## Comandos Úteis

### Executar migrações:
```bash
railway run bundle exec rails db:migrate
```

### Acessar console Rails:
```bash
railway run bundle exec rails console
```

### Ver logs:
```bash
railway logs
```

### Escalar worker:
```bash
railway up --service worker
```

## Estrutura de Serviços

- **Web**: Servidor Rails principal
- **Worker**: Sidekiq para jobs em background
- **PostgreSQL**: Banco de dados
- **Redis**: Cache e filas

## Troubleshooting

### 1. Erro de Assets
Se houver erro de compilação de assets:
```bash
railway run bundle exec rake assets:precompile
```

### 2. Erro de Permissões Redis
Certifique-se que `REDIS_OPENSSL_VERIFY_MODE=none` está configurado.

### 3. Timeout na Migration
Aumente o timeout do PostgreSQL:
```bash
POSTGRES_STATEMENT_TIMEOUT=600s railway run bundle exec rails db:chatwoot_prepare
```

## Monitoramento

- Use o painel da Railway para monitorar CPU/Memory
- Configure alertas para alta utilização
- Monitore logs para erros

## Backup

Configure backups automáticos do PostgreSQL no painel da Railway:
1. Settings > PostgreSQL
2. Enable Automated Backups
3. Configure retention period

## Custos

- Railway oferece $5 de crédito gratuito por mês
- Monitore uso no painel para evitar surpresas
- Configure limites de uso se necessário 