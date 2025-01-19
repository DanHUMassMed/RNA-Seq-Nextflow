FROM danhumassmed/base-conda:1.0.2


RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        unzip \
        zip \
        libicu-dev \
        zlib1g-dev \
        libbz2-dev \
        liblzma-dev \
        libcurl4-openssl-dev \
        libncurses-dev

RUN wget https://github.com/samtools/samtools/releases/download/1.21/samtools-1.21.tar.bz2 && \
    tar xvjf samtools-1.21.tar.bz2 && \
    cd samtools-1.21 && \
    ./configure && \
    make install && \
    cd .. && \
    rm -rf samtools-1.21 && \
    rm samtools-1.21.tar.bz2

COPY conda.yml .
RUN mamba env update -n base -f conda.yml && \
    conda clean -a -y && \
    mamba clean -a -y

RUN mkdir -p /usr/local/homer && \
    cd /usr/local/homer && \
    wget http://homer.ucsd.edu/homer/configureHomer.pl && \
    perl /usr/local/homer/configureHomer.pl -install && \
    perl ./configureHomer.pl -install worm-p && \
    perl ./configureHomer.pl -install worm-o && \
    perl ./configureHomer.pl -install ce11 && \
    echo "export PATH=\$PATH:/usr/local/homer/bin/" >> ~/.bashrc

RUN R -e "install.packages('stringi', configure.args='--disable-pkg-config', repos='https://cran.r-project.org')"

RUN wget https://downloads.rclone.org/v1.69.0/rclone-v1.69.0-linux-amd64.zip && \
    unzip rclone-v1.69.0-linux-amd64.zip && \
    mv rclone-v1.69.0-linux-amd64/rclone /usr/local/bin && \
    rm -rf rclone-v1.69.0-linux-amd64.zip.1 && \
    rm -rf rclone-v1.69.0-linux-amd64



