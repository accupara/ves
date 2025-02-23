IMG_NAME=ves
IMG_TAG=dobos

build:
	docker build \
		--pull \
		-t ${IMG_NAME}:${IMG_TAG} \
		.
