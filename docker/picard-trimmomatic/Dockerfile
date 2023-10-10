FROM danhumassmed/base-conda:1.0.1

COPY conda.yml .
RUN mamba env update -n root -f conda.yml
RUN mamba install -c bioconda fastp --yes