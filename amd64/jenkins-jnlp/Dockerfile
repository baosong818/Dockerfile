FROM centos:centos7

ARG VERSION=4.3
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum update -y \
    && yum install -y tar wget git sshpass jq \
    && yum clean all \
    && rm -rf /var/cache/yum
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u251-b08/3d5a2bb8f8d4428bbe94aed7ec7ae784/jdk-8u251-linux-x64.tar.gz" -O /tmp/jdk-8u251-linux-x64.tar.gz \
    && tar -xzvf /tmp/jdk-8u251-linux-x64.tar.gz -C /usr/local/ \
    && rm -f /tmp/jdk-8u251-linux-x64.tar.gz \
    && update-alternatives --install "/usr/bin/java" "java" "/usr/local/jdk1.8.0_251/bin/java" 1
RUN wget --no-check-certificate https://nodejs.org/dist/v12.16.3/node-v12.16.3-linux-x64.tar.xz -O /tmp/node-v12.16.3-linux-x64.tar.xz \
    && tar xvf /tmp/node-v12.16.3-linux-x64.tar.xz -C /usr/local/ \
    && rm -f /tmp/node-v12.16.3-linux-x64.tar.xz \
    && update-alternatives --install "/usr/bin/node" "node" "/usr/local/node-v12.16.3-linux-x64/bin/node" 1 \
    && update-alternatives --install "/usr/bin/npm" "npm" "/usr/local/node-v12.16.3-linux-x64/bin/npm" 1
RUN wget http://mirrors.hust.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -O /tmp/apache-maven-3.6.3-bin.tar.gz \
    && tar xzvf /tmp/apache-maven-3.6.3-bin.tar.gz -C /usr/local/ \
    && rm -f /tmp/apache-maven-3.6.3-bin.tar.gz \
    && update-alternatives --install "/usr/bin/mvn" "mvn" "/usr/local/apache-maven-3.6.3/bin/mvn" 1
COPY kubectl /usr/local/bin/kubectl
COPY settings.xml /usr/local/apache-maven-3.6.3/conf/settings.xml
COPY settings_aliyun.xml /usr/local/apache-maven-3.6.3/conf/settings_aliyun.xml
COPY libcpkdevjni.so /usr/local/jdk1.8.0_251/jre/lib/amd64/libcpkdevjni.so
COPY libcpksoftjni.so /usr/local/jdk1.8.0_251/jre/lib/amd64/libcpksoftjni.so

RUN chown -R root:root /usr/local/apache-maven-3.6.3 /usr/local/node-v12.16.3-linux-x64 /usr/local/jdk1.8.0_251

ENV JAVA_HOME /usr/local/jdk1.8.0_251
ENV JRE_HOME /usr/local/jdk1.8.0_251/jre
ENV NODE_HOME /usr/local/node-v12.16.3-linux-x64
ENV NPM_HOME /usr/local/node-v12.16.3-linux-x64
ENV MAVEN_HOME /usr/local/apache-maven-3.6.3
ENV LANG en_US.UTF-8

RUN groupadd -g ${gid} ${group}
RUN useradd -c "Jenkins user" -d /home/${user} -u ${uid} -g ${gid} -m ${user}
LABEL Description="This is a base image, which provides the Jenkins agent executable (agent.jar)" Vendor="Jenkins project" Version="${VERSION}"
ARG AGENT_WORKDIR=/home/${user}/agent
RUN curl --create-dirs -fsSLo /usr/share/jenkins/agent.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
    && chmod 755 /usr/share/jenkins \
    && chmod 644 /usr/share/jenkins/agent.jar \
    && ln -sf /usr/share/jenkins/agent.jar /usr/share/jenkins/slave.jar
COPY jenkins-agent /usr/local/bin/jenkins-agent
RUN chmod +x /usr/local/bin/jenkins-agent \
    && ln -s /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-slave
USER ${user}
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/${user}/.jenkins && mkdir -p ${AGENT_WORKDIR}
VOLUME /home/${user}/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/${user}

ENTRYPOINT ["jenkins-agent"]
