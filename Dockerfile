FROM gcc:latest

ARG EIGEN_VERSION

RUN echo ${EIGEN_VERSION}
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]