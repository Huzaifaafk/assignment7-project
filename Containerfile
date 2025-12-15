FROM fedora:latest

# Install Apache
RUN dnf -y upgrade && \
    dnf -y install httpd && \
    dnf clean all

# Create user collin
RUN useradd collin

# Create /structure directory as root with 777 permissions
RUN mkdir /structure && chmod 777 /structure

# Create directories as specific users
RUN mkdir /structure/sync-work && \
    mkdir /structure/nobody-work && \
    chown nobody:nobody /structure/nobody-work

# Create index.html
RUN mkdir -p /var/www/html && \
    echo "Containers are easy!" > /var/www/html/index.html

# Expose port 80
EXPOSE 80

# Run httpd in foreground
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
