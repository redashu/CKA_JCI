FROM centos
LABEL "author.name"="ashutoshh"
ARG x=httpd 
# arg can be replace during docker build time even without changing dockerfile
# when the image will be created x variable will not present in the image
ENV app=hello
RUN dnf install $x -y 
RUN mkdir  /common   /common/app1  /common/app2 
COPY  webapp1  /common/app1/ 
COPY  webapp2  /common/app2/  
COPY deploy.sh /common/
WORKDIR  /common
RUN chmod +x  deploy.sh 
EXPOSE 80
ENTRYPOINT  ["./deploy.sh"]