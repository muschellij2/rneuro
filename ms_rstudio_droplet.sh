#####################################
# RStudio keyserver setup
sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list'

gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -

sudo apt-get -y update
####################################
# Neurodebian keyserver setup 
####################################
sudo apt-get install -y gnupg2 gnupg

sudo apt-get install -y dirmngr

sudo wget -O- http://neuro.debian.net/lists/xenial.us-tn.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
sudo apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9
# RUN wget -O- http://neuro.debian.net/lists/yakkety.us-nh.full | tee /etc/apt/sources.list.d/neurodebian.sources.list
# RUN wget -O- http://neuro.debian.net/lists/yakkety.us-tn.full | tee /etc/apt/sources.list.d/neurodebian.sources.list \
# && apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9

## Now install R and littler, 
sudo apt-get -y update
sudo apt-get -y install r-base littler

## Add RStudio binaries to PATH
export PATH=/usr/lib/rstudio-server/bin:$PATH

## Download and install RStudio server & dependencies
## Attempts to get detect latest version, otherwise falls back to version given in $VER
## Symlink pandoc, pandoc-citeproc so they are available system-wide
sudo apt-get update \
  && sudo apt-get install -y \
    file \
    git \
    libapparmor1 \
    libcurl4-openssl-dev \
    libedit2 \
    libssl-dev \
    lsb-release \
    psmisc \
    python-setuptools \
    sudo \
    wget 
sudo apt-get update \
    && sudo apt-get install -y \
    zlib1g-dev \
    libssh2-1-dev \
    libpq-dev \
    libxml2-dev 
sudo apt-get install -y gdebi-core 

export RSTUDIO_VERSION=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver)
sudo wget -q http://download2.rstudio.org/rstudio-server-${RSTUDIO_VERSION}-amd64.deb
sudo gdebi --non-interactive rstudio-server-${RSTUDIO_VERSION}-amd64.deb
sudo rm rstudio-server-*-amd64.deb 


# sudo apt-get update
# sudo apt-get -y install nginx

sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=4000
sudo chmod 600 /var/swap.1
sudo /sbin/mkswap /var/swap.1
sudo /sbin/swapon /var/swap.1
sudo sh -c 'echo "/var/swap.1 swap swap defaults 0 0 " >> /etc/fstab'


# sudo apt-get -y install libcurl4-gnutls-dev
# sudo apt-get -y install libxml2-dev
# sudo apt-get -y install libssl-dev

# create a link for littler in /usr/local/bin
sudo apt-get install -y build-essential    
# sudo chmod -R 777 /etc/R
# sudo chmod -R 775 /etc don't do this
# sudo chown john -R /etc/R
# sudo chown john /etc/littler.r 
sudo echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"), download.file.method = "wget")' >> /etc/R/Rprofile.site
sudo touch /etc/littler.r
sudo chmod 777 /etc/littler.r
sudo echo 'source("/etc/R/Rprofile.site")' >> /etc/littler.r

