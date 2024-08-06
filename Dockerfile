FROM public.ecr.aws/ubuntu/ubuntu:24.04_stable
ADD https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh /usr/local
RUN cd /usr/local && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b -p /usr/local/miniconda3 && \
    rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH="/usr/local/miniconda3/bin:${PATH}"

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
    conda run -n midasv3 /bin/bash tests/test_analysis.sh 1
