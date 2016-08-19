## Emacs, make this -*- mode: sh; -*-
### RNEURO
FROM ubuntu:wily

## Set a default user. Available via runtime flag `--user docker` 
## Add user to 'staff' group, granting them write privileges to /usr/local/lib/R/site.library
## User should also have & own a home directory (for rstudio or linked volumes to work properly). 
RUN useradd docker \
    && mkdir /home/docker \
    && chown docker:docker /home/docker \
    && addgroup docker staff

RUN apt-get update \ 
    && apt-get install -y --no-install-recommends \
        less \
        locales \
        wget \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV R_BASE_VERSION 3.3.1

## Now install R and littler, and create a link for littler in /usr/local/bin
## Also set a default CRAN repo, and make sure littler knows about it too
RUN apt-get update \ 
    && apt-get install -y --no-install-recommends \
        littler \
        r-base 

RUN apt-get install -y build-essential    

RUN apt-get update \
    && apt-get install -y \
    libssl-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libssh2-1-dev \
    libpq-dev \
    libxml2-dev

RUN echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"), download.file.method = "wget")' >> /etc/R/Rprofile.site \
        && echo 'source("/etc/R/Rprofile.site")' >> /etc/littler.r \
    && ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin/install.r \
    && ln -s /usr/share/doc/littler/examples/install2.r /usr/local/bin/install2.r \
    && ln -s /usr/share/doc/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
    && ln -s /usr/share/doc/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
    && install.r docopt \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
    && rm -rf /var/lib/apt/lists/*

# RUN install.r getopt

## Install the Hadleyverse packages (and some close friends). 
RUN install.r \
    devtools 
    # \
    # xml2 \
    # dplyr \
    # base64enc \
    # readr


## Manually install (useful packages from) the SUGGESTS list of the above packages.
## (because --deps TRUE can fail when packages are added/removed from CRAN)
# RUN install.r \
#     data.table \
#     downloader \
#     git2r \
#     MASS \
#     Rcpp \
#     roxygen2 \
#   && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN r -e 'devtools::install_github("muschellij2/oro.nifti")' 

RUN r -e 'library(utils); source("http://bioconductor.org/biocLite.R"); biocLite(pkgs = c("Biobase"), suppressUpdates = TRUE, suppressAutoUpdate = TRUE, ask = FALSE)'

RUN r -e 'devtools::install_github("muschellij2/fslr", ref = "7a2136dd087b1e4f1969c1e32176ae52ea0c8cb3")' 

RUN r -e 'devtools::install_github("stnava/cmaker")' 

RUN apt-get update && \
apt-get install -y git-core

# RUN r -e 'devtools::install_github("stnava/ITKR")' 

# RUN r -e 'devtools::install_github("stnava/ANTsR")'    


RUN apt-get build-dep -y r-cran-rgl 

RUN wget http://www.cmake.org/files/v2.8/cmake-2.8.9.tar.gz \
&& tar xzvf cmake-2.8.9.tar.gz \
&& cd cmake-2.8.9 \
&& ./configure \
&& make \
&& make install \ 
&& cd ../

RUN apt-get install -y cmake-curses-gui

# RUN r -e 'devtools::install_github("muschellij2/extrantsr", ref = "337095449ce0fa7b85be82bb52090470dfe098dc");'
RUN r -e 'devtools::install_github("muschellij2/extrantsr", ref = "b9959a2df000c4746fa27a0a7e22caee33c1b0f9");'

ENV ZLIB_VERSION    1.2.8

# Installing ZLIB
# RUN wget http://zlib.net/zlib-$ZLIB_VERSION.tar.gz  && \
#     tar -xzf zlib-$ZLIB_VERSION.tar.gz -C /usr/lib/  && \
#     rm /zlib-$ZLIB_VERSION.tar.gz  && \
#     ln -s /usr/lib/zlib-$ZLIB_VERSION /usr/lib/zlib  && \
#     cd /usr/lib/zlib  && \
#     ./configure  && \
#     make
# ENV ZLIB_LIBRARY /usr/lib/zlib

# RUN r -e 'devtools::install_github("muschellij2/drammsr")' 

# RUN wget -O- http://neuro.debian.net/lists/wily.us-tn.full | tee /etc/apt/sources.list.d/neurodebian.sources.list \
#  && apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9

# RUN apt-get update \
#     && apt-get install -y fsl-core
    
# RUN usermod -u 504 docker

# ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/fsl/5.0

# CMD ["bash"]


