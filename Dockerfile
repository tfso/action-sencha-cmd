FROM openjdk:8-jre-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        openssl \
        libssl-dev \
        curl \
        unzip \
		libfreetype6 \
		fontconfig \
	&& rm -rf /var/lib/apt/lists/*

# Installing SenchaCmd
RUN curl --silent http://cdn.sencha.com/cmd/7.3.0.19/no-jre/SenchaCmd-7.3.0.19-linux-amd64.sh.zip -o /tmp/sencha.zip && \
    unzip /tmp/sencha.zip -d /tmp  && \
    unlink /tmp/sencha.zip  && \
    chmod o+x /tmp/SenchaCmd-7.3.0.19-linux-amd64.sh && \
    /tmp/SenchaCmd-7.3.0.19-linux-amd64.sh -q -dir /opt/Sencha/Cmd/7.3.0.19 && \
    unlink /tmp/SenchaCmd-7.3.0.19-linux-amd64.sh

WORKDIR /app

ENV PATH="/opt/Sencha/Cmd:${PATH}"
ENV OPENSSL_CONF=/etc/ssl/
ENV LD_LIBRARY_PATH=/usr/lib:/usr/local/lib
ENV PATH="/opt/Sencha/Cmd:${PATH}"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]