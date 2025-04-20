# IPFS: 

Interplanetary file system acts as a storage for storing any metadata, including images for NFTs, in a decentralized way. 

## How It Works: 
- You can check out ipfs.io
- The code/file is first hashed to get a unique output.
- You can pin your hashed data to your node. 
- That node is connected to other nodes in the network.
- Other nodes can pin the data from your node to copy and distribute it along the network.
- In a distributed system, nodes pinning other nodes' data ensures availability.
- In contrast to blockchain, IPFS datanodes have the option to choose which data to pin.
- IPFS is just decentralized storage, no execution.

# Using Chisel: 
'chisel' is a command line tool that helps with debugging instantiated objects in solidity. 
Examples: 
-> string memory cat = "cat";
-> cat
prints the hex value of cat. 

-> bytes memory encodedCat = abi.encodePacked(cat);
will return an object of dynamic bytes, which we can hash.
-> bytes32 catHash = keccak256(encodedCat);

This will return a bytes32 object, which is easier to compare than strings.