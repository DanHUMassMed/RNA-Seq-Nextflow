FROM danhumassmed/base-conda:1.0.2

RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        zlib1g-dev \
        libncurses-dev \
        libzip-dev \
        libbz2-dev \
        liblzma-dev \
        libcurl4-openssl-dev
 
RUN wget https://github.com/samtools/samtools/releases/download/1.21/samtools-1.21.tar.bz2 && \
    tar xvjf samtools-1.21.tar.bz2 && \
    cd samtools-1.21 && \
    ./configure && \
    make install && \
    cd .. && \
    rm -rf samtools-1.21 && \
    rm samtools-1.21.tar.bz2
    

RUN wget https://github.com/arq5x/bedtools2/releases/download/v2.31.1/bedtools-2.31.1.tar.gz && \
    tar xvzf bedtools-2.31.1.tar.gz && \
    cd bedtools2 && \
    make install && \
    cd .. && \
    rm -rf bedtools2 && \
    rm bedtools-2.31.1.tar.gz

RUN wget https://github.com/marbl/MashMap/releases/download/v2.0/mashmap-Linux64-v2.0.tar.gz && \
    tar xvzf mashmap-Linux64-v2.0.tar.gz && \
    cd mashmap-Linux64-v2.0 && \
    cp mashmap /usr/local/bin && \
    cd .. && \
    rm -rf mashmap-Linux64-v2.0 && \
    rm  mashmap-Linux64-v2.0.tar.gz

COPY conda.yml .
ENV MAMBA_ROOT_PREFIX=/opt/conda
RUN mamba env update -n base -f conda.yml && \
    mamba clean -a -y && \
    conda clean -a -y