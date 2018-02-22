`v0.3 last update 22 Feb 2018`

\# Install VirtualBox 5.x

    https://www.virtualbox.org/wiki/Downloads

\# Install Vagrant

    https://www.vagrantup.com/downloads.html

\# Open command prompt or git bash

\# cd to source code dir and clone repo, use xenial branch for Ubuntu 16.04

    git clone https://github.com/geoenvo/mydjango.git
    cd mydjango
    git checkout xenial

\# Rename Vagrantfile.example to Vagrantfile

    cp Vagrantfile.example Vagrantfile

\# Start the Vagrant VM

    vagrant up

\# Wait until first-time Vagrant provisioning completes

\# ssh to the VM and activate the mydjango virtualenv

    vagrant ssh
    workon mydjango
    cd mydjango
    ls

\# Create a new Django project

    django-admin startproject mydjango

\# Configure Django settings file to use mydjango database

    cd mydjango
    vi mydjango/settings.py

\# Run the first database migration to create Django tables

    ./manage.py migrate

\# Create the superuser account (admin admin123)

    ./manage.py createsuperuser

\# Test by running the development server

    ./manage.py runserver 0.0.0.0:8000
    or
    ../run_server.sh

\# On host computer browser open http://localhost:8000

\# Exit shell and shutdown VM

    exit
    vagrant halt

\# Done! To start VM again just run: vagrant up
