FROM tomcat:10.1-jdk21-temurin
# Remove default ROOT app whic is present in the base image
RUN rm -rf /usr/local/tomcat/webapps/ROOT
#add the user tomcat_docker with uid 10001 
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/bin/false" \
    --no-create-home \
    --uid "${UID}" \
    tomcat_docker


# set ownership to the temp, work and webapps directories in tomcat parent directory
RUN chown -R tomcat_docker:tomcat_docker /usr/local/tomcat/webapps /usr/local/tomcat/temp /usr/local/tomcat/work
# use the user tomcat_docker to run our application
USER tomcat_docker
# Copy the war file to the webapps directory and rename it to ROOT.war
# also set the permissions to read for all users
COPY --chmod=644  target/spring-petclinic-3.5.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
# Exposing port 8080, 
EXPOSE 8080
# Start the tomcat server , catalina.sh as the PID 1 process which must run in forground mode
# so that the container does not exit
CMD ["catalina.sh", "run"]