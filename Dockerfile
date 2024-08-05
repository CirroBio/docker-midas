FROM conda/miniconda3

ADD https://github.com/czbiohub-sf/MIDAS/archive/refs/tags/v3.tar.gz /usr/local/

RUN conda update -n base -c defaults conda && \
    conda config --set channel_priority flexible && \
    conda create \
        -c zhaoc1 \
        -c conda-forge \
        -c bioconda \
        -c anaconda \
        -c defaults \
        -n midasv3 \
        midasv3=1.0.0

RUN cd /usr/local/ && \
    tar xzvf v3.tar.gz && \
    cd MIDAS-3 && \
    tests/test_analysis.sh 1
