#!/bin/bash
wall $'#Architecture:' `uname -a` \
$'\n#CPU physical:' `cat /proc/cpuinfo | grep 'physical id' | uniq | wc -l` \
$'\n#vCPU:' `cat /proc/cpuinfo | grep 'processor' | wc -l` \
$'\n#Memory Usage:' `free -m | grep 'Mem:' | awk '{printf("%d/%dMB (%.2f%%)\n", $3, $4, $3 / $4 * 100)}'` \
$'\n#Disk Usage:' `df --total | grep 'total' | awk '{printf("%.1f/%.1fGb (%.1f%%)", $3 / (1024*1024), $4 / (1024*1024), $5)}'` \
$'\n#CPU load:' `top -bn1 | grep '%Cpu' | cut -d ',' -f 4 | awk '{printf("%.1f%%", 100 - $1)}'` \
$'\n#Last boot:' `who -b | awk '{print $3, $4}'` \
$'\n#LVM use:' `lsblk | grep 'lvm' -m 1 | awk '{if($0){print "yes"} else {print "no"}}'` \
$'\n#TCP Connections:' `ss -at | grep 'ESTAB' | wc -l` 'ESTABLISHED' \
$'\n#User log:' `who | cut -d ' ' -f 1 | sort -u | wc -l` \
$'\n#Network: IP' `hostname -I` `ip a | grep 'link/ether' | awk '{printf("(%s)", $2)}'` \
$'\n#Sudo:' `grep 'COMMAND' /var/log/sudo/sudo.log | wc -l` 'cmd'
