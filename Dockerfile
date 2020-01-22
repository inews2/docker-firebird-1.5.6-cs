FROM debian:buster
MAINTAINER inews2 <innovationnews@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y apt-utils procps curl libc6:i386 libncurses5:i386 libstdc++5:i386 vim nano xinetd \
    && curl -SL "http://downloads.sourceforge.net/project/firebird/firebird-linux-i386/1.5.6-Release/FirebirdCS-1.5.6.5026-0.i686.tar.gz" -o firebird.tar.gz \
    && mkdir -p /usr/src/firebird \
    && tar -xvf firebird.tar.gz -C /usr/src/firebird --strip-components=1 \
    && rm firebird.tar.gz \
    && cd /usr/src/firebird \
    && sed -i "141s/^/# /" install.sh \
    && sed -i "141s/^/# /" scripts/tarMainInstall.sh \
    && sed -i "323s/^/# /" scripts/postinstall.sh \
    && sed -i "237,238s/^/# /" scripts/postinstall.sh \
    && sed -i "313aNewPasswd=masterkey" scripts/postinstall.sh \
    && sh install.sh \
    && rm -rf /usr/src/firebird 

ENV PATH $PATH:/opt/firebird/bin

ADD librfunc.so /opt/firebird/UDF/librfunc.so
RUN chmod +x /opt/firebird/UDF/librfunc.so

#ADD run.sh /opt/firebird/run.sh
#RUN chmod +x /opt/firebird/run.sh

VOLUME /data
VOLUME /backup
VOLUME /opt/firebird

EXPOSE 3050/tcp

ENTRYPOINT ["script", "-c", "xinetd -d -dontfork"]
