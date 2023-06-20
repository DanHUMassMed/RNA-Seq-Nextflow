FROM continuumio/miniconda3:4.9.2

COPY conda.yml .
RUN \
   conda env update -n root -f conda.yml -v\
&& conda clean -a


