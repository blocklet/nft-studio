TOP_DIR=.
README=$(TOP_DIR)/README.md

VERSION=$(strip $(shell cat version))

init: install dep
	@echo "Init project successfully!"

github-init: install dep
	@echo "Initialize software required for (normally ubuntu software)"
	@sudo npm i -g @blocklet/cli dotenv-flow-cli
	@git checkout yarn.lock

install:
	@echo "Install software required for this repo..."
	@npm install -g lerna yarn

dep:
	@echo "Install dependencies required for this repo..."
	@lerna bootstrap && lerna link
	@cd packages/core && npm run build
	@cd packages/client && npm run build
	@cd packages/fs-driver && npm run build
	@cd packages/s3-driver && npm run build

test:
	@echo "Running test suites..."
	@npm run test

lint:
	@echo "Linting the software..."
	@npm run lint

clean:
	@echo "Cleaning the build..."
	@lerna exec --no-bail -- "rm -rf coverage"
	@lerna exec --no-bail -- "rm -rf .blocklet"

coverage:
	@echo "Running unit tests and collecting coverage..."
	@npm run coverage

clean: 
	@npm run clean

include .makefiles/*.mk

.PHONY: build install dep test clean bump-version