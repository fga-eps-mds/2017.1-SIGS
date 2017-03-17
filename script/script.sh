#script.sh
#!/bin/bash

echo "Instalando RVM"
\curl -sSL https://get.rvm.io | bash

echo "RVM instalada"

echo "diretorio para uso do rvm"
source /home/vagrant/.rvm/scripts/rvm 
echo "Installing rvm: Done"

echo "Installing ruby: starting"
rvm install 2.3.1
rvm use 2.3.1 --default
echo "Ruby instaled: DONE"

echo "Installing rails: starting"
gem install bundler
gem install rails -v 4.2.4
echo "Installing rails: DONE"

echo "instalation gems and create db: starting"
cd /vagrant
bundle install
rake db:create db:migrate
echo "success"

echo "Instalation Complete!"

