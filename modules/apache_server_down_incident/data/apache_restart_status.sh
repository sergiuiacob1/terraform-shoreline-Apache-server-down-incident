if systemctl status apache2 | grep -q "active (running)"; then

  echo "Apache service has been restarted and is running"

  exit 0

else

  echo "Failed to restart Apache service"

  exit 1

fi