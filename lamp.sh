#!/bin/bash

# Update system packages
sudo apt update

# Install Apache
sudo apt install -y apache2

# Start Apache
sudo systemctl start apache2

# Enable Apache to start on boot
sudo systemctl enable apache2

# Install MySQL
sudo apt install -y mysql-server

# Secure MySQL installation
sudo mysql_secure_installation

# Install PHP and required modules
sudo apt install -y php libapache2-mod-php php-mysql

# Restart Apache for PHP to take effect
sudo systemctl restart apache2

# Display PHP version
php -v

# Done!
echo "LAMP stack installation completed."
