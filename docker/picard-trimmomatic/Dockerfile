FROM danhumassmed/base-conda:1.0.1

COPY conda.yml .
RUN mamba env update -n base -f conda.yml && \
    mamba clean -a -y && \
    conda clean -a -y
