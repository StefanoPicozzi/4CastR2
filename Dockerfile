# Use fedora as the base
FROM centos:latest
MAINTAINER Stefano Picozzi

USER root

RUN yum -y install epel-release
RUN yum -y install R
RUN yum -y install mysql

RUN yum -y install wget
RUN wget http://download2.rstudio.org/rstudio-server-rhel-0.99.442-x86_64.rpm
RUN yum -y install --nogpgcheck rstudio-server-rhel-0.99.442-x86_64.rpm

RUN yum -y install ftp
RUN yum -y install curl
RUN yum -y install libcurl libcurl-devel
RUN yum -y install libpng-devel
RUN yum -y install mesa-libGL-devel mesa-libGLU-devel libpng-devel

RUN mkdir packages

RUN cd packages; wget http://cran.rstudio.com/src/contrib/rJava_0.9-6.tar.gz
RUN cd packages; R CMD INSTALL rJava_0.9-6.tar.gz
# RUN cd packages; wget https://github.com/StefanoPicozzi/Rdrools6/blob/master/Rdrools6jars_0.0.1.tar.gz
# RUN cd packages; R CMD INSTALL Rdrools6jars_0.0.1.tar.gz
# RUN cd packages; wget https://github.com/StefanoPicozzi/Rdrools6/blob/master/Rdrools6_0.0.1.tar.gz
# RUN cd packages; R CMD INSTALL Rdrools6_0.0.1.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/stringi_0.5-5.tar.gz
RUN cd packages; R CMD INSTALL stringi_0.5-5.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/magrittr_1.5.tar.gz
RUN cd packages; R CMD INSTALL magrittr_1.5.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/colorspace_1.2-6.tar.gz
RUN cd packages; R CMD INSTALL colorspace_1.2-6.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/Rcpp_0.11.6.tar.gz
RUN cd packages; R CMD INSTALL Rcpp_0.11.6.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/stringr_1.0.0.tar.gz
RUN cd packages; R CMD INSTALL stringr_1.0.0.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/RColorBrewer_1.1-2.tar.gz
RUN cd packages; R CMD INSTALL RColorBrewer_1.1-2.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/dichromat_2.0-0.tar.gz
RUN cd packages; R CMD INSTALL dichromat_2.0-0.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/munsell_0.4.2.tar.gz
RUN cd packages; R CMD INSTALL munsell_0.4.2.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/labeling_0.3.tar.gz
RUN cd packages; R CMD INSTALL labeling_0.3.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/plyr_1.8.3.tar.gz
RUN cd packages; R CMD INSTALL plyr_1.8.3.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/digest_0.6.8.tar.gz
RUN cd packages; R CMD INSTALL digest_0.6.8.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/gtable_0.1.2.tar.gz
RUN cd packages; R CMD INSTALL gtable_0.1.2.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/reshape2_1.4.1.tar.gz
RUN cd packages; R CMD INSTALL reshape2_1.4.1.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/scales_0.2.5.tar.gz
RUN cd packages; R CMD INSTALL scales_0.2.5.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/proto_0.3-10.tar.gz
RUN cd packages; R CMD INSTALL proto_0.3-10.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/ggplot2_1.0.1.tar.gz
RUN cd packages; R CMD INSTALL ggplot2_1.0.1.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/png_0.1-7.tar.gz
RUN cd packages; R CMD INSTALL png_0.1-7.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/xlsxjars_0.6.1.tar.gz
RUN cd packages; R CMD INSTALL xlsxjars_0.6.1.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/rjson_0.2.15.tar.gz
RUN cd packages; R CMD INSTALL rjson_0.2.15.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/rgl_0.95.1247.tar.gz
RUN cd packages; R CMD INSTALL rgl_0.95.1247.tar.gz
RUN cd packages; wget http://cran.rstudio.com/src/contrib/xlsx_0.5.7.tar.gz
RUN cd packages; R CMD INSTALL xlsx_0.5.7.tar.gz

USER root
RUN useradd guest
RUN echo guest:guest | chpasswd

RUN useradd student01; useradd student02; useradd student03; useradd student04; useradd student05; useradd student06; useradd student07; useradd student08; useradd student09 ;useradd student10;

RUN echo student01:student01 | chpasswd; echo student02:student02 | chpasswd; echo student03:student03 | chpasswd; echo student04:student04 | chpasswd; echo student05:student05 | chpasswd; echo student06:student06 | chpasswd; echo student07:student07 | chpasswd; echo student08:student08 | chpasswd; echo student09:student09 | chpasswd; echo student10:student10 | chpasswd

RUN yum -y install git
RUN git clone https://github.com/StefanoPicozzi/4CastR2
RUN cp 4CastR2/* /home/guest/
COPY 4CastR.png /home/guest/
COPY paasonomics.R /home/guest/

RUN cp 4CastR2/* /home/student01/
COPY 4CastR.png /home/student01/
COPY paasonomics.R /home/student01/

RUN cp 4CastR2/* /home/student02/
COPY 4CastR.png /home/student02/
COPY paasonomics.R /home/student02/

RUN cp 4CastR2/* /home/student03/
COPY 4CastR.png /home/student03/
COPY paasonomics.R /home/student03/

RUN cp 4CastR2/* /home/student04/
COPY 4CastR.png /home/student04/
COPY paasonomics.R /home/student04/

RUN cp 4CastR2/* /home/student05/
COPY 4CastR.png /home/student05/
COPY paasonomics.R /home/student05/

RUN cp 4CastR2/* /home/student06/
COPY 4CastR.png /home/student06/
COPY paasonomics.R /home/student06/

RUN cp 4CastR2/* /home/student07/
COPY 4CastR.png /home/student07/
COPY paasonomics.R /home/student07/

RUN cp 4CastR2/* /home/student08/
COPY 4CastR.png /home/student08/
COPY paasonomics.R /home/student08/

RUN cp 4CastR2/* /home/student09/
COPY 4CastR.png /home/student09/
COPY paasonomics.R /home/student09/

RUN cp 4CastR2/* /home/student10/
COPY 4CastR.png /home/student10/
COPY paasonomics.R /home/student10/

RUN chown -R guest:guest /home/guest/*
RUN chown -R student01:student01 /home/student01/* ; chown -R student02:student02 /home/student02/*; chown -R student03:student03 /home/student03/*; chown -R student04:student04 /home/student04/*; chown -R student05:student05 /home/student05/*; chown -R student06:student06 /home/student06/*; chown -R student07:student07 /home/student07/*; chown -R student08:student08 /home/student08/*; chown -R student09:student09 /home/student09/*; chown -R student10:student10 /home/student10/*

EXPOSE 8787
CMD /usr/lib/rstudio-server/bin/rserver --server-daemonize 0


