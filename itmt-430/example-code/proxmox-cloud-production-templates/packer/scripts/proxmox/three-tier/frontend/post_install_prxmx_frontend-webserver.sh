#!/bin/bash

# Install and prepare frontend web server - Example for ExpressJS/NodeJS

sudo apt-get update
sudo apt-get install -y curl rsync

# Steps to add NodeJS repository to your Ubuntu Server for Node and NPM installation
# Remove and or replace with your required webserver stack
# https://github.com/nodesource/distributions/blob/master/README.md#using-ubuntu-2
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g npm@9.6.0

# Use NPM package manager to install needed dependecies to run our EJS app
# https://github.com/motdotla/dotenv -- create a .env file to pass environment variables
sudo npm install -g express ejs pm2 dotenv
# pm2.io is an applcation service manager for Javascript applications
# Change directory to the location of your JS code
cd /home/vagrant/team-00/code/express-static-app/

# Using pm2 start the express js application as the user vagrant
sudo -u vagrant pm2 start server.js

# This creates your javascript application service file
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u vagrant --hp /home/vagrant

# This saves which files we have already started -- so pm2 will 
# restart them at boot
sudo -u vagrant pm2 save