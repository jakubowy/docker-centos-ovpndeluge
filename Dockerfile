FROM centos:centos7

RUN yum -y install wget && yum clean all && \
	wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && rpm -ivh epel-release-latest-7.noarch.rpm && rm epel-release-latest-7.noarch.rpm && \
	yum -y install openvpn unzip && yum clean all && \
	wget https://www.privateinternetaccess.com/openvpn/openvpn.zip && unzip -o openvpn.zip  Netherlands.ovpn crl.rsa.2048.pem ca.rsa.2048.crt && rm openvpn.zip && \
	sed -i 's/auth-user-pass/auth-user-pass credentials.txt/g' Netherlands.ovpn 
	
#UN yum -y install openvpn unzip && yum clean all
#UN wget https://www.privateinternetaccess.com/openvpn/openvpn.zip && unzip -o openvpn.zip  Netherlands.ovpn crl.rsa.2048.pem ca.rsa.2048.crt && rm openvpn.zip
#RUN sed -i 's/auth-user-pass/auth-user-pass credentials.txt/g' Netherlands.ovpn
ADD files/credentials.txt /credentials.txt
ADD files/startservices.sh /startservices.sh

RUN chmod 0400 credentials.txt && chmod 0700 /startservices.sh
#ENTRYPOINT openvpn --config Netherlands.ovpn &
RUN echo -e "nameserver 209.222.18.222\nnameserver 209.222.18.218" > /etc/resolv.conf

