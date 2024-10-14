#!/bin/bash

# Check if ServiceDesk Plus is already installed
if [ ! -f "/opt/manageengine-sdp/ServiceDesk/bin/run.sh" ]; then
    echo "Installing ManageEngine ServiceDesk Plus..."
    chmod +x /opt/manageengine-sdp/ManageEngine_ServiceDesk_Plus.bin
    /opt/manageengine-sdp/ManageEngine_ServiceDesk_Plus.bin -i silent -f /opt/manageengine-sdp/installer.properties

# Set permissions for ServiceDesk and PostgreSQL directories
    echo "Setting permissions..."
    chmod -R 777 /opt/manageengine-sdp
    chown -R technician:servicedesk /opt/manageengine-sdp

    cd /opt/manageengine-sdp/ServiceDesk/bin || { echo "Failed to change directory"; exit 1; }
    
    echo "PostgreSQL initialization..."
    if ! ./initPgsql.sh; then
        echo "PostgreSQL initialization failed."
        exit 1
    fi
fi

# Change to the ServiceDesk Plus 'bin' directory
cd /opt/manageengine-sdp/ServiceDesk/bin || { echo "Failed to change directory"; exit 1; }

# Start ServiceDesk Plus
echo "Starting ServiceDesk Plus..."
if ! ./run.sh; then
    echo "Failed to start ServiceDesk Plus."
    exit 1
fi

