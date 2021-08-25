FROM gcc:latest

RUN apt-get -qq update
RUN apt-get -qq install cmake jq -y

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]