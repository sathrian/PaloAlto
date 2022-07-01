#!/bin/bash
# URL Traffic Script
# Jan 17, 2020
# Bill Claunch
# Palo Alto Networks, Inc.
#
# This script retrieves various URLs using curl. The script also uses
# different source IP addresses from this host that must be bound to
# the adapter:
#
# 192.168.1.20
# 192.168.1.22
# 192.168.1.24
# 192.168.1.30
# 192.168.1.35
#
# The script first pulls the API key from firewall-a and writes it to a variable.
# The variable is used as part of the API XML upload of a list of user-id
# mappings contained in Ausers.xml in the current directory.
# This process is easier to carry out rather than hard-coding an API key in the
# script which must be changed for each deployed firewall.
# This portion of the script (API key) assumes that the firewall's username is
# admin and the password is Pal0Alt0!
#
# The script then uses curl to retrieve each URL. The -k switch tells curl not
# to verify certificates.
#
# The script pauses for a random amount of time between 1 and 10 seconds
# between each request.
#
# The script will run in a continuous loop until interrupted.
#
# This script can be used to test URL filtering profiles and to examine
# entries in the URL log.
#
######################################################################################################
# Get Key from Firewall-A and write to FirewallA.keyfile.txt
######################################################################################################
curl -k -X GET "https://192.168.1.254/api/?type=keygen&user=admin&password=Pal0Alt0!" >FirewallA.keyfile.txt
                # clean up extraneous characters in API response to leave only key
                # Remove > characters 
                sed --in-place "s/>/ /g" FirewallA.keyfile.txt
                # Remove < characters
                sed --in-place "s/</ /g" FirewallA.keyfile.txt
                # Remove single quotes
                sed --in-place "s/'/ /g" FirewallA.keyfile.txt
                # Remove extraneous text before key
                sed --in-place 's/ response status =  success   result  key //g' FirewallA.keyfile.txt
                # Remove slashes
                sed --in-place 's/\///g' FirewallA.keyfile.txt
                # Remove extraneous text after key
                sed --in-place 's/ key  result  response //g' FirewallA.keyfile.txt
                clear
                echo "Your key is below:"
                echo ""
                cat FirewallA.keyfile.txt
                echo ""
                echo ""
                echo "The key is also stored in the current directory as " FirewallA.keyfile.txt
                echo ""
                echo -n "Press enter to proceed"
        clear
######################################################################################################
# Read FirewallA.keyfile.txt into variable.
######################################################################################################
# read API key for FirewallA from FirewallA.keyfile.txt into variable
                tempkeyA=`cat FirewallA.keyfile.txt`
