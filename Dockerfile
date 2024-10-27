FROM r-base:4.4.1

RUN apt-get update && apt-get install -y tree jupyter-client

WORKDIR /tmp

COPY setup-r-project .

CMD ["Rscript","setup-r-project","--kernel-name","my-test-kernel","--directory","/tmp/my-test-project/"]
