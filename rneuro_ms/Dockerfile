## Emacs, make this -*- mode: sh; -*-
### RNEURO
FROM muschellij2/rneuro_ants

RUN git clone https://github.com/muschellij2/imaging_in_r.git
COPY ms.lesion_0.6.tar.gz /ms.lesion.tar.gz
RUN r -e 'install.packages("ms.lesion.tar.gz", repos = NULL, type = "source")'

# RUN r -e 'devtools::install_github("muschellij2/ms.lesion")'

# RUN bash
CMD ['/init']
