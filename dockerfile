FROM alpine AS stage1
RUN apk add git
WORKDIR /opt
RUN git clone https://github.com/shubhamkumar177/tomcatsettings.git
FROM tomcat AS stage2
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
COPY --from="stage1" /opt/tomcatsettings/tomcat-users.xml /usr/local/tomcat/conf
COPY --from="stage1" /opt/tomcatsettings/context.xml /usr/local/tomcat/webapps/manager/META-INF/
COPY ./*.war /usr/local/tomcat/webapps
