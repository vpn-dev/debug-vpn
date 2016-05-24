#!/bin/bash

router_id=`neutron router-list -F id -F name | grep c6ee82cf | awk '{print $2}'`
echo ">>>router id for space $1 is"
echo $router_id

echo ">>>check the router location"
neutron l3-agent-list-hosting-router $router_id

echo ">>>router details"
neutron router-show $router_id

echo ">>>tenant_id is"
tenant_id=`neutron router-show $router_id -F tenant_id | grep tenant_id | awk '{print $4}'`
echo $tenant_id

echo ">>>connection in this tenant"
neutron ipsec-site-connection-list --tenant-id $tenant_id

echo ">>>ike in this tenant"
neutron vpn-ikepolicy-list --tenant-id $tenant_id

echo ">>>ipsec in this tenant"
neutron vpn-ipsecpolicy-list --tenant-id $tenant_id
