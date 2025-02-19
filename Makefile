PROTO_DIR=.

.PHONY: proto-lint proto-gen proto-clean

# Lint all proto files in the repository
proto-lint:
	@buf lint
	@echo "✅ Protobuf linting complete."

# Generate all protobuf files
proto-gen:
	@buf generate
	@echo "✅ Protobuf files generated successfully."

# Remove all generated files
proto-clean:
	@find $(PROTO_DIR) -name "*.pb.go" -type f -delete
	@echo "🧹 All generated protobuf files removed."
