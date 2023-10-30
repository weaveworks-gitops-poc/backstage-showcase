VERSION ?= $(shell git describe --tags --always)
IMAGE_BASE ?= bigkevmcd/backstage
IMG ?= ${IMAGE_BASE}:${VERSION}

.PHONY: build
build:
	yarn install --frozen-lockfile
	yarn tsc
	yarn build:backend --config ../../app-config.kubernetes.yaml

.PHONY: docker-build
docker-build:
	docker build . -f ./Dockerfile --no-cache -t ${IMG}

.PHONY: docker-push
docker-push: ## Push docker image with the manager.
	docker push ${IMG}
