# Use Tomcat 9 base image
FROM tomcat:9.0

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Set working directory
WORKDIR /usr/src/app

# Copy JSP/HTML files
COPY WebContent/ ./WebContent/

# Copy Java source files
COPY src/ ./src/

# Create build directory
RUN mkdir -p build/classes

# Compile Java classes with servlet-api
RUN javac -cp /usr/local/tomcat/lib/servlet-api.jar -d build/classes src/com/virtual/*.java

# Copy compiled classes to Tomcat WEB-INF/classes
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes
RUN cp -r build/classes/* /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

# Copy JSP/HTML into ROOT webapp
RUN cp -r WebContent/* /usr/local/tomcat/webapps/ROOT/

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
