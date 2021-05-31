FROM centos 
# choosing centos as base os 
# it will be pulled automatically from docker hub if not present in DE 
MAINTAINER  ashutoshh@linux.com
# optional field  but info about Image creator 
RUN  dnf install python3 -y
#  base OS installer is dnf / yum  
# this is the method to install python3 in LInux vm also
RUN  mkdir  /mycode
# creating a directory to store my code 
COPY hello.py  /mycode/
# copy data from Docker client to Docker engine during build process 
CMD  ["python3","/mycode/hello.py"]
# This CMD instruction is to run default parent process 
# whenever we create container from that image 
