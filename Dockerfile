# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Update package lists and install necessary tools
RUN apt-get update && \
    apt-get install -y wget gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Java
RUN apt-get update && \
    apt-get install -y default-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add Jenkins repository
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Update package lists and install Jenkins
RUN apt-get update && \
    apt-get install -y jenkins git sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Allow jenkins user to execute sudo commands without password
RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Change user to jenkins and set environment variables
USER jenkins
ENV USER jenkins

# Set CMD to start Jenkins
CMD java -jar /usr/lib/jenkins/jenkins.war
