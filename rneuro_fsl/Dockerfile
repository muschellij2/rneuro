### RNEURO with FSL
FROM muschellij2/rneuro

RUN wget -O- http://neuro.debian.net/lists/wily.us-tn.full | tee /etc/apt/sources.list.d/neurodebian.sources.list \
 && apt-key adv --recv-keys --keyserver hkp://pgp.mit.edu:80 0xA5D32F012649A5A9

RUN apt-get update \
    && apt-get install -y fsl-core
    
RUN usermod -u 504 docker

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/fsl/5.0

CMD ["bash"]


