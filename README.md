# API Node.js com MySQL

Este é um exemplo de um projeto de API em Node.js utilizando o MySQL com fins educativos. O objetivo deste projeto é demonstrar como criar uma API simples para gerenciar usuários. Você pode usar este projeto como referência para aprender os conceitos básicos de desenvolvimento de APIs com Node.js e MySQL.

## Ambiente desenvolvimento
``` bash
docker-compose up -d
```

``` bash
chmod +x start.sh
```

``` bash
./start.sh 
```

## Imagem Docker Hub
``` bash
docker pull abelgasque/security-api
```

``` bash
docker run -d -p 80:80 abelgasque/security-api
```

### Requisitos
Certifique-se de ter os seguintes requisitos instalados em seu ambiente de desenvolvimento:

- Node.js (versão 18 ou superior)
- Docker
- Git (opcional, se você quiser clonar este repositório)

### Configuração
1- Clone o repositório (caso não tenha feito anteriormente):
``` bash
git clone https://github.com/abelgasque/security-api.git
cd security-api
```

2- Instale as dependências do projeto:
``` bash
npm install
```

3- Variáveis de ambiente necessárias estão no arquivo `.env-exemple` e precisa ser renomeado para `.env`.

4- Execute o seguinte comando para aplicar migrações e criar ou atualizar as tabelas no banco de dados:
``` bash
npx sequelize-cli db:migrate
```

5- Use o seguinte comando para adicionar dados iniciais ao banco de dados:
``` bash
npx sequelize-cli db:seed:all
```

6- Inicie o servidor:
``` bash
npm run start
```

Agora, o servidor estará em execução na porta 9090 (ou na porta que você especificou no arquivo index.js).

### Endpoints
A API possui os seguintes endpoints para gerenciar usuários:

- GET /users: Recupera a lista de todos os usuários.
- GET /users/:id: Recupera um usuário pelo ID.
- POST /users: Cria um novo usuário.
- PATCH /users/:id: Atualiza um usuário existente pelo ID.
- DELETE /users/:id: Exclui um usuário pelo ID.

### Uso
Você pode testar a API utilizando uma ferramenta como o Postman ou fazendo requisições HTTP a partir de qualquer cliente. Certifique-se de seguir os padrões RESTful para interagir com os endpoints.

Para maior comodidade, na raiz do projeto, você encontrará o arquivo `postman_collection.json` que contém todas as requisições pré-configuradas para o Postman. Basta importar este arquivo no aplicativo do Postman para começar a testar a API imediatamente. Isso facilitará a sua interação com os endpoints e permitirá que você explore todas as funcionalidades da API de forma mais eficiente.


Isso iniciará um contêiner Docker com sua aplicação, mapeando a porta 80 do contêiner para a porta 80 do seu sistema host. Isso permitirá que você acesse sua aplicação através do endereço http://localhost.

Com esses passos, sua aplicação estará implantada e em execução em um ambiente de desenvolvimento Docker, pronto para ser testada e depurada conforme necessário. Certifique-se de adaptar os comandos e as configurações conforme apropriado para o seu projeto específico.

### Contribuindo
Sinta-se à vontade para contribuir com melhorias, correções de bugs ou adicionar novos recursos a este projeto. Basta fazer um fork deste repositório, fazer suas alterações e enviar um pull request.

### Licença
Este projeto é distribuído sob a licença MIT, o que significa que você pode usá-lo, modificá-lo e distribuí-lo livremente.

Lembre-se de que este é apenas um projeto de exemplo com fins educativos e não é adequado para uso em ambientes de produção sem a devida segurança e otimizações. Certifique-se de seguir as melhores práticas de segurança e desempenho ao desenvolver sua própria aplicação em Node.js e MySQL.