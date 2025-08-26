FROM public.ecr.aws/ubuntu/ubuntu:22.04

# Install Apache and required tools
RUN apt update -y && \
    apt install -y apache2 apache2-utils wget unzip && \
    apt clean 

# Set working directory
WORKDIR /var/www/html

# Download the actual ZIP file
ADD https://github.com/awais684/static-zip/raw/refs/heads/master/S3-Static-Website-master.zip

# Unzip, copy contents, and clean up
RUN unzip site.zip -d site && \
    cp -rvf site/* . && \
    rm -rf site site.zip

#RUN echo "Hello DevOps Class" > /var/www/html/index.html

# Expose Apache port
EXPOSE 80

# Run Apache in foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
