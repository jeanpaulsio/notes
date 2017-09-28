# Speed is a Feature
Two components dictate the performance of all network traffic: *latency and bandwidth*

Latency: the time from the source sending a packet to the destination receiving it

Bandwidth: max throughput of a logical or physical communication path

* It's important to understand how latency and bandwidth work together
* Once you understand that, you'll have the tools to dive deeper into the internals and performance characteristics of TCP, UDP, and all application protocols above them

# The many components of latency

> Latency is the time it takes for a message or a packet to travel from its point of origin to the point of destination

* This definition hides a lot of useful information
* Every system contains multiple sources or components, contributing to the overall time it takes for a message to be delivered
* 
