FROM docker:1.12.1

RUN apk add --update bash git py-pip

RUN pip install docker-compose

COPY nproc /usr/local/bin/nproc

CMD ["bash"]
