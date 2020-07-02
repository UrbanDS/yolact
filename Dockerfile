FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu16.04
ARG PYTHON_VERSION=3.6
RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         ca-certificates \
         libjpeg-dev \
         libpng-dev && \
     rm -rf /var/lib/apt/lists/*

RUN curl -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include ninja cython typing && \
     /opt/conda/bin/conda install -y -c pytorch magma-cuda100 && \
     /opt/conda/bin/conda install pytorch torchvision cudatoolkit=10.2 -c pytorch&& \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH

RUN /opt/conda/bin/conda install -y pandas scikit-learn matplotlib
RUN pip install cython
RUN pip install opencv-python pillow pycocotools
RUN sudo add-apt-repository main
RUN sudo add-apt-repository universe
RUN sudo add-apt-repository restricted
RUN sudo add-apt-repository multiverse
RUN apt-get update && apt-get install -y --no-install-recommends libwebp libwebp-dev
RUN /opt/conda/bin/conda install -c conda-forge libwebp

#docker tag nlp:casewestern fashui01/nlp:casewestern
#docker push fashui01/nlp:casewestern


#/redis-5.0.0/src/redis-server
#CMD [ "cd", "./redis-5.0.0/src/"]
#CMD ["redis-server"]
