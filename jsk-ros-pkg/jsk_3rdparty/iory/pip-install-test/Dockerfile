FROM ubuntu:14.04

LABEL maintainer "iory <ab.ioryz@gmail.com>"

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    python-pip

RUN python -m pip install -U pip && \
    python -m pip install -U numpy

RUN DEBIAN_FRONTEND=noninteractive apt install -y \
    python-numpy

CMD ["bash"]
