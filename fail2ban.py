import os

with open('hostlist') as f:
    for host in f:
        host = host.strip()
        print('-----------------------------------------------------------')
        print(host)
        os.system(f'ssh root@{host} "date"')

os.system('yum -y install fail2ban')
os.system('systemctl enable fail2ban')
os.system('systemctl start fail2ban')

os.system('cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local')

os.makedirs('/etc/fail2ban/jail.d', exist_ok=True)
os.chdir('/etc/fail2ban/jail.d')

with open('/etc/fail2ban/jail.d/sshd.local', 'w') as f:
    f.write('[sshd]\n')
    f.write('enabled = true\n')
    f.write('port = ssh\n')
    f.write('action = iptables-multiport\n')
    f.write('logpath = /var/log/secure\n')
    f.write('maxretry = 3\n')
    f.write('bantime = 600\n')

os.system('systemctl restart fail2ban')
