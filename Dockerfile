# image to build a webapp image

FROM tomcat:latest
RUN rm -rf webapps
RUN mv webapps.dist webapps
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
COPY $WORKSPACE/devopshubapp-repo_pipeline/target/devopshubapp-1.0-SNAPSHOT.war /usr/local/tomcat/webapps
