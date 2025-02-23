IMG_NAME=ves
IMG_TAG=dobos

build:
	docker build \
		--pull \
		--progress plain \
		-t ${IMG_NAME}:${IMG_TAG} \
		.

push:
	docker push ${IMG_NAME}:${IMG_TAG}

pull:
	docker pull ${IMG_NAME}:${IMG_TAG}

it:
	docker run \
		--rm -it \
		-v $(readlink -f ~):/tmp/home/ \
		${IMG_NAME}:${IMG_TAG} \
		bash
