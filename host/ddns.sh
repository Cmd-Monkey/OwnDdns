nip=$(dig whoami.akamai.net. @ns1-1.akamaitech.net. +short)
oip=$(cat ~/OwnDdns/host/ip.txt)

if [ -z "$nip" ];
then
  echo 'Server not responded, trying another'
  nip=$(dig myip.opendns.com @resolver1.opendns.com +short)
fi

if [ $oip != $nip ];
then
  date +%d-%m-%y/%H:%M:%S
  echo 'IP Changed'
  echo $nip>~/OwnDdns/host/ip.txt
  echo 'server {
        server_name foo.com;

        location / {
            proxy_pass http://'$nip':8096;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }' > ~/OwnDdns/host/site.conf
  scp ~/OwnDdns/host/site.conf *USER*@*TARGET IP*:~/OwnDdns/server/
  ssh *USER*@*TARGET IP* 'sudo ~/OwnDdns/server/change.sh'
else
  date +%d-%m-%y/%H:%M:%S
  echo 'No Changes'
fi

