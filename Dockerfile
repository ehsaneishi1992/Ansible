# Use the official Ubuntu image as a base
FROM ubuntu:24.04

# Install necessary dependencies
RUN apt update && apt install -y \
    software-properties-common \
    curl \
    gnupg2 \
    lsb-release \
    && add-apt-repository ppa:ansible/ansible \
    && apt update \
    && apt install -y ansible sshpass \
    && apt install -y nano inetutils-ping net-tools

# Clean up unnecessary files to reduce image size
RUN rm -rf /var/lib/apt/lists/*

# Set working directory inside the container
WORKDIR /ansible

# Set the default command to use ansible when the container starts
##ENTRYPOINT ["ansible"]
CMD ["/bin/bash"]
