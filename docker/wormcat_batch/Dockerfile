FROM danhumassmed/base-conda:1.0.1

RUN apt-get update -q && \
    apt-get install -y --no-install-recommends \
        libxml2-dev \
        libssl-dev  \
        libcurl4-openssl-dev \
        libfontconfig1-dev \
        libcairo2-dev

COPY conda.yml .
RUN mamba env update -n root -f conda.yml

RUN R -e "library('devtools'); install_github('trinker/plotflow')"
RUN R -e "library('devtools'); install_github('dphiggs01/wormcat')"

RUN mamba install -y -c anaconda openpyxl pandas && \
    pip install wormcat_batch==1.0.8 --no-input