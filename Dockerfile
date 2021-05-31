FROM ubuntu:20.04
LABEL maintainer="HJackH <hjackh67@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y wget unzip python perl
RUN apt-get install -y ttf-mscorefonts-installer fontconfig
RUN apt-get clean

# install Inconsolata font
RUN mkdir /tmp/inconsolata && \
    cd /tmp/inconsolata && \
    wget -O inconsolata.zip https://fonts.google.com/download?family=Inconsolata && \
    unzip inconsolata.zip && \
    mkdir -p /usr/share/fonts/inconsolata && \
    mv -t /usr/share/fonts/inconsolata ./static/*/*.ttf && \
    rm -r /tmp/inconsolata && \
    cd /usr/share/fonts/inconsolata && \
    mkfontscale && mkfontdir && fc-cache -fv

# install NotoSansCJK font
RUN mkdir /tmp/noto && \
    cd /tmp/noto && \
    wget -O NotoSansCJKtc-hinted.zip https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKtc-hinted.zip && \
    unzip NotoSansCJKtc-hinted.zip && \
    mkdir /usr/share/fonts/noto && \
    mv -t /usr/share/fonts/noto *.otf && \
    rm -r /tmp/noto && \
    fc-cache -fv 

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
