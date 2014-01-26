
#stop services
/etc/init.d/apache2 stop
echo Stopped apache2 server
echo .....
sudo service mysql stop
echo Stopped mysql
echo .....
service cron stop
echo Stopped cron jobs
echo .....
#uninstall and reinstall services

echo Removing apache2 package
echo .....
#completely removing apache2 including its configuration files
apt-get -q -y purge apache2
echo Removed apache2 package
echo .....
#completely removing mysql including its configuration files
echo Removing mysql package
echo .....
apt-get -q -y purge mysql-server mysql-client
echo Removed mysql package
echo .....
#install apache2
echo Starting apache2 package instalation
echo .....
apt-get install apache2
echo Installed apache2 package
echo .....
#install mysql
echo Starting mysql package instalation
echo .....
apt-get install mysql-server mysql-client
echo Installed mysql package
echo .....
