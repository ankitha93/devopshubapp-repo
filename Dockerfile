# image to build a webapp image

FROM tomcat:latest
RUN rm -rf /usr/local/tomcat/webapps
RUN mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps
EXPOSE 8080
COPY target/devopshubapp-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
