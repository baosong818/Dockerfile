FROM openjdk:8-jre-alpine

RUN apk update && \
    apk --no-cache add tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

COPY ./libcpkdevjni.so /usr/lib/jvm/java-1.8-openjdk/jre/lib/amd64/libcpkdevjni.so
COPY ./libcpksoftjni.so /usr/lib/jvm/java-1.8-openjdk/jre/lib/amd64/libcpksoftjni.so

RUN mkdir /service
WORKDIR /service

ENTRYPOINT ["java", "-jar", "service.jar"]
