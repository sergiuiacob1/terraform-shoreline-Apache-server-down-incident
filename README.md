
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Apache server down incident.
---

This incident type occurs when the Apache server is down on a particular instance. It may cause service disruptions and impact the availability of applications and services running on the server. The incident requires immediate attention and resolution to restore normal operations.

### Parameters
```shell
# Environment Variables

export APACHE_PORT="PLACEHOLDER"

export SERVER_IP="PLACEHOLDER"

export PATH_TO_APACHE_CONF_FILE="PLACEHOLDER"
```

## Debug

### Check if Apache service is running
```shell
systemctl status apache2
```

### Check Apache logs for any errors
```shell
tail -50 /var/log/apache2/error.log
```

### Check Apache configuration files for syntax errors
```shell
apachectl configtest
```

### Check if Apache is listening on the expected port
```shell
netstat -tuln | grep ${APACHE_PORT}
```

### Check server resource usage
```shell
top
```

### Check server disk usage
```shell
df -h
```

### Check network connectivity to the server
```shell
ping ${SERVER_IP}
```

### Check firewall rules to ensure traffic is allowed on Apache port
```shell
iptables -L -n | grep ${APACHE_PORT}
```

## Repair

### Restart Apache service
```shell
echo "Restarting Apache service..."

systemctl restart apache2
```

### Check service status again
```shell
if systemctl status apache2 | grep -q "active (running)"; then

  echo "Apache service has been restarted and is running"

  exit 0

else

  echo "Failed to restart Apache service"

  exit 1

fi
```

### Check for any configuration errors or updates that may have caused the issue and correct them as needed.
```shell

#!/bin/bash

# Set the path to the Apache configuration file

APACHE_CONF=${PATH_TO_APACHE_CONF_FILE}

# Check for any syntax errors in the configuration file

if ! apachectl configtest -f $APACHE_CONF; then

    echo "ERROR: Configuration file contains syntax errors"

    exit 1

fi

# If there are no syntax errors, restart the Apache service

systemctl restart apache2

```