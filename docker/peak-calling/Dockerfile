FROM danhumassmed/base-conda:1.0.1
# macs2=2.2.9.1 bioconda has no build for python 3.12

COPY conda.yml .

ENV MAMBA_ROOT_PREFIX=/opt/conda

RUN mamba env update -n base -f conda.yml && \
    mamba clean -a -y && \
    conda clean -a -y

RUN pip install deeptools==3.5.5 