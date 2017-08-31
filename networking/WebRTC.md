__Overview__

* Standards and development of WebRTC
* Audio and Video engines
* Real-Time Network Transports
* Establishing a Peer-to-Peer connection
* Delivering media and application data
* DataChannel
* WebRTC Use Cases and Performance
* Performance Checklist


# Standards and Development of WebRTC

* Shift in the paradigm and breaks away from the "client-to-server" communication model
* This means you have to re-engineer the networking layer of the browser
* This also means that WebRTC architecture consists of over a dozen different standards
* WebRTC is more than just another browser API


# Audio and Video Engines

* There are a lot of implications of *teleconferencing in the browser*
* The browser must be able to access the system hardware to capture both the audio and video
* Raw audio and video streams are also not sufficient on their own. They must be processed to enhance quality, synchronized, and the output bitrate must adjust to the continuously fluctuating bandwidth
* WebRTC brings fully featured audio and video engines to the browser
* On the receiving end, the client must decode the streams in real-time and be able to adjust to network jitter and latency delays


## Acquiring Audio and video with `getUserMedia`

* The "Media Capture and Streams" w3c specification defines a set of new JavaScript APIs that enable the application to request audio and video streams from the platform, as well as a set of APIs to manipulate and process the acquired media streams.
* __The `MediaStreamTrack` object is the primary interface that enables all of this functionality__

![MediaStream](/images/2017/08/Screen Shot 2017-08-29 at 8.01.09 PM.png)

* `MediaStream` carries one or more synchronized tracks

  * The `MediaStream` object consists of one or more individual tracks
  * Tracks within a `MediaStream` object are synchronized with one another
  * The input source can be a physical device such as a mic, webcam, or a local remote file from the user's hard drive or a remote network peer
  * the output of a `MediaStream` can be sent to one or more destinations: a local video or audio element, etc

* A `MediaStream` object represents a real-time media stream and allows the application code to acquire data, manipulate individual tracks and specify outputs
* The features of the acquired media stream are constrained by the capabilities of the input source: a mic can only emit an audio stream.
* __When requesting media streams in the browser, the `getUserMedia()` API allows us to specify a list of mandatory and optional constraints to match the needs of the application__


```html
<video autoplay></video>

<script>
  const constraints = {
    audio: true,
    video: {
      mandatory: {
        width: { min: 320 },
        height: { min: 180 },
      },
      optional: [
        { width: { max: 1280 } },
        { frameRate: 30 },
        { facingMode: "user" }
      ]
    }
  }

  navigator.getUserMedia(constraints, gotStream, logError);

  function gotStream(stream) {
    let video = document.querySelector("video");
    video.src = window.URL.createObjectURL(stream);
  }

  function logError(error) {
    console.log(error)
  }
</script>
```

Here we are doing a couple of things:
1. Instantiating an HTML video element
2. Requesting a mandatory audio track, `audio: true`
3. Requesting a mandatory video track, `mandatory: {}`
4. List of mandatory constraints for video track
5. Array of optional constraints for video track
6. Request audio and video streams from the browser
7. Callback function to process the acquired `MediaStream`


__What are we doing in this example?__

* we are requesting audio and video tracks
* we are specifying both the minimum resolution and type of camera that must be used
* the `getUserMedia()` API is responsible for requesting access to the microphone and camera from the user, and acquiring the streams that match the specified constraints
* __Once the stream is acquired__... we can feed it into a variety of other browser APIs
* BASICALLY: `getUserMedia()` is a **simple** API to acquire a user's audio and video streams from the underlying platform. This gets us half way to building a real-time teleconferencing application. All we need to do now is __route the data to a peer__

# Real-Time Network Transports

* Real-time communication is time-sensitive
* Audio and video streaming apps are designed to tolerate intermittent packet loss: audio and video codecs can fill in small data gaps, often with minimal impact on the output of quality
* Timeliness and low latency can be more important than reliability
* The requirement for timeliness over reliability is the primary reason why the **UDP protocol is a preferred transport of delivery of real-time data.**

__TCP vs. UDP__

* remember that we prefer timeliness over reliability
* TCP delivers a reliable, ordered stream of data. if the intermediate packet is lost, the TCP buffers all the packets after it, waits for retransmission, and then delivers the stream in order to the application.
* By comparison, UDP offers the following non-services:
  - no guarantee of message delivery
  - no guarantee of order delivery
  - no connection state tracking
  - no congestion control
* UDP offers no promises on reliability or order of data, and delivers each packet to the application the moment it arrives.
* **WebRTC uses UDP at the transport layer**. Latency and timeliness are CRITICAL

> UDP is the foundation for real-time communication in the browser, but to meet all of the requirements of WebRTC, the browser also needs a large supporting cast

__Supporting Cast (our stack)__

* ICE (STUN + TURN)
* SDP: Session Description Protocol
* DTLS: Datagram Transport Layer Security
* SCTP: Stream Control Transport Protocol
* SRTP: Secure Real-Time Transport

* ICE, STUN, and TURN are necessary to establish and maintain a peer-to-peer connection over UDP
* DTLS is used to secure all data transfers between peers

__Brief Intro to `RTCPeerConnection` API__

* The `RTCPeerConnection` interface is responsible for managing the full life cycle of each peer-to-peer connection
* `RTCPeerConnection` manages the full ICE workflow for NAT Traversal
* `RTCPeerConnection` sends automatic STUN keepalives between peers
* `RTCPeerConnection` keeps track of local streams
* `RTCPeerConnection` triggers automatic stream renegotiation as required
* `RTCPeerConnection` provides necessary APIs to generate the connection offer, accept the answer, allows us to query the connection for its current state, and more
* `RTCPeerConnection` encapsulates all the connection setup, management, and state within a single interface
* We need to understand a few things first.

1. Signaling and negotiations
2. The offer / answer workflow
3. ICE traversal

# Establishing a Peer-to-Peer Connection

* Initiating a peer-to-peer connection requires more than opening an XHR, EventSource, or web socket
* Those three options rely on a well-defined HTTP handshake mechanism to negotiate parameters of the connection, and all three implicitly assume that the destination server is reachable by the client.
* It's also possible that two WebRTC peers are within their own, distinct private networks and behind one or more layer of NATs
* Because of this, neither peer is directly reachable by the other.
* To initiate a session, we must first gather the possible IP and port candidates for each peer, traverse the NATs, and then run the connectivity checks to find the ones that work, and even then, there is no guarantee that it will succeed

__In order to establish a successful peer-to-peer connection, we must solve some problems__

1. we must notify the other peer of the intent to open a p2p connection such that it knows to start listening for incoming packets
2. we must identify the potential routing paths for the p2p connections on both sides of the connection and relay this info between peers
3. we must exchange the necessary info about the parameters of the different media and data streams

* WebRTC has built in ICE protocol that performs the necessary routing and connectivity checks. BUT ... the delivery of notifications (signaling) and initial session negotiation is left to the application

### Signaling and Session negotiation

* Before any connectivity checks or session negotiation can occur, we must find out if the other peer is reachable and if it is willing to establish the connection
* We must extend an offer, and the peer must return an answer
* __Dilemma__: if the other peer is not listening for incoming packets, how do we notify it of our intent? At a **minimum**, we need a shared signaling channel
* WebRTC doesn't have signaling baked in
* A WebRTC app can choose to use any of the existing signaling protocols and gateways to negotiate a call or video conference with an existing communication system. We can also implement our own signaling service with a custom protocol.
* The signaling server acts as a gateway to an existing communications network, in which case it is the *responsibility* of the network to notify the target peer of a connection offer and then route the answer back to the WebRTC client initiating the exchange.
* If both peers are connected to the same signaling service, then the service can shuttle messages between them.

__Session Description Protocol SDP__

* assuming the application implements a shared signaling channel, we can now perform the first steps required to initiate a WebRTC connection:

```JavaScript
var signalingChannel = new SignalingChannel()
var pc = new RTCPeerConnection({})

navigator.getUserMedia({
  audio: true
}, gotStream, logError)

function gotStream(stream) {
  pc.addStream(stream)
  pc.createOffer(function(offer) {
    pc.setLocalDescription(offer)
    signalingChannel.send(offer.sdp)
  })
}

function logError() { ... }
```

1. Initialize the shared signaling channel
2. initialize the RTCPeerConnection object
3. Request audio stream from the browser
4. Register local audio stream with RTCPeerConnection object
5. Create SDP offer description of the peer connection
6. Apply generated SDP as local description of peer connection
7. Send generated SDP offer to remote peer via signaling channel

* WebRTC uses Session Description Protocol to describe the parameters of the p2p connection
* SDP does not delivery any media itself, it just describes the session profile
* In the example above, once a local audio stream is registered with the `RTCPeerConnection` object, we call `createOffer()` to generate the SDP description of the intended session.
* What does the generated SDP contain?


```
(... snip ...)
m=audio 1 RTP/SAVPF 111 ...
a=extmap:1 urn:ietf:params:rtp-hdrext:ssrc-audio-level
a=candidate:1862263974 1 udp 2113937151 192.168.1.73 60834 typ host ...
a=mid:audio
a=rtpmap:111 opus/48000/2
a=fmtp:111 minptime=10
(... snip ...)
```
1. Secure audio and profile with feedback
2. candidate, ip, port, and protocol for media stream
3. opus codec and basic configuration

* SDP describes the properties of the intended session
* WebRTC apps don't have to deal with SDP directly
* we have a few method calls against `RTCPeerConnection`
* Once the offer is generated, it can be sent to the remote peer via the signaling channel. Once again
* To establish a p2p connection, both peers must follow a symmetric workflow to exchange SDP descriptions of their respective audio, video, and other data streams


__Signaling Channel: Amy & Bob__

1. Amy initiates a vid chat stream with Bob
2. Amy registers one or more streams with her local `RTCPeerConnection` object, creates an offer, and sets it as her "local description" of the session
3. Amy sends the generated session offer to Bob
4. Once Bob receives the offer, he sets Amy's description as his "remote description" of the session and registers his own stream with his own `RTCPeerConnection` object, generates his "answer" SDP description and sets it as the "local description of the session"
5. Bob sends the generated answer back to Amy
6. Amy receives Bob's SDP answer and sets it as her "remote description" of her original session
7. We are almost ready to make a connection.


__Interactive Connectivity Establishment (ICE)__

In order to establish a p2p connection by definition, the peers must be able to route packets to each other

* this becomes complex if both peers are behind firewalls - so let's assume for the worse
* WebRTC manages most of the complexity of this
* Each `RTCPeerConnection` connection object contains an "ICE agent"
* ICE agent is responsible for gathering local IP, port tuples
* ICE agent is responsible for performing connectivity checks
* ICE agent is responsible for sending connection keepalives


* Once a session description (local or remote) is set, local ICE agent automatically begins the process of discovering all of the possible candidate IP, port tuples for the local peer
* ICE agent queries the OS for local IP addresses
* If configured, ICE agent queries an external STUN server to retrieve the public IP and port tuple of the peer
* If configured, ICE agent appends the TURN server as last resort candidate
* Whenever a new candidate is discovered, the agent automatically registers it with the `RTCPeerConnection` object and notifies the application via a callback function `onicecandidate`
* once the ICE gathering is complete, the same callback is fired to notify the application
* we can extend our example to work with ICE


```JavaScript
var ice = {
  iceServers: [
    { url: "stun:stun.l.google.com:19302" }, //1
    {
      url: "turn:turnserver.com", //2
      username: "user",
      credential: "password"
    }
  ]
};

var signalingChannel = new SignalingChannel();
var pc = new RTCPeerConnection(ice)

navigator.getUserMedia({
  audio: true,
}, gotStream, logError)

function gotStream(stream) {
  pc.addStream(stream)

  pc.createOffer(function(offer) {
    pc.setLocalDescription(offer) //3
  })
}

pc.onicecandidate = function(event) {
  if (event.target.iceGatheringState == "complete") { //4
    local.createOffer(function(offer) {
      signalingChannel.send(offer.sdp) //5
    })
  }
}
```

So what's happening?

1. STUN server configured with google public test server
2. TURN server for relaying data if p2p connection fails
3. Apply local session description: initiates ICE gathering process
4. Subscribe to ICE events and listen for ICE gathering completion
5. Regenerate the SDP offer (now with discovered ICE candidates)

As this example illustrates, the ICE agent handles most of the complexity on our behalf

The ice gathering processes is triggered automatically, STUN lookups are performed in the bg, and the discovered candidates are registered with the `RTCPeerConnection` object

* Once this is complete we can generate the SDP offer and use the signaling channel to deliver it to the other peer
* Once the ICE candidates are received by the other peer, we are ready to begin the second phase of establishing the p2p connection
* Once the remote session description is set on the `RTCPeerConnection` object, which now contains a list of candidate IP and port tuples for the other peer, the ICE agent begins connectivity checks to see if it can reach the other party
* The ICE agent sends a message (STUN binding request) which the other peer must acknowledge with a successful STUN response
* If this completes, we have a p2p connection 

* Delivering media and application data
* DataChannel
* WebRTC Use Cases and Performance
* Performance Checklist
