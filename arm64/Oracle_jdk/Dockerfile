FROM centos:centos7

RUN yum update -y \
    && yum install -y tar wget tzdata \
    && wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u251-b08/3d5a2bb8f8d4428bbe94aed7ec7ae784/jdk-8u251-linux-arm64-vfp-hflt.tar.gz
" -O /tmp/jdk-8u251-linux.tar.gz \
    && tar -xzvf /tmp/jdk-8u251-linux.tar.gz -C /usr/local/ \
    && rm -f /tmp/jdk-8u251-linux.tar.gz \
    && update-alternatives --install "/usr/bin/java" "java" "/usr/local/jdk1.8.0_251/bin/java" 1 \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV JAVA_HOME /usr/local/jdk1.8.0_251

COPY ./libcpkdevjni.so /usr/local/jdk1.8.0_251/jre/lib/aarch64/libcpkdevjni.so
COPY ./libcpksoftjni.so /usr/local/jdk1.8.0_251/jre/lib/aarch64/libcpksoftjni.so