######################################################################################################
# Upload Ausers.xml file to Firewall-A
######################################################################################################
sudo curl -k -F key=$tempkeyA --form file=@/home/lab-user/Desktop/Lab-Files/Common/Ausers.xml "https://192.168.1.254/api/?type=user-id" > /home/lab-user/empty.txt
######################################################################################################
# Begin retrieving websites using curl
######################################################################################################
while true
do
curl -k --interface 192.168.1.22 https://www.gunsandammo.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.weapons-universe.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.trueswords.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.weaponmasters.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.hackthissite.org/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.vegasworld.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.oddsshark.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://us.betfair.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.google.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.youtube.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.facebook.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.baidu.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.wikipedia.org
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.yahoo.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.google.co.in
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.reddit.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.qq.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.taobao.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.amazon.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.tmall.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://twitter.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.google.co.jp
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.sohu.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://login.live.com/login.srf
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://m.vk.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.instagram.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.sina.com.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.360.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.google.de
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://global.jd.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.google.co.uk
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.linkedin.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://us.weibo.com/gb
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.google.fr
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.google.ru
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://google.com.br
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://yandex.ru
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.netflix.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://t.co
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.google.com.hk
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.hao123.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.cnn.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.gambling.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.aol.com/games/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.nytimes.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://wordpress.org
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://soundcloud.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.e-recht24.de
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.samsung.com/us/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.accuweather.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.nicovideo.jp
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.dailymail.co.uk/ushome/index.html
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.bet365.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.dropbox.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://fc2.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.tianya.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 http://www.aliexpress.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.22 https://www.naver.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.gunsandammo.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.weapons-universe.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.trueswords.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.weaponmasters.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.hackthissite.org/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.vegasworld.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.oddsshark.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://us.betfair.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.google.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.youtube.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.facebook.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.baidu.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.wikipedia.org
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.yahoo.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.google.co.in
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.reddit.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.qq.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.taobao.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.amazon.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.tmall.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://twitter.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.google.co.jp
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.sohu.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://login.live.com/login.srf
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://m.vk.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.instagram.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.sina.com.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.360.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.google.de
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://global.jd.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.google.co.uk
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.linkedin.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://us.weibo.com/gb
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.google.fr
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.google.ru
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://google.com.br
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://yandex.ru
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.netflix.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://t.co
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.google.com.hk
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.hao123.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.cnn.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.gambling.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.aol.com/games/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.nytimes.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://wordpress.org
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://soundcloud.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.e-recht24.de
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.samsung.com/us/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.accuweather.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.nicovideo.jp
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.dailymail.co.uk/ushome/index.html
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.bet365.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.dropbox.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://fc2.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.tianya.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 http://www.aliexpress.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.24 https://www.naver.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.gunsandammo.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.weapons-universe.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.trueswords.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.weaponmasters.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.hackthissite.org/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.vegasworld.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.oddsshark.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://us.betfair.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.google.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.youtube.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.facebook.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.baidu.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.wikipedia.org
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.yahoo.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.google.co.in
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.reddit.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.qq.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.taobao.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.amazon.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.tmall.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://twitter.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.google.co.jp
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.sohu.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://login.live.com/login.srf
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://m.vk.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.instagram.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.sina.com.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.360.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.google.de
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://global.jd.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.google.co.uk
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.linkedin.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://us.weibo.com/gb
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.google.fr
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.google.ru
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://google.com.br
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://yandex.ru
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.netflix.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://t.co
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.google.com.hk
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.hao123.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.cnn.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.gambling.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.aol.com/games/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.nytimes.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://wordpress.org
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://soundcloud.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.e-recht24.de
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.samsung.com/us/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.accuweather.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.nicovideo.jp
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.dailymail.co.uk/ushome/index.html
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.bet365.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.dropbox.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://fc2.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.tianya.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.aliexpress.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.naver.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.google.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.youtube.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.facebook.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.baidu.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.wikipedia.org
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.yahoo.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.google.co.in
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.reddit.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.qq.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.taobao.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.amazon.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.tmall.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://twitter.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.google.co.jp
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.sohu.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://login.live.com/login.srf
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://m.vk.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.instagram.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.sina.com.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.360.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.google.de
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://global.jd.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.google.co.uk
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.linkedin.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://us.weibo.com/gb
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.google.fr
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.google.ru
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://google.com.br
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://yandex.ru
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.netflix.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://t.co
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.google.com.hk
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.hao123.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.cnn.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.gambling.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.aol.com/games/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.nytimes.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://wordpress.org
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://soundcloud.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.e-recht24.de
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.samsung.com/us/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.accuweather.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.nicovideo.jp
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.dailymail.co.uk/ushome/index.html
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.bet365.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.dropbox.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://fc2.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.tianya.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 http://www.aliexpress.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.35 https://www.naver.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.google.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.youtube.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.facebook.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.baidu.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.wikipedia.org
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.yahoo.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.google.co.in
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.reddit.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.qq.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.taobao.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.amazon.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.tmall.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://twitter.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.google.co.jp
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.sohu.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://login.live.com/login.srf
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://m.vk.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.instagram.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.sina.com.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.360.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.google.de
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://global.jd.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.google.co.uk
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.linkedin.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://us.weibo.com/gb
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.google.fr
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.google.ru
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://google.com.br
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://yandex.ru
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.netflix.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://t.co
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.google.com.hk
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.hao123.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.cnn.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.gambling.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.aol.com/games/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.nytimes.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://wordpress.org
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://soundcloud.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.e-recht24.de
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.samsung.com/us/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.accuweather.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.nicovideo.jp
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.dailymail.co.uk/ushome/index.html
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.bet365.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.dropbox.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://fc2.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.tianya.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.aliexpress.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.naver.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.google.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.youtube.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.facebook.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.baidu.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.wikipedia.org
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.yahoo.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.google.co.in
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.reddit.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.qq.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.taobao.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.amazon.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.tmall.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://twitter.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.google.co.jp
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.sohu.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://login.live.com/login.srf
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://m.vk.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.instagram.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.sina.com.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.360.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.google.de
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://global.jd.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.google.co.uk
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.linkedin.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://us.weibo.com/gb
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.google.fr
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.google.ru
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://google.com.br
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://yandex.ru
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.netflix.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://t.co
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.google.com.hk
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.hao123.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.cnn.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.gambling.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.aol.com/games/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.nytimes.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://wordpress.org
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://soundcloud.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.e-recht24.de
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.samsung.com/us/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.accuweather.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.nicovideo.jp
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.dailymail.co.uk/ushome/index.html
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.bet365.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.dropbox.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://fc2.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.tianya.cn
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.aliexpress.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.naver.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.gunsandammo.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.weapons-universe.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.trueswords.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.weaponmasters.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.hackthissite.org/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 http://www.vegasworld.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://www.oddsshark.com
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
curl -k --interface 192.168.1.30 https://us.betfair.com/
sleep $[ ( $RANDOM % 10 )  + 1 ]s 
clear
done

