
.PHONY: build-image
build-image:
	docker build . -t test-project-creation-script:latest

.PHONY: run-test-image
run-test-image: build-image
	docker run --rm test-project-creation-script:latest
