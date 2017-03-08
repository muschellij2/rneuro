## Emacs, make this -*- mode: sh; -*-
### RNEURO
FROM muschellij2/rneuro_fsl

RUN r -e 'devtools::install_github("stnava/ITKR")'
RUN r -e 'devtools::install_github("stnava/ANTsRCore")'
RUN r -e 'devtools::install_github("stnava/ANTsR")'

RUN r -e 'devtools::install_github("muschellij2/extrantsr")'
