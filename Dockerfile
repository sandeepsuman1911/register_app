#FROM tomcat:latest
#RUN cp -R  /usr/local/tomcat/webapps.dist/*  /usr/local/tomcat/webapps
#COPY ./target/webapp.war /usr/local/tomcat/webapps/

# First stage: build the WAR file
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package

# Second stage: build the final image
FROM tomcat:latest
COPY --from=builder /app/webapp/target/webapp.war /usr/local/tomcat/webapps/