sudo ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin/install.r 
sudo ln -s /usr/share/doc/littler/examples/install2.r /usr/local/bin/install2.r 
sudo ln -s /usr/share/doc/littler/examples/installGithub.r /usr/local/bin/installGithub.r 
sudo ln -s /usr/share/doc/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r 
sudo install.r docopt 
sudo rm -rf /tmp/downloaded_packages/ /tmp/*.rds 
sudo rm -rf /var/lib/apt/lists/*


sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends \
        less \
        locales \
        wget \
        ca-certificates \
    && sudo rm -rf /var/lib/apt/lists/*


## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
sudo locale-gen en_US.utf8 
sudo /usr/sbin/update-locale LANG=en_US.UTF-8

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export R_BASE_VERSION=3.3.3




# RUN install.r getopt

## Install the Hadleyverse packages (and some close friends). 
sudo install.r devtools 
    # \
    # xml2 \
    # dplyr \
    # base64enc \
    # readr

# sudo apt-get update \
#     && sudo apt-get install -y git-core


#####################################
# Install cmake 2.8.9 - DRAMMS friendly
#####################################
cd ~/ && \
wget http://www.cmake.org/files/v2.8/cmake-2.8.9.tar.gz \
&& tar xzvf cmake-2.8.9.tar.gz \
&& cd cmake-2.8.9 \
&& ./configure \
&& sudo make \
&& sudo make install \
&& cd ~/

# sudo apt-get install -y cmake-curses-gui

##############################
# All the R packages
##############################
sudo r -e 'library(utils); source("http://bioconductor.org/biocLite.R"); biocLite(pkgs = c("Biobase"), suppressUpdates = TRUE, suppressAutoUpdate = TRUE, ask = FALSE)'

#################################
# Had weird URI error for rgl - this fixed it
#################################
sudo sed -i -- 's/#deb-src/deb-src/g' /etc/apt/sources.list && sudo sed -i -- 's/# deb-src/deb-src/g' /etc/apt/sources.list

sudo apt-get -y update
# RGL
sudo apt-get build-dep -y r-cran-rgl 

sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("dcm2niir")'
sudo r -e 'library(dcm2niir); install_dcm2nii();'

sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("neurohcp")'

sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("RNifti")'

## Install divest package
sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("divest")'

sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("oro.dicom")'

sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("oro.nifti")'

sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("WhiteStripe")'
sudo install.r WhiteStripe 
sudo r -e 'library(WhiteStripe); download_img_data()'

sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("neurobase")'
sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("fslr")'


##########################################
# FSL
##########################################
sudo apt-get update \
    && sudo apt-get install -y fsl-complete

# Debian has a fixed FSLDIR
export FSLDIR=/usr/local/fsl
export FSLSHARE=/usr/share/data
# add the fsl binary path to the search path
export PATH=$PATH:${FSLDIR}/bin
# export PATH=$PATH:/usr/lib/fsl/5.0
# Possum is installed in the same directory
export POSSUMDIR=$FSLDIR

sudo mkdir -p ${FSLDIR}/bin
sudo cp /usr/lib/fsl/5.0/* ${FSLDIR}/bin/
sudo mkdir -p ${FSLDIR}/lib
sudo mv ${FSLDIR}/bin/lib* ${FSLDIR}/lib/

export FSLOUTPUTTYPE=NIFTI_GZ
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/fsl/5.0
export LD_LIBRARY_PATH=${FSLDIR}/lib/:$LD_LIBRARY_PATH:

# sudo cp /usr/share/fsl/5.0/etc/fslconf/fsl.sh $FSLDIR/etc/fslconf/fsl.sh
export FSLOUTPUTTYPE=NIFTI_GZ
# sudo rm $FSLDIR/etc/fslconf/fsl.sh
sudo mkdir -p $FSLDIR/etc/fslconf/
fname=${FSLDIR}/etc/fslconf/fsl.sh
echo "FSLDIR=/usr/local/fsl" > ${fname}
echo 'PATH=${PATH}:${FSLDIR}/bin' >> ${fname}
echo 'LD_LIBRARY_PATH=${FSLDIR}/lib:$LD_LIBRARY_PATH' >> ${fname}
echo "FSLOUTPUTTYPE=NIFTI_GZ" >> ${fname}

##########################
# Setting global library
##########################
sudo echo "${FSLDIR}/lib" > /etc/ld.so.conf.d/fsl.conf
sudo ldconfig

sudo mkdir -p ${FSLDIR}/data/standard
sudo mkdir -p ${FSLDIR}/data/atlases 

#######################################
# Setting things up like other installers
#######################################
# settring up standard
sudo cp -R ${FSLSHARE}/fsl-mni152-templates/* ${FSLDIR}/data/standard/

# setting up atlases
sudo cp -R ${FSLSHARE}/harvard-oxford-atlases/* ${FSLDIR}/data/atlases/
sudo cp -R ${FSLSHARE}/juelich-histological-atlas/* ${FSLDIR}/data/atlases/
sudo cp -R ${FSLSHARE}/bangor-cerebellar-atlas/* ${FSLDIR}/data/atlases/
sudo cp -R ${FSLSHARE}/jhu-dti-whitematter-atlas/* ${FSLDIR}/data/atlases/
sudo cp -R ${FSLSHARE}/forstmann-subthalamic-nucleus-atlas/* ${FSLDIR}/data/atlases/
sudo cp -R ${FSLSHARE}/fsl-resting-connectivity-parcellation-atlases/* ${FSLDIR}/data/atlases/
sudo cp -R ${FSLSHARE}/mni-structural-atlas/* ${FSLDIR}/data/atlases/
sudo cp -R ${FSLSHARE}/oxford-thalamic-connectivity-atlas/* ${FSLDIR}/data/atlases/
sudo cp -R ${FSLSHARE}/talairach-daemon-atlas/* ${FSLDIR}/data/atlases/ 

##########################################
# ANTs
##########################################
sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("ITKR")'
sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("ANTsRCore", upgrade_dependencies = FALSE)'
sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("ANTsR", upgrade_dependencies = FALSE)'
sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("extrantsr", upgrade_dependencies = FALSE)'

# export PATH=/usr/lib/fsl/5.0:$PATH
# ms.lesion_0.6.tar.gz /ms.lesion.tar.gz
# RUN r -e 'install.packages("ms.lesion.tar.gz", repos = NULL, type = "source")'
# devtools::install_github("muschellij2/ms.lesion", auth_token = auth_token)


cd ~/ && git clone https://github.com/muschellij2/imaging_in_r.git



export PANDOC_TEMPLATES_VERSION=1.18

## Symlink pandoc & standard pandoc templates for use system-wide
sudo ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin
sudo ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc /usr/local/bin
sudo wget https://github.com/jgm/pandoc-templates/archive/${PANDOC_TEMPLATES_VERSION}.tar.gz
sudo mkdir -p /opt/pandoc/templates && sudo tar zxf ${PANDOC_TEMPLATES_VERSION}.tar.gz
sudo cp -r pandoc-templates*/* /opt/pandoc/templates && sudo rm -rf pandoc-templates*
sudo mkdir /root/.pandoc && sudo ln -s /opt/pandoc/templates /root/.pandoc/templates
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

  ## RStudio wants an /etc/R, will populate from $R_HOME/etc
