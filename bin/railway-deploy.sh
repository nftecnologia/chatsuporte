#!/bin/bash

# Script de Deploy para Railway - Chatwoot
# Este script automatiza o processo de deploy na Railway

set -e

echo "🚀 Iniciando deploy do Chatwoot na Railway..."

# Verificar se a Railway CLI está instalada
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI não encontrada. Instalando..."
    npm install -g @railway/cli
fi

# Verificar se está logado na Railway
if ! railway whoami &> /dev/null; then
    echo "🔐 Faça login na Railway:"
    railway login
fi

# Gerar SECRET_KEY_BASE se não existir
if [ -z "$SECRET_KEY_BASE" ]; then
    echo "🔑 Gerando SECRET_KEY_BASE..."
    SECRET_KEY_BASE=$(openssl rand -hex 64)
    echo "SECRET_KEY_BASE gerado: $SECRET_KEY_BASE"
    echo "Configure esta variável no painel da Railway!"
fi

# Verificar se o projeto está conectado
if ! railway status &> /dev/null; then
    echo "🔗 Conectando ao projeto Railway..."
    railway link
fi

echo "📦 Fazendo deploy..."
railway up

echo "🎯 Configurando variáveis de ambiente necessárias..."
railway variables set RAILS_ENV=production
railway variables set RACK_ENV=production
railway variables set RAILS_LOG_TO_STDOUT=enabled
railway variables set RAILS_SERVE_STATIC_FILES=true
railway variables set INSTALLATION_ENV=railway
railway variables set REDIS_OPENSSL_VERIFY_MODE=none
railway variables set DISABLE_SPRING=1

echo "🗄️ Executando migrações do banco de dados..."
railway run "POSTGRES_STATEMENT_TIMEOUT=600s bundle exec rails db:chatwoot_prepare"

echo "✅ Deploy concluído!"
echo ""
echo "📋 Próximos passos:"
echo "1. Configure FRONTEND_URL no painel da Railway com sua URL"
echo "2. Configure SECRET_KEY_BASE no painel da Railway"
echo "3. Verifique se PostgreSQL e Redis estão configurados"
echo "4. Acesse sua aplicação e faça o primeiro login"
echo ""
echo "🔍 Para ver logs: railway logs"
echo "🌐 Para abrir no navegador: railway open" 