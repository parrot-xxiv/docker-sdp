# Use Debian Slim as the base image
FROM debian:bullseye-slim

# Set a non-interactive frontend (useful for some packages that ask configuration questions)
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary dependencies
RUN apt-get update && apt-get install -y \
    openjdk-11-jre-headless \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*  # Clean up to reduce image size

# Create a servicedesk group
RUN groupadd servicedesk

# Create a technician user and add to the servicedesk group
RUN useradd -m -g servicedesk technician

# Switch to the non-root user
USER technician

# Set the working directory
WORKDIR /opt/manageengine-sdp

# Copy 
COPY --chown=technician:servicedesk ManageEngine_ServiceDesk_Plus.bin startup.sh installer.properties ./

# Make the binary and script executable
RUN chmod +x ManageEngine_ServiceDesk_Plus.bin \
    && chmod +x startup.sh

EXPOSE 8080

ENTRYPOINT ["./startup.sh"]

# CMD [ "/bin/bash" ]