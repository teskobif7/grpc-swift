
CFLAGS = -Xcc -ISources/BoringSSL/include

all:
	swift build -v $(CFLAGS)
	cp .build/debug/protoc-gen-swift .
	cp .build/debug/protoc-gen-swiftgrpc .
	
project:
	swift package generate-xcodeproj

test:	all
	swift test -v $(CFLAGS)

test-examples:
	cd Examples/Echo/PackageManager; make test
	cd Examples/Simple/PackageManager; make

test-plugin:
	protoc Examples/Echo/echo.proto --proto_path=Examples/Echo --plugin=.build/debug/protoc-gen-swiftgrpc --swiftgrpc_out=/tmp --swiftgrpc_opt=TestStubs=true
	diff /tmp/echo.grpc.swift Examples/Echo/Generated/echo.grpc.swift

clean:
	rm -rf Packages
	rm -rf .build
	rm -rf SwiftGRPC.xcodeproj
	rm -rf Package.pins Package.resolved
	cd Examples/Echo/PackageManager; make clean
	cd Examples/Simple/PackageManager; make clean
