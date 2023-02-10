build:
	docker build -t helm2 -f Dockerfile --build-arg ARCH=$$(uname -m) .