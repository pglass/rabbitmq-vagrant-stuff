rabbitmq-vagrant-stuff
======================

The Vagrantfile sets up two machines `rabbit1` and `rabbit2` based on Ubuntu 14.04 that can be used in a RabbitMQ cluster on a private network. The addresses are assigned as follows:
    
- `rabbit1` at address `192.168.33.10`
- `rabbit2` is at address `192.168.33.11`
- The host machine is at `192.168.33.1` (from inside either VM)

After the two VMs start up, you should be to create the cluster. On `rabbit2`, run the following:

    sudo rabbitmqctl stop_app
    sudo rabbitmqctl join_cluster rabbit@rabbit1
    sudo rabbitmqctl start_app

Then you should be able to check the cluster status and see both nodes `rabbit@rabbit1` and `rabbit@rabbit2` as follows:

    sudo rabbitmqctl cluster_status
    [{nodes,[{disc,[rabbit@rabbit1,rabbit@rabbit2]}]},
     {running_nodes,[rabbit@rabbit2,rabbit@rabbit1]},
     {partitions,[]}]
    ...done.

On each VM, the `rabbit` node is available on port 5672. 

From the host machine, you should be able to run `python send_repeat.py 192.168.33.10 5672` to send a message every five seconds to the `hello` queue in your cluster. Inside either VM, you should see the queue size increase while this script is running

    sudo rabbitmqctl list_queues
    Listing queues ...
    hello	4
    ...done.

To set an HA policy for the `hello` queue:
    
    sudo rabbitmqctl set_policy ha-policy "^hello" '{"ha-mode": "all"}'

### iptables

To create a network partition in your cluster, use `iptables` to disable communication to the other machines ip. From within `rabbit2`, do the following to block `rabbit1`:

    sudo iptables -A INPUT -s 192.168.33.10 -j DROP

To see all your iptable rules:
    
    sudo iptables -L

To clear all your iptable rules:
    
    sudo iptables -F

To delete a single iptable rule:
    
    sudo iptables -D <chain> <index>

where `<index>` represents the index of the rule in the given chain's list.
