# Move into the test folder.
cd test

# Download the dependencies for the test
go get -t -v

# Run the test.
go test -v webserver_test.go