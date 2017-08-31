# Building Blocks of UDP

User Datagram Protocol

* came well after the introduction of TCP/IP
* the main appeal of UDP is not what it introduces, but rather what it omits


> Datagram - A self-contained, independent entity of data carrying sufficient information to be routed from the source to the destination nodes without reliance on earlier exchanges between the nodes and the transporting network

__"Packet" vs. "Datagram"__

* these are often used interchangeably but there are some notable differences
* "Packet" applies to any formatted block of data
* "Datagram" is often reserved for "packets" delivered via an unreliable service: no delivery guarantees, no failure notifications


* Well known use of UDP: DNS
* given a human-friendly computer hostname, we need to discover its IP address before any data exchange can occur.
* Historically, UDP has never been exposed as a first-class transport for pages and apps running within it **until WebRTC**

## Null Protocol Services

* First we need to look at the Internet Protocol, or IP - which is one layer below TCP and UDP
* The IP layer has the primary task of delivering datagrams from the source to the destination host based on their address
* To do so, the messages are encapsulated within an IP packet which identifies the source and the destination address, as well as other routing params
* the IP layer provides no guarantees about message delivery or notification of failure - hence directly exposing the unreliability of the underlying network to the layers above it
* the UDP protocol encapsulates user messages into its own packet structure which adds only four additional fields

__UDP non-services__

1. No guarantee of message delivery
2. No guarantee of order of delivery
3. No connection state tracking
4. No congestion control

* TCP is a byte-stream oriented protocol capable of transmitting application messages spread across multiple packets without any explicit message boundaries within the packets
* to achieve TCP, connection state is allocated on both ends of the connection and each packet is sequenced, retransmitted when lost and delivered in order
* __on the other hand__ UDP datagrams have definitive boundaries. each datagram is carried in a single IP packet, and each app read yields the full message. datagrams can't be fragmented
* UDP is stateless


## UDP and Network Address Translators

* IPv4 addresses are only 32 bits long so there are only 4.29 billion unique addresses. At some point, this will run out and we won't be able to assign a unique IP to every host
* the **IP network Address Translator** specification was introduced in 1994 as an interim solution to the IPv4 address depletion problem
* The proposed IP reuse solution was to introduce NAT devices at the edge of the network.
* Each NAT device would be responsible for maintaining a table mapping of local IP and port tuples to one or more globally unique IP
* The local IP address space behind the translator could then be reused among many different networks, thus solving the address depletion problem.
* This "temporary" solution actually became quite permanent


## Connection-state timeouts

* There is an issue with NAT translation as far as UDP is concerned.
* The routing table that it must maintain in order to deliver datagrams presents a problem with UDP
* __NAT middleboxes rely on connection state whereas UDP has none__
* Each TCP connection has a well-defined protocol state machine, which begins with a handshake, followed by application data transfer, and a well-defined exchange to close the connection.
* Given this flow, each middlebox can observe the state of the connection and create and remove the routing entries as needed.
* With UDP, there is no handshake or connection termination, hence there is no connection state machine to monitor
* Routing a reply requires that we have an entry in the translation table, which will tell us the IP and port of the local destination host. *THUS*, translators have to keep state about each UDP flow, which itself is stateless.
* The translator is also tasked with figuring out when to drop the translation record, but UDP has no termination sequence. Either peer could just stop transmitting datagrams at any point without notice

## NAT Traversal

* Unpredictable state handling is a serious issue created by NATs
* an even larger problem for many apps is the inability to establish a UDP connection at all.
* The first issue is that in the presence of NAT, the internal client is unaware of its public IP: it knows its internal IP address and the NAT devices perform rewriting of the source port and address in every UDP packet as well as the originating IP address within the IP packet
* But if the client communicates its private IP address as part of its application data with a peer outside of its private network, then the connection will fail.
* Knowing the public IP is also not sufficient to successfully transmit with UDP
* any packet that arrives at the public IP of a NAT device must also have a destination port and an entry in the NAT table that can translate it to an internal destination host IP and port tuple.
* To work around this mismatch in UDP and NATs, various traversal techniques have to be used to establish end-to-end connectivity between the UDP peers on both sides:
* __stun, turn, and ice__


## STUN, TURN, and ICE

* Session Traversal Utilities for NAT is a protocol that allows the host app to discover the presence of a NAT on the network and when present to obtain the allocated public IP and port tuple for the current connection.
* To do so, the protocol requires assistance from a well-known third party STUN server that must reside on the public network
* Assuming the IP address of the STUN server is known, the application first sends a binding request to the STUN server
* In turn, the STUN server replies with a response that contains the public IP address and port of the client as seen from the public network. This addresses several problems we encountered before

1. The application discovers its public IP and port tuple and is then able to use this information as part of its application data when communicating with its peers
2. Outbinding request to the STUN server establishes NAT routing entries along the path, such that the inbound packets arriving at the public IP and port tuple can now find their way back to the host app on the internal network
3. the STUN protocol defines a simple mechanism for keepalive pings to keep the NAT routing entries from timing out


* When two peers want to talk to each other over UDP, they will first send binding requests to their respective STUN servers and following a successful response on both sides, they can then use the established public IP and port tuples to exchange data

__HOWEVER__

* in practice, STUN is not sufficient to deal with all NAT topologies and network configs
* UDP might be blocked altogether by a firewall
* To address this, IF STUN fails, we can use __Traversal Using Relays around NAT__ TURN
* This is a fallback which can run over UDP and switch to TCP if all else fails
* TURN relies on the presence and availability of a public relay to shuttle the data between peers
* Both clients begin their connections by sending an allocate request to the same TURN server, followed by permission negotiations
* Once the negotiations are complete, both peers communicate by sending their data to the TURN server, which relays it to the other peer
* NOTE: TURN is not peer to peer
* We can lean on __Interactive Connectivity Establishment__ protocol to help with using STUN and TURN.
* ICE will use STUN when possible and fallback on TURN if it fails
* 
