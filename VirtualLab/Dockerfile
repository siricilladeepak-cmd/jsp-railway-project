# Use Tomcat 9 base image
FROM tomcat:9.0

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy JSP/HTML files
COPY WebContent/ /usr/local/tomcat/webapps/ROOT/

# Copy compiled Java classes
COPY build/classes/ /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

# Expose Tomcat default port
EXPOSE 8080