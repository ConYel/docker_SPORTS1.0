#Use an official Ubuntu runtime as a parent image
FROM biohaz/basic_ubuntu

#MAINTAINER ConYel <https://github.com/ConYel>

# Set the working directory to /home
WORKDIR /home

RUN apt-get update -y \
	&& apt-get install -y r-base \
	libssh2-1-dev libcurl4-openssl-dev \
	libxml2-dev \
	&& R -e 'install.packages(c("ggplot2", "stringr"), dependencies=TRUE, repos="http://cran.rstudio.com/")' \ 
	#&& R -e 'install.packages(c("data.table"), dependencies=TRUE, repos="http://cran.rstudio.com/")' \ 
        && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
	&& bash ~/miniconda.sh -b -p ~/miniconda \
	&& rm ~/miniconda.sh \
	&& echo 'export PATH="~/miniconda/bin:$PATH"' >> ~/.bashrc \
	&& wget https://github.com/junchaoshi/sports1.0/archive/master.zip \ 
	&& unzip master.zip \
	&& rm master.zip  \ 
	&& echo 'export PATH=$PATH:/home/sports1.0-master/source' >> ~/.bashrc \
	&& chmod 755 /home/sports1.0-master/source/sports.pl \
	&& ln -sf ~/miniconda/condabin/conda /usr/local/bin/conda \
	&& rm -rf /var/lib/apt/lists/* /tmp/* 
        
RUN conda update conda \
	&& conda config --add channels defaults \
	&& conda config --add channels bioconda \
	&& conda config --add channels conda-forge \
	&& conda install bowtie cutadapt sra-tools -y
