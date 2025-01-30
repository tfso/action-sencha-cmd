FROM openjdk:8-jre-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        openssl \
        libssl-dev \
        curl \
        unzip \
		libfreetype6 \
		fontconfig \
	&& rm -rf /var/lib/apt/lists/*

RUN curl --silent http://cdn.sencha.com/cmd/6.7.0.63/no-jre/SenchaCmd-6.7.0.63-linux-amd64.sh.zip -o /tmp/sencha.zip && \
    unzip /tmp/sencha.zip -d /tmp  && \
    unlink /tmp/sencha.zip  && \
    chmod o+x /tmp/SenchaCmd-6.7.0.63-linux-amd64.sh && \
    /tmp/SenchaCmd-6.7.0.63-linux-amd64.sh -q -dir /opt/Sencha/Cmd/6.7.0.63 && \
    unlink /tmp/SenchaCmd-6.7.0.63-linux-amd64.sh

WORKDIR /app

ENV OPENSSL_CONF=/etc/ssl/
ENV LD_LIBRARY_PATH=/usr/lib:/usr/local/lib
ENV PATH="/opt/Sencha/Cmd:${PATH}"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]