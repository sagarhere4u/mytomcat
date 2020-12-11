FROM centos:6.6

# Adding tom user
RUN groupadd dev
RUN useradd -G dev -d /home/tom -m -s /bin/bash tom 
RUN echo "tomcat123" | passwd tom --stdin

COPY jre-8u45-linux-x64.rpm /tmp/

RUN rpm -ivh /tmp/jre-8u45-linux-x64.rpm

COPY apache-tomcat-6.0.44/ /home/tom/

COPY sample.war /home/tom/webapps/

RUN chmod -R 777 /home/tom && chown -R tom:dev /home/tom

ENV CATALINA_HOME /home/tom
ENV JAVA_HOME /usr
USER tom

EXPOSE 8080
CMD /home/tom/bin/catalina.sh run
