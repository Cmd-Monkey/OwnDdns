nip=$(dig whoami.akamai.net. @ns1-1.akamaitech.net. +short)
oip=$(cat *YOUR FOLDER PATH*/ip.txt)

if [ -z "$nip" ];
then
  echo 'Server not responded, trying another'
  nip=$(dig myip.opendns.com @resolver1.opendns.com +short)
fi

if [ $oip != $nip ];
then
  date +%d-%m-%y/%H:%M:%S
  echo 'IP Changed'
  echo $nip>*YOUR FOLDER PATH*/ip.txt
  echo '*YOUR CONFIG FILE*' > *YOUR FOLDER PATH*/site.conf
  scp *YOUR FOLDER PATH*/site.conf *USER*@*TARGET IP*:~/
  ssh *USER*@*TARGET IP* 'sudo ./change.sh'
else
  date +%d-%m-%y/%H:%M:%S
  echo 'No Changes'
fi

