# Use Tomcat 9 base image
FROM tomcat:9.0

# Install JDK for compilation
RUN apt-get update && apt-get install -y openjdk-11-jdk

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Set working directory
WORKDIR /usr/src/app

# Copy JSP/HTML files
COPY WebContent/ /usr/local/tomcat/webapps/ROOT/

# Copy Java source code
COPY src/ src/

# Set CLASSPATH to Tomcat servlet API for compilation
ENV CLASSPATH=/usr/local/tomcat/lib/servlet-api.jar

# Compile Java classes
RUN mkdir -p build/classes
RUN javac -d build/classes src/com/virtual/*.java

# Copy compiled classes to Tomcat
RUN cp -r build/classes/* /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
