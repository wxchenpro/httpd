all: build

.PHONY: build
build:
	go build

.PHONY: format
format:
	find . -name '*.go' -exec gofmt -s -w {} +

.PHONY: check
check:
	golangci-lint run --out-format=tab --new-from-rev master ./...

.PHONY: container
container:
	docker build --rm --pull --no-cache -t bytepowered/httpd .
