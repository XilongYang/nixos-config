FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libssl3 libcurl4 ca-certificates && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /srv/minecraft
ENTRYPOINT ["./bedrock_server"]
