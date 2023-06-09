#!/bin/bash

# Update system packages
sudo apt update

# Install Apache
sudo apt install -y apache2

# Start Apache
sudo systemctl start apache2

# Enable Apache to start on boot
sudo systemctl enable apache2

# Clone the Git repository
sudo apt install -y git
git clone https://github.com/ravib7/MPCC-Project.git /var/www/MPCC-Project

# Configure MPCC-Project Virtual Host
echo "<VirtualHost *:80>
    ServerName 65.0.134.41
    DocumentRoot /var/www/MPCC-Project
    <Directory /var/www/MPCC-Project>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>" | sudo tee /etc/apache2/sites-available/MPCC-Project.conf

# Enable the Virtual Host
sudo a2ensite MPCC-Project.conf

# Reload Apache configuration
sudo systemctl reload apache2

# Install MySQL
sudo apt install -y mysql-server

# Secure MySQL installation
sudo mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Mpcc@user1';
CREATE DATABASE mpcc;
CREATE USER 'mpccuser'@'localhost' IDENTIFIED BY 'Mpcc@user1';
GRANT ALL PRIVILEGES ON mpcc.* TO 'mpccuser'@'localhost';
FLUSH PRIVILEGES;
EOF

# Add PHP repository
sudo add-apt-repository ppa:ondrej/php

# Update system packages again
sudo apt update

# Install PHP and required modules
sudo apt install -y php8.1-common php8.1-mysql php8.1-xml php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-dev php8.1-imap php8.1-mbstring php8.1-opcache php8.1-soap php8.1-zip

# Restart Apache for PHP to take effect
sudo systemctl restart apache2

# Create info.php file
echo "<?php
\$servername = '65.0.134.41';
\$username = 'mpccuser';
\$password = 'Mpcc@user1';
\$database = 'mpcc';

\$conn = new mysqli(\$servername, \$username, \$password, \$database);

// Check connection
if (\$conn->connect_error) {
    die('Connection failed: ' . \$conn->connect_error);
}

// Run queries or perform database operations here

\$conn->close();
?>" | sudo tee /var/www/MPCC-Project/info.php

# Display PHP version
php -v

# Done!
echo "Congratulations! Your MPCC-Project is now online."
