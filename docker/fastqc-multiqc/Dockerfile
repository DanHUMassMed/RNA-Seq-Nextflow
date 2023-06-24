FROM danhumassmed/base-conda:1.0.1

RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        default-jre \
        unzip 


RUN cd /usr/local && \
    wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip && \
    unzip fastqc_v0.12.1.zip && \
    rm fastqc_v0.12.1.zip && \
    chmod 755 /usr/local/FastQC/fastqc && \
    ln -s /usr/local/FastQC/fastqc /usr/local/bin/fastqc 


COPY conda.yml .
RUN mamba env update -n root -f conda.yml