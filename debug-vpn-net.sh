#!/bin/bash

router_id=$1
echo "check if ipsec is running"
sudo service ipsec status

echo "check if neutron-vpn-agent is running"
sudo service neutron-vpn-agent status

echo "check if neutron-metering-agent is running"
sudo service neutron-metering-agent status

echo ">>>show ip add"
sudo ip netns exec qrouter-$router_id ip add

echo ">>>ipsec status"
sudo ipsec whack --ctlbase /var/lib/neutron/ipsec/$router_id/var/run/pluto --status

echo ">>>iptables dump"
sudo ip netns exec qrouter-$router_id iptables -nvL

echo ">>>iptables nat dump"
sudo ip netns exec qrouter-$router_id iptables -t nat -nvL
