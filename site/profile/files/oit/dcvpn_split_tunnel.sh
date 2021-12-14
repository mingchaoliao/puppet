sudo route del -net default dev ppp0
sudo route add -net 132.235.0.0 netmask 255.255.0.0 dev ppp0