sudo mkdir -p /etc/R
  ## Write config files in $R_HOME/etc
# sudo chmod 777 /usr/local/lib/R/site-library

# sudo echo '\n\
#     \n# Configure httr to perform out-of-band authentication if HTTR_LOCALHOST \
#     \n# is not set since a redirect to localhost may not work depending upon \
#     \n# where this Docker container is running. \
#     \nif(is.na(Sys.getenv("HTTR_LOCALHOST", unset=NA))) { \
#     \n  options(httr_oob_default = TRUE) \
#     \n}' >> /usr/local/lib/R/site-library/Rprofile.site
# sudo echo "PATH=\"${PATH}\"" >> /usr/local/lib/R/site-library/Renviron 
#   ## Need to configure non-root user for RStudio
#   # && useradd rstudio \
#     # && mkdir /home/rstudio \
#     # && chown rstudio:rstudio /home/rstudio \
#     # && addgroup rstudio staff \
#   ## configure git not to request password each time 
#   # && git config --system credential.helper 'cache --timeout=3600' \
#   # && git config --system push.default simple \
#   # ## Set up S6 init system
#   # && wget -P /tmp/ https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/s6-overlay-amd64.tar.gz \
#   # && tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
#   sudo mkdir -p /etc/services.d/rstudio
#   sudo chmod 777 -R /etc/services.d/rstudio
#   sudo echo '#!/bin/bash \
#            \n exec /usr/lib/rstudio-server/bin/rserver --server-daemonize 0' \
#            > /etc/services.d/rstudio/run
#   sudo echo '#!/bin/bash \
#            \n rstudio-server stop' \
#            > /etc/services.d/rstudio/finish

sudo install.r \
    formatR \
    caTools \
    rprojroot \
    rmarkdown


##############################
# Install MS LESION DATA!
# INSTALL KIRBY21
##############################
sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("papayar")'
sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("oasis")'
sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("malf.templates")'
sudo r -e 'source("https://neuroconductor.org/neurocLite.R"); neuroc_install("kirby21.t1")'

sudo install.r ROCR 
sudo install.r ggplot2 scales

adduser john
gpasswd -a john sudo
su - john



################
# make empty file
# The > is important!
#################
# > /root/batch-user-add.txt

# fname=/root/batch-user-add.txt
# chmod 0600 $fname
# echo "kristin:kristin:1050:513:Kristin:/home/kristin:/bin/bash" > ${fname};
user=kristin
sudo useradd -m -d /home/$user -s /bin/bash $user
for i in $(seq 1 100); do
    user="user${i}";
    num=$((i + 1000));
    sudo useradd -m -d /home/$user -s /bin/bash $user
    echo $user:$user | chpasswd
    # echo "${user}:${user}:${num}:513:${user}:/home/${user}:/bin/bash" >> ${fname};
done;
# newusers ${fname}

cd ~/imaging_in_r && git pull && cd ~/

user=kristin
rm /home/$user/*.R /home/$user/*.nii.gz
cp ~/imaging_in_r/r_scripts/*.R /home/$user/
mkdir -p /home/$user/output
cp ~/imaging_in_r/training01_01_mprage.nii.gz /home/$user/
cp ~/imaging_in_r/output/training*.nii.gz /home/$user/output/
user=john
rm /home/$user/*.R /home/$user/*.nii.gz
cp ~/imaging_in_r/r_scripts/*.R /home/$user/
mkdir -p /home/$user/output
cp ~/imaging_in_r/training01_01_mprage.nii.gz /home/$user/
cp ~/imaging_in_r/output/training*.nii.gz /home/$user/output/
for i in $(seq 1 100); do
    user="user${i}";
    rm /home/$user/*.R /home/$user/*.nii.gz
    mkdir -p /home/$user/output
    cp ~/imaging_in_r/r_scripts/*.R /home/$user/
    cp ~/imaging_in_r/training01_01_mprage.nii.gz /home/$user/
    cp ~/imaging_in_r/output/training*.nii.gz /home/$user/output/
    # echo "${user}:${user}:${num}:513:${user}:/home/${user}:/bin/bash" >> ${fname};
done;



