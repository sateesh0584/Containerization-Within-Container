FROM ubuntu:22.04

# Update package lists and install dependencies
RUN apt-get update && \
    apt-get install -y wget openjdk-11-jdk git sudo gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download Jenkins repository configuration
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Update package lists and install Jenkins
RUN apt-get update && \
    apt-get install -y jenkins && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Improved CMD for flexibility (choose option 1 or 2):
CMD ["/usr/share/jenkins/jenkins.war"]
