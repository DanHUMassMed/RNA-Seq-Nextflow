FROM continuumio/miniconda3:4.10.3

RUN apt-get update && apt-get install -y libarchive13

RUN conda install -c conda-forge -n root mamba \
&& conda clean -a


