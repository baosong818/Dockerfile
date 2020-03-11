FROM centos:centos7

RUN yum update -y \
    && yum install -y tar wget \
    && wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u241-b07/1f5b5a70bf22433b84d0e960903adac8/jdk-8u241-linux-x64.tar.gz" -O /tmp/jdk-8u241-linux-x64.tar.gz \
    && tar -xzvf /tmp/jdk-8u241-linux-x64.tar.gz -C /usr/local/ \
    && rm -f /tmp/jdk-8u241-linux-x64.tar.gz \
    && update-alternatives --install "/usr/bin/java" "java" "/usr/local/jdk1.8.0_241/bin/java" 1 \
    && yum clean all \
    && rm -rf /var/cache/yum

ENV JAVA_HOME /usr/local/jdk1.8.0_241

CMD ["/bin/bash"]
