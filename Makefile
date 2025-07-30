.PHONY: dist app-build app-install app-clean docker-build docker-clean help

# Default target - full distribution build
dist: app-clean app-install app-build docker-build
	@echo "Distribution build complete"

# App subcommands
app-build:
	@echo "Building TypeScript..."
	@pnpm build

app-install:
	@echo "Installing dependencies..."
	@pnpm install

app-clean:
	@echo "Cleaning build artifacts..."
	@rm -rf dist/

# Docker subcommands
docker-build:
	@echo "Building Docker image..."
	@pnpm docker:build

docker-clean:
	@echo "Stopping and removing mcp-worker-ts containers..."
	@docker ps -q --filter "ancestor=mcp-worker-ts" | xargs -r docker stop
	@docker ps -aq --filter "ancestor=mcp-worker-ts" | xargs -r docker rm
	@echo "Containers cleaned"

# Convenience aliases for space syntax
app:
	@echo "Usage: make app-build, make app-install, make app-clean"

docker:
	@echo "Usage: make docker-build, make docker-clean"

# Help
help:
	@echo "Available targets:"
	@echo "  make dist          - Full build (clean + install + TypeScript + Docker)"
	@echo "  make app-build     - Build TypeScript"
	@echo "  make app-install   - Install dependencies"
	@echo "  make app-clean     - Clean build artifacts"
	@echo "  make docker-build  - Build Docker image"
	@echo "  make docker-clean  - Remove all mcp-worker-ts containers"
	@echo "  make help          - Show this help message"