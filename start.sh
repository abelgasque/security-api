#!/bin/bash

# Inicializa o ambiente com o docker-compose
echo "Inicializando o ambiente local..."

# Defina variáveis
MYSQL_USER="root"
MYSQL_PASSWORD="root"
MYSQL_DATABASE="core_db"
MYSQL_DATABASE_SUPERSET="superset_db"
MYSQL_CONTAINER_NAME="mysql"

# Função para verificar se o MySQL está pronto
wait_for_mysql() {
  echo "Aguardando o MySQL iniciar..."
  until docker exec $MYSQL_CONTAINER_NAME mysqladmin -u$MYSQL_USER -p$MYSQL_PASSWORD ping --silent; do
    echo "Esperando o MySQL ficar disponível..."
    sleep 10  # Espera mais tempo entre as tentativas
  done
  echo "MySQL está pronto para receber comandos."
}

# Chama a função para aguardar o MySQL
wait_for_mysql

# Logs
echo "Iniciando o script de inicialização do MySQL..."

# Rodar os comandos MySQL
docker exec -i $MYSQL_CONTAINER_NAME mysql -u$MYSQL_USER -p$MYSQL_PASSWORD <<EOF
-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_SUPERSET;
SELECT 'Banco de dados criado.' AS status;

-- Permissões para o usuário root
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
SELECT 'Permissões do usuário root configuradas.' AS status;

-- Criar usuário admin e dar permissões no banco core_db
CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO 'admin'@'%' WITH GRANT OPTION;
SELECT 'Usuário admin criado e permissões configuradas.' AS status;

-- Finaliza o processo de atualização de permissões
FLUSH PRIVILEGES;
SELECT 'Permissões atualizadas.' AS status;
EOF

if [ $? -eq 0 ]; then
  # Executa o comando para fazer upgrade do banco de dados no Superset
  echo "Executando upgrade do banco de dados no Superset..."
  docker exec superset superset db upgrade

  # Cria o usuário administrador do Superset
  echo "Criando usuário administrador do Superset..."
  docker exec superset superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password admin

  # Inicializa o Superset
  echo "Inicializando o Superset..."
  docker exec superset superset init

  echo "Comandos SQL executados com sucesso!"
else
  echo "Erro ao executar os comandos SQL."
  docker-compose down
  exit 1
fi