FVM := $(shell which fvm)
FLUTTER := $(FVM) flutter

.PHONY: get-dependencies
get-dependencies:
	$(FLUTTER) pub get

.PHONY: clean
clean:
	$(FLUTTER) clean

.PHONY: analyze
analyze:
	$(FLUTTER) analyze
	$(FVM) dart run custom_lint

.PHONY: format
format:
	$(FLUTTER) format lib/

.PHONY: format-dry-exit-if-changed
format-dry-exit-if-changed:
	$(FLUTTER) format --dry-run --set-exit-if-changed lib/

.PHONY: build-runner
build-runner:
	$(FLUTTER) packages pub run build_runner build --delete-conflicting-outputs

.PHONY: build-runner-watch
build-runner-watch:
	$(FLUTTER) packages pub run build_runner clean
	$(FLUTTER) packages pub run build_runner watch --delete-conflicting-outputs
