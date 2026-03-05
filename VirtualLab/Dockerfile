# Use official Tomcat 9 image
FROM tomcat:9.0

# Install JDK (required for compiling Java classes)
RUN apt-get update && apt-get install -y openjdk-11-jdk && rm -rf /var/lib/apt/lists/*

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Set working directory inside the container
WORKDIR /usr/src/app

# Copy JSP/HTML files to Tomcat ROOT
COPY WebContent/ /usr/local/tomcat/webapps/ROOT/

# Copy Java source code
COPY src/ src/

# Set CLASSPATH to include servlet API (required to compile servlets)
ENV CLASSPATH=/usr/local/tomcat/lib/servlet-api.jar

# Compile Java classes and preserve package structure
RUN mkdir -p build/classes
RUN javac -d build/classes src/com/virtual/*.java

# Copy compiled classes to Tomcat WEB-INF/classes
RUN cp -r build/classes/* /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
