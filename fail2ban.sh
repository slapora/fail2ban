#! /bin/ksh

for host in $(< hostlist)

do
	echo -----------------------------------------------------------
        echo $host
        /usr/bin/ssh root@$host "date"


yum -y install fail2ban
systemctl enable fail2ban
systemctl start fail2ban

cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

mkdir /etc/fail2ban/jail.d
cd /etc/fail2ban/jail.d

echo [sshd] >> /etc/fail2ban/jail.d/sshd.local
echo enabled = true  >> /etc/fail2ban/jail.d/sshd.local
echo port = ssh  >> /etc/fail2ban/jail.d/sshd.local
echo action = iptables-multiport  >> /etc/fail2ban/jail.d/sshd.local
echo logpath = /var/log/secure  >> /etc/fail2ban/jail.d/sshd.local
echo maxretry = 3  >> /etc/fail2ban/jail.d/sshd.local
echo bantime = 600  >> /etc/fail2ban/jail.d/sshd.local


systemctl restart fail2ban

done
