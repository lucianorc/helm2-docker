CMD := docker build -t helm2 -f Dockerfile --build-arg ARCH=$$(uname -m) .

@: base gcp

base:
	$(CMD) --target base

gcp:
	$(CMD) --target gcp