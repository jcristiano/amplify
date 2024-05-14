# Use uma imagem base do Node.js
FROM node:alpine as build

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos do projeto para o diretório de trabalho
COPY . .

# Instala as dependências
RUN npm install

# Compila a aplicação React
RUN npm run build

# Agora, vamos configurar um servidor web para servir os arquivos estáticos da build
FROM nginx:alpine

# Copia os arquivos compilados da aplicação React para o diretório de conteúdo padrão do servidor nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exponha a porta 80 para o tráfego da web
EXPOSE 80

# Comando para iniciar o servidor nginx
CMD ["nginx", "-g", "daemon off;"]

