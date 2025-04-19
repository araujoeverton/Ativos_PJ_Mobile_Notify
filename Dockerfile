# Use uma imagem base com Java (JDK 17 é um bom ponto de partida)
FROM eclipse-temurin:17-jre-alpine

# Defina o diretório de trabalho dentro do container
WORKDIR /app

# Copie o arquivo JAR compilado da sua aplicação (substitua com o nome real)
COPY target/sua-aplicacao.jar app.jar

# Exponha a porta em que sua aplicação Spring Boot está rodando (geralmente 8080)
EXPOSE 8080

# Comando para executar a aplicação quando o container iniciar
ENTRYPOINT ["java", "-jar", "app.jar"]