## Emacs, make this -*- mode: sh; -*-
### Rocker Neuro
## Start with the official rocker image providing 'base R'
FROM r-base:latest


RUN apt-get update \
    && apt-get install -y \
    libssl-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libssh2-1-dev \
    libpq-dev \
    libxml2-dev

# RUN install.r getopt
# RUN \
# echo 'options(repos = c(CRAN = "https://cran.rstudio.com/", CRAN2 = "https://cloud.r-project.org/"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site \
# && echo 'source("/etc/R/Rprofile.site")' >> /etc/littler.r 


# ## Install the Hadleyverse packages (and some close friends). 
RUN install2.r --error \
 devtools 
# RUN r -e 'install.packages("devtools", repos="https://cloud.r-project.org")' \
    
# ## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN r -e 'devtools::install_github("muschellij2/oro.nifti")' 

RUN r -e 'library(utils); source("http://bioconductor.org/biocLite.R"); biocLite(pkgs = c("Biobase"), suppressUpdates = TRUE, suppressAutoUpdate = TRUE, ask = FALSE)'

RUN r -e 'devtools::install_github("muschellij2/fslr", ref = "7a2136dd087b1e4f1969c1e32176ae52ea0c8cb3")' 

# # RUN apt-get update

RUN apt-get install -y r-cran-rgl 

RUN wget http://www.cmake.org/files/v2.8/cmake-2.8.9.tar.gz \
&& tar xzvf cmake-2.8.9.tar.gz \
&& cd cmake-2.8.9 \
&& ./configure \
&& make \
&& make install \ 
&& cd ../

RUN apt-get update && \
apt-get install -y git-core

# # RUN apt-get install -y cmake-curses-gui

# # RUN r -e 'devtools::install_github("muschellij2/extrantsr", ref = "337095449ce0fa7b85be82bb52090470dfe098dc");'
RUN r -e 'devtools::install_github("muschellij2/extrantsr", ref = "b9959a2df000c4746fa27a0a7e22caee33c1b0f9");'

# # ENV ZLIB_VERSION    1.2.8

# RUN \
# r -e 'devtools::install_github("muschellij2/dcm2niir")' \
# && r -e 'library(dcm2niir); install_dcm2nii();'

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

CMD ["bash"]


