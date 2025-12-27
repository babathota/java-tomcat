FROM tomcat:10.1-jdk21-temurin
# Remove default ROOT app
RUN rm -rf /usr/local/tomcat/webapps/ROOT
# Copy generated WAR as ROOT.war so it's deployed at "/"
COPY target/spring-petclinic-3.5.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]