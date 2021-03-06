FROM debian:buster-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /data/soft/conda/bin:$PATH

RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion && \
    apt-get clean

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda2-2019.10-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /data/soft/conda && \
    rm ~/anaconda.sh && \
    ln -s /data/soft/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /data/soft/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /data/soft/conda/ -follow -type f -name '*.a' -delete && \
    find /data/soft/conda/ -follow -type f -name '*.js.map' -delete && \
    /data/soft/conda/bin/conda clean -afy

CMD [ "/bin/bash" ]
