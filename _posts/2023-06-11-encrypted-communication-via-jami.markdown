---
layout: post
title: Encrypted communication via Jami
date: 2023-06-11
categories: [computer]
tags: [Jami,network,security]
mathjax: false
---

Jami is a GPL licensed communication tool with end-to-end encryption, which can be used for sending instant messages, making audio calls and holding video conferences with family members or friends. For those users concerned about data safety and communication privacy, Jami is an ideal and definitive choice.

Even though Jami claims to be a p2p communication tool, it still needs to join a public distributed network, i.e. [distributed hash table](https://en.wikipedia.org/wiki/Distributed_hash_table) (DHT), as an independent node to announce the availability and connectivity of our accounts as well as acquiring the knowledge about other nodes. When a Jami client starts for the first time, it tries to connect to a bootstrap node `bootstrap.jami.net:4222`, from which a persistent cache will be built storing the node information. In case this server is not accessible in the future, I need to setup my own [OpenDHT](https://github.com/savoirfairelinux/opendht) server.

Another issue is peers communicating via Jami are usually hidden from one another behind their respective firewalls or Wifi routers. Then another server with a public IP is necessary to bridge the peers by relaying the data stream during communication. This is called the TURN server. The default TURN server provided by Jami is `turn.jami.net`, with username `ring`, password `ring`, and realm `ring`. However, using this third-party server cannot ensure communication quality, especially when we need high resolution video calls. Meanwhile, the accessibility to this server cannot be ensured in the long run. Therefore, I also need to setup my own TURN server.

I have two cascading Wifi routers in my home, one is provided by the ISP, whose Wifi functionality is not stable and is actually disabled; the other is my own router providing the actual Wifi network across the room. Because the WLAN port has been assigned a dynamic public IP by the ISP, setting up the said TURN server is feasible. Even though my server is behind the two routers, port mapping can be enabled to expose my server to the outside world.


# Setup OpenDHT server

-   Install the `dhtnode` package from Debian.
-   Edit `/etc/default/dhtnode`, let the local OpenDHT node as a daemon listen at the port `<opendht-port>`, without connecting to another bootstrap server, i.e. without specifying the `-b` option. This option should only be used from an `opendht` node as a client.
    
    ```text
    DHT_ARGS=-p <opendht-port>
    ```
    
    Other command line options for `dhtnode` which may be useful:
    
    -   `-p`: local UDP port to bind. The default value is 4222.
    -   `-n`: specify a network id (integer). Nodes with different network ids won&rsquo;t talk to each other. Defaults to the main public network (network id 0). However, there is no place to specify this argument in Jami, I do not use it in my configuration.
    -   `-v`: enables logging, to standard output by default
    -   `-L`: logs to syslog
    -   `-l`: logs to a specific file
-   Start the `dhtnode`
    
    ```text
    sudo systemctl start dhtnode
    ```
-   Automatically start at system boot:
    
    ```text
    sudo systemctl enable dhtnode
    ```

More information can be found here:

-   <https://github.com/savoirfairelinux/opendht/wiki/Running-a-node-with-dhtnode>
-   <https://stackoverflow.com/questions/60425311/how-to-connect-to-peers-in-opendht>


# Setup TURN server

-   Install the `coturn` package from Debian.
-   Edit configuration file `/etc/turnserver.conf`, where I disabled TCP and UDP protocol and only keep TLS and DTLS, which are safer. The `min-port` and `max-port` specify the port range for UDP relay end points, which are used locally by Jami and need not be opened in iptables.
    
    ```text
    # listening-port=3478
    no-udp
    no-tcp
    tls-listening-port=<turn-tls-port>
    min-port=63100
    max-port=63200
    fingerprint
    lt-cred-mech
    realm=<realm-name>
    syslog
    no-cli
    ```
    
    The log is written to `syslog`, which can be checked by `sudo journalctl -u coturn`.

-   Add a TURN server user, which will be used by Jami clients.
    
    ```text
    sudo turnadmin -a -u jihuan -p <password> -r quantumman
    ```

More information can be found here:

-   <https://docs.jami.net/developer/setting-up-your-own-turn-server.html>
-   <https://matrix-org.github.io/synapse/latest/setup/turn/coturn.html>


# Port mapping in Wifi routers

The port numbers exposed to the public in the Wifi routers should be mapped to the internal ports adopted by the OpenDHT and TURN servers.


# Enable iptables rules

Edit `/etc/iptables.up.rules`:

```text
# Allow TURN server connections
-A INPUT -p tcp -m state --state NEW --dport <turn-tls-port> -j ACCEPT
-A INPUT -p udp -m state --state NEW --dport <turn-tls-port> -j ACCEPT

# Allow OpenDHT node connections
-A INPUT -p udp -m state --state NEW --dport <opendht-port> -j ACCEPT
```

# Communication quality verification

I&rsquo;ve verified that 1920x1080 video resolution at 30 fps and screen sharing at 120 fps are well supported.

{{ 2023-06-11-encrypted-communication-via-jami | backlink }}
