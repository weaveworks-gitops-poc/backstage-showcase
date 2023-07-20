VERSION ?= $(shell git describe --tags --always)
IMAGE_BASE ?= bigkevmcd/backstage-image
IMG ?= ${IMAGE_BASE}:${VERSION}

.PHONY: build
build:
	yarn install --frozen-lockfile
	yarn tsc
	yarn build:backend --config ../../app-config.kubernetes.yaml

.PHONY: docker-build
docker-build: build
	docker build . -f packages/backend/Dockerfile -t ${IMG}

.PHONY: docker-push
docker-push: ## Push docker image with the manager.
	docker push ${IMG}
