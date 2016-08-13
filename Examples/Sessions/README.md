# Sessions, a Swift gRPC Sample App

This sample illustrates the use of experimental Swift gRPC APIs in
clients and servers.

The Sessions Xcode project contains a Mac app that can be used to 
instantiate and run local gRPC clients and servers. It depends
on the gRPC Xcode project, which requires a local build of the
gRPC Core C library. To build that, please run "make" in the
root of your gRPC distribution.

When running the app, use the "New" menu option to create new
gRPC sessions. Configure each session using the host and port
fields and the client/server selector, and then press "start"
to begin serving or calling the server that you've specified.

See the "Document" class for client and server implementations.


