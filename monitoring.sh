#!/bin/bash
wall $'\t#Architecture:' `uname -a` \
$'\n\t#CPU physical:' `cat /proc/cpuinfo | grep 'physical id' | uniq | wc -l` \
$'\n\t#vCPU:' `cat /proc/cpuinfo | grep 'processor' | wc -l` \
$'\n\t#Memory Usage:' `free -m | grep 'Mem:' | awk '{printf("%d/%dMB (%.2f%%)\n", $3, $4, $3 / $4 * 100)}'` \
$'\n\t#Disk Usage:' `df --total | grep 'total' | awk '{printf("%.1f/%.1fGb (%.1f%%)", $3 / (1024*1024), $4 / (1024*1024), $5)}'` \
$'\n\t#CPU load:' `top -bn1 | grep '%Cpu' | cut -d ',' -f 4 | awk '{printf("%.1f%%", 100 - $1)}'` \
$'\n\t#Last boot:' `who -b | awk '{print $3, $4}'` \
$'\n\t#LVM use:' `lsblk | grep 'lvm' -m 1 | awk '{if($0){print "yes"} else {print "no"}}'` \
$'\n\t#TCP Connections:' `ss -at | grep 'ESTAB' | wc -l` 'ESTABLISHED' \
$'\n\t#User log:' `who | cut -d ' ' -f 1 | sort -u | wc -l` \
$'\n\t#Network: IP' `hostname -I` `ip a | grep 'link/ether' | awk '{printf("(%s)", $2)}'` \
$'\n\t#Sudo:' `grep 'COMMAND' /var/log/sudo/sudo.log | wc -l` 'cmd'
