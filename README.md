KRL Ethernet Streaming
======================

A server program and accompanying KRL module for asynchronous streaming of arbitrary KRL programs, for a limited but useful subset of the language. This can be used for iterating on programs without the need for flash drives and constant file copying, or reactive programs with a slow response time (e.g. scan and mill loops). It does not allow true real-time control (e.g. jogging with an XBox controller); RSI should be used for these workflows. 
The software is designed for use alongside a Raspberry Pi as an intermediate controller for custom tool heads, and the TOOL_COMMAND functions are written with this assumption. 

Currently implemented commands include:
LIN, PTP, HALT, WAIT SEC, TOOL_COMMAND

Installation
------------

The EthernetKRL software package is required.  
RPiBinaryFixed.xml and ProgramServer.xml should be copied to the EthernetKRL config folder, and the ethernet_streaming module copied to the appropriate folder in R1. The server program can be run from the Processing IDE or exported. 

Ensure the development computer's ip address is on the same subnet as the robot, matches the ip address in ProgramServer.xml, and is connected to the Robots ethernet port or switch. 

Usage
=====
First open the server on the development computer. Drap-and-drop a KRL .src file onto the window; the program will indicate which commands will be streamed. 
Next open the ethernet_streaming module on the pendant. Running the program will continuously interpret and execute from a buffer of commands from the server, occasionally requesting a new block of commands. The reset button on the server will start the program from the beginning. 
New programs can be loaded by dragging a new .src file into the window. Do not load a new program while the ethernet_streaming module is running, as this may produce unintended or dangerous results.

Implementation
--------------
Commands are sent via fixed-length 28 byte long messages. These are composed of :   
1 : 1 byte command, e.g. LIN, PTP, etc   
1 : 1 byte tool command, passed on to the tool controller  
6 : 4 byte REAL variables, representing POS or AXIS positions  
1 : 1 byte STATUS for PTP commands  
1 : 1 byte TURN for PTP commands  

