FROM ubuntu:20.04
LABEL maintainer="HJackH <hjackh67@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y wget unzip python perl
RUN apt-get install -y ttf-mscorefonts-installer fontconfig
# install fonts
RUN apt-get install -y fonts-inconsolata fonts-noto-cjk
RUN apt-get clean

# install minimal texlive
ENV PATH=/tmp/texlive/bin/x86_64-linux:$PATH
COPY texlive texlive
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    rm install-tl-unx.tar.gz && \
    cd install-tl-* && \
    ./install-tl --profile=../texlive/texlive.profile

# install texlive packages
RUN tlmgr install $(cat ./texlive/texlive_packages.txt) && rm -r ./texlive
RUN tlmgr update --self --all --no-auto-install

VOLUME ["/storage"]
WORKDIR /storage
CMD [ "bash" ]
