FROM ubuntu:latest


RUN apt-get update && apt-get -y install \
   build-essential \
   cmake \
   git \
   libboost-all-dev \
   python2.7 \
   python-pip \
   python-dev \
   swig \
   vim-nox

RUN pip install --upgrade pip
RUN pip install --user --upgrade \
   ipython \
   pytest \
   virtualenvwrapper


RUN echo "export PATH=$PATH:$HOME/.local/bin" >> ~/.bashrc
RUN echo "source $HOME/.local/bin/virtualenvwrapper.sh" >> ~/.bashrc
ENV EDITOR vim

# Build
RUN git clone --recursive -b test http://github.com/joeleong/pypokerstove
WORKDIR /pypokerstove
RUN git apply patches/*.patch
RUN mkdir pokerstove/build
WORKDIR /pypokerstove/pokerstove/build
RUN cmake ../src
RUN make
WORKDIR /pypokerstove
RUN mkdir build
WORKDIR /pypokerstove/build
RUN cmake ..
RUN make
RUN pip install -e .

# Test
WORKDIR /pypokerstove
RUN python -m pytest test
WORKDIR /pypokerstove/pokerstove/build/bin
RUN ./*tests

WORKDIR /pypokerstove
CMD bash
