FROM danhumassmed/base-conda:1.0.2

COPY conda.yml .
RUN mamba env update -n base -f conda.yml && \
    conda clean -a -y && \
    mamba clean -a -y  

RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        unzip \
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

RUN wget https://sourceforge.net/projects/bowtie-bio/files/latest/download/bowtie2-2.5.4-source.zip && \
    unzip bowtie2-2.5.4-source.zip && \
    cd bowtie2-2.5.4 && \
    make install && \
    cd .. && \
    rm -rf bowtie2-2.5.4 && \
    rm bowtie2-2.5.4-source.zip

