rneuro: 
	for i in rneuro_base rneuro_fsl \
		rneuro_itkr \
		rneuro_antsrcore rneuro_ants \
		rneuro_ms rneuro_ms_rstudio ; do \
	    docker build -t muschellij2/$${i} $${i}/ ; \
	    docker tag muschellij2/$${i} muschellij2/$${i}; \
	    docker push muschellij2/$${i} ; \
	done;