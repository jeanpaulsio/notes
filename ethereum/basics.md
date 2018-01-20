# Section 1 - What is Ethereum?

* Bitcoin starts in 2008 - proposed a way for people to be able to pay each other without a central authority like a bank
* Key characteristic of Bitcoin was the block chain
* Send money from person A to person B
* Bitcoin was just to handle currency

__Ethereum__

* Using block chain technology for more than just handling currency
* Most important part of Ethereum is the smart contract
* The smart contract lives in the block chain
* Smart Contracts as an entity can send and receive currency, beyond just humans

__Ethereum Network__

* Ethereum networks are used to transfer money and store data
* There are many different Ethereum networks
* Networks are formed by one or more nodes
* Each node is a machine running an ethereum client
* Anyone can run a node
* Each node can contain a full copy of the block chain
* The "block chain" is a database that stores a record of every transaction that has ever taken place

> Blockchain: Stores every movement of money between different parties

__How do you connect to the Ethereum network?__

* For developers: web3.js
* For consumers: Metamask, Mist Browser

__Sending and Receiving Ether__

* we can send and receive test tokens and view them on the Rinkeby network
* it takes some time to send and receive Ether

__What is a transaction?__

* a record of one account attempting to send money to another account
* a transaction is created when any two accounts exchange some amount of money
* a transaction object is created and sent to the Ethereum network to be processed

__Transaction__

* nonce: how many times the sender has sent a transaction
* to: address of account the money is going to
* value: amount of ether to send the targer address
* gasPrice: amount of ether the sender is willing to pay per unti gas to get this transaction processed
* startGas/gasLimit: unit of gas that this transaction can consume
* v/r/s: cryptographic pieces of data that can be used to generate the senders account address. generated from the sender's private key

__What happens when you send a transaction?__

1. we send a transaction to the Rinkeby test network
2. when we sent it out, it goes to one particular node
3. our application will be interfacing with one node, that node will be communicating with the rest of the network
4. this node has the entire copy of the block chain
5. other people might be sending transaction concurrently
6. let's say that there are two other transactions coming to this node at the exact same time
7. this node takes all of the transactions, makes a list, and this is referred to as a block
8. the node then runs some validation logic from on this block
9. this validation logic is what takes so much time
10. this validation logic is referred to as mining

---

## Smart Contracts

* smart contracts are what write to use write apps on the Ethereum block chain
* a smart contract is an account controlled by code

__Our first smart contract__

* written with Solidity

```
pragma solidity ^0.4.17;

contract Inbox {
    string public message;
    
    function Inbox(string initialMessage) public {
        message = initialMessage;
    }
    
    function setMessage(string newMessage) public {
        message = newMessage;
    }
    
    function getMessage() public view returns (string) {
        return message;
    }
}
```


