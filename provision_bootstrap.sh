#!/usr/bin/env bash
# Root level script to set up environment for Django development on Vagrant.
# Target box: ubuntu/xenial64

# OBSOLETE
#echo "---------------------------------------------"
#echo "select fastest repo mirror with apt-select"
#echo "---------------------------------------------"
#wget https://raw.githubusercontent.com/geoenvo/apt-select/master/apt-select.py https://raw.githubusercontent.com/geoenvo/apt-select/master/arguments.py https://raw.githubusercontent.com/geoenvo/apt-select/master/mirrors.py https://raw.githubusercontent.com/geoenvo/apt-select/master/update.sh https://raw.githubusercontent.com/geoenvo/apt-select/master/util_funcs.py
#chmod u+x *.py update.sh
#apt-get update
#apt-get install -y python-bs4
#./apt-select.py -t 3 -m up-to-date -l
#./update.sh
# OBSOLETE

echo "---------------------------------------------"
echo "select fastest repo mirror with apt-select"
echo "---------------------------------------------"
apt-get update
apt-get install -y python-pip
pip install https://github.com/jblakeman/apt-select/archive/v2.1.0.zip
apt-select -C ID -t 10 -p
cp /etc/apt/sources.list /etc/apt/sources.list.bak
mv sources.list /etc/apt/

echo "---------------------------------------------"
echo "Installing package dependencies"
echo "---------------------------------------------"
apt-get update
apt-get install -y git build-essential python python-dev python-pip python-virtualenv libjpeg8-dev gettext
apt-get install -y postgresql postgresql-server-dev-all postgis postgresql-9.5-postgis-2.2
apt-get install -y binutils libgeoip1 libproj-dev gdal-bin python-gdal

echo "---------------------------------------------"
echo "Configure PostgreSQL for MD5 authentication"
echo "---------------------------------------------"
if [ -f /etc/postgresql/9.5/main/pg_hba.conf ]; then
    cp /etc/postgresql/9.5/main/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf.orig
    echo 'local all all md5' >> /etc/postgresql/9.5/main/pg_hba.conf
    echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/9.5/main/pg_hba.conf
fi

if [ -f /etc/postgresql/9.5/main/postgresql.conf ]; then
    cp /etc/postgresql/9.5/main/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf.orig
    echo "listen_addresses = '*'" >> /etc/postgresql/9.5/main/postgresql.conf
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
