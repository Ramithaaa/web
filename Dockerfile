FROM ubuntu:latest AS IMAGE
RUN apt update && apt install wget unzip -y
RUN wget https://www.tooplate.com/zip-templates/2129_crispy_kitchen.zip
RUN unzip 2129_crispy_kitchen.zip
RUN  cd 2129_crispy_kitchen && tar -czf crispy_kitchen.tgz * && mv crispy_kitchen.tgz /root/crispy_kitchen.tgz

FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install apache2 git wget -y
COPY --from=IMAGE /root/crispy_kitchen.tgz /var/www/html
RUN cd /var/www/html && tar xzf crispy_kitchen.tgz

CMD ["/usr/sbin/apache2ctl","-D","FOREGROUND"]
VOLUME /var/log/apache2
WORKDIR /var/www/html

EXPOSE 80

