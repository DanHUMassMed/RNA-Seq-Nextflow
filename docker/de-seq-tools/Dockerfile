FROM danhumassmed/base-conda:1.0.1

COPY conda.yml .
RUN mamba env update -n root -f conda.yml

RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        unzip \
        zip

RUN mkdir -p /usr/local/homer && \
    cd /usr/local/homer && \
    wget http://homer.ucsd.edu/homer/configureHomer.pl && \
    perl /usr/local//homer/configureHomer.pl -install && \
    perl ./configureHomer.pl -install worm-p && \
    perl ./configureHomer.pl -install worm-o && \
    perl ./configureHomer.pl -install ce11 && \
    echo "export PATH=\$PATH:/usr/local/homer/bin/" >> ~/.bashrc

