
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