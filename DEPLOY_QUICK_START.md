# 🚀 Deploy Rápido na Railway - Chatwoot

## Início Rápido (5 minutos)

### 1. Preparação
```bash
# Instalar Railway CLI
npm install -g @railway/cli

# Login na Railway
railway login
```

### 2. Deploy Automatizado
```bash
# Execute o script automatizado
./bin/railway-deploy.sh
```

### 3. Configuração Manual (se preferir)
```bash
# Criar projeto
railway new

# Adicionar serviços
railway add --service postgresql
railway add --service redis

# Deploy
railway up
```

### 4. Variáveis Obrigatórias
Configure no painel da Railway:
- `SECRET_KEY_BASE` - Gere com: `openssl rand -hex 64`
- `FRONTEND_URL` - URL do seu app (ex: https://seu-app.railway.app)

### 5. Verificação
```bash
# Ver logs
railway logs

# Abrir app
railway open
```

## ✅ Checklist Pós-Deploy

- [ ] PostgreSQL conectado
- [ ] Redis conectado
- [ ] Variáveis de ambiente configuradas
- [ ] Migrações executadas
- [ ] Worker Sidekiq funcionando
- [ ] Domínio configurado
- [ ] Primeiro usuário criado

## 🔧 Comandos Úteis

```bash
# Executar console Rails
railway run bundle exec rails console

# Executar migrações
railway run bundle exec rails db:migrate

# Reiniciar serviços
railway restart

# Escalar workers
railway up --service worker
```

## 📞 Suporte

Se encontrar problemas, verifique:
1. [Guia Completo](RAILWAY_DEPLOY.md)
2. [Variáveis de Ambiente](railway-env-example.txt)
3. Logs da aplicação: `railway logs` 