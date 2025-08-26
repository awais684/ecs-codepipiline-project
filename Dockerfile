FROM public.ecr.aws/ubuntu/ubuntu:22.04

# Install Apache and required tools
RUN apt update -y && \
    apt install -y apache2 apache2-utils wget unzip && \
    apt clean

# Set working directory
WORKDIR /var/www/html

# Download and extract template
ADD https://colorlib.com/out/download-shapely/ shapely.zip
RUN unzip shapely.zip -d shapely && \
    cp -rvf shapely/* . && \
    rm -rf shapely shapely.zip

# Expose Apache port
EXPOSE 80

# Run Apache in foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
