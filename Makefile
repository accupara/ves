IMG_NAME=ves
IMG_TAG=dobos

build:
	docker build \
		--pull \
		--progress plain \
		-t ${IMG_NAME}:${IMG_TAG} \
		.
