#!/bin/bash
set -e

echo "🚀 Iniciando Chatwoot na Railway..."

# Configurar IP lookup
echo "📍 Configurando IP lookup..."
bundle exec rails ip_lookup:setup

# Verificar se o banco existe e executar migrações se necessário
if bundle exec rails runner "ActiveRecord::Base.connection" 2>/dev/null; then
    echo "📊 Banco de dados detectado, verificando migrações..."
    
    # Verificar se há migrações pendentes
    if bundle exec rails db:migrate:status | grep -q "down"; then
        echo "⬆️ Executando migrações pendentes..."
        POSTGRES_STATEMENT_TIMEOUT=600s bundle exec rails db:chatwoot_prepare
    else
        echo "✅ Banco de dados atualizado"
    fi
else
    echo "🔧 Primeira execução - configurando banco de dados..."
    POSTGRES_STATEMENT_TIMEOUT=600s bundle exec rails db:chatwoot_prepare
fi

echo "🌐 Iniciando servidor Rails na porta $PORT..."
exec bundle exec rails server -p $PORT -e $RAILS_ENV 