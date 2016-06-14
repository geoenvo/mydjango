#!/usr/bin/env bash
# Root level script to set up environment for Django development on Vagrant.
# Target box: ubuntu/trusty64

echo "---------------------------------------------"
echo "Installing package dependencies"
echo "---------------------------------------------"
apt-get update
apt-get install -y git build-essential python python-dev python-pip python-virtualenv libjpeg8-dev gettext
apt-get install -y postgresql postgresql-server-dev-all postgis postgresql-9.3-postgis-2.1
apt-get install -y binutils libgeoip1 libproj-dev gdal-bin python-gdal

echo "---------------------------------------------"
echo "Configure PostgreSQL for MD5 authentication"
echo "---------------------------------------------"
if [ -f /etc/postgresql/9.3/main/pg_hba.conf ]; then
    cp /etc/postgresql/9.3/main/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf.orig
    echo 'local all all md5' >> /etc/postgresql/9.3/main/pg_hba.conf
    echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/9.3/main/pg_hba.conf
fi

if [ -f /etc/postgresql/9.3/main/postgresql.conf ]; then
    cp /etc/postgresql/9.3/main/postgresql.conf /etc/postgresql/9.3/main/postgresql.conf.orig
    echo "listen_addresses = '*'" >> /etc/postgresql/9.3/main/postgresql.conf
fi

service postgresql restart

echo "---------------------------------------------"
echo "Installing virtualenv"
echo "---------------------------------------------"
pip install virtualenv virtualenvwrapper

if ! grep -Fq "WORKON_HOME" /home/vagrant/.bashrc; then
    echo 'export WORKON_HOME=$HOME/.virtualenvs' >> /home/vagrant/.bashrc
    echo 'source /usr/local/bin/virtualenvwrapper.sh' >> /home/vagrant/.bashrc
fi
