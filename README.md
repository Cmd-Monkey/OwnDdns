# OwnDdns
This is a simple script to change my nginx config, that's based on a offshore server, whenever my home server public ip change.


## Disclaimer
I know that this it isn't the safest code, but i'm still learning about the shell script. Any feedback would be appreciated, and sorry about my bad english since i'm not a native speaker.

## Setting Up

The only dependency for this script is **sudo** acess, <code>git</code> </br> and the offshore server need to be running nginx, it could be implement for apache but i don't know enough about it.</br>

If you don't have <code>git</code> installed on both system you should get via your distro package manager.

##### Debian/Ubuntu
<code>sudo apt install git</code> 

##### CentOS
<code>sudo yum install git</code> 

##### RedHat
<code>sudo dnf install git</code> 

After the installation of <code>git</code>, you can run </br>
<code>git clone https://github.com/Cmd-Monkey/OwnDdns</code> </br>
on both servers.

### Host
On the host folder you will see two files, one is the **ip.txt**, this is the file that will check if your ip has changed.</br>

The other file is the main script, is a simple ip checker that when the output is diferent than the **ip.txt** it pushes the new config file to the server.</br>

A few things need to be changed on the **ddns.sh**, the first one is to insert your config file, dont forget to change all your ip's in the config file to **'$nip'**, and paste it to the **ddns.sh** the same way as the example.</br>

The next thing you should do is change the user and the target ip on the scp and ssh line, this command is the responsable for copying the files beetween servers and running the script on server side.</br>
If your server uses an different port for ssh you can use the <code> -P *port*</code> parameter on scp and <code> -p *port*</code> on ssh.</br>
If your server uses ssh key you need to specify the key path using <code> -i */your/key/path*</code></br>


### Server
On the offshore server you just need to see if the path of the file is correct to your <code>nginx/conf.d</code> directory.

### Running
To run the script you may need to change the script to executable, tho do this you can run on the host machine: <br> <code> sudo chmod +x OwnDdns/host/ddns.sh </code></br>
and in the server machine:</br>
<code> sudo chmod +x OwnDdns/server/change.sh </code></br>

After that you can run the script on the host </br>
<code>OwnDdns/host/ddns.sh</code></br>
and they should post the logs on the terminal.

You can run this script automatically via crontab, my curent config is:</br>
<code>
0 */3 * * * /path/to/OwnDdns/host/ddns.sh >> /path/to/OwnDdns/log </code></br>
in my case, the script is executed every 3 hours, and all the logs are written to the log file.</br>

You can learn more about cron and crontab on this [article of the linux handbook](https://linuxhandbook.com/crontab/)
