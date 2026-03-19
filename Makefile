REACT_DIR = frontend
DEMO_DIR = demo

.PHONY: all build-react prepare-demo publish deploy clean

all: deploy

build-react:
	@echo "🏗️ Building the React application..."
	cd $(REACT_DIR) && npm install && npm run build

prepare-demo:
	@echo "📂 Moving compiled React files to the Quarto demo directory..."
	mkdir -p $(DEMO_DIR)
	rm -rf $(DEMO_DIR)/*
	cp -R $(REACT_DIR)/dist/* $(DEMO_DIR)/

deploy: build-react prepare-demo publish
	@echo "✅ Deployment complete!"

publish:
	quarto publish gh-pages

preview:
	quarto preview index.ipynb

clean:
	@echo "🧹 Cleaning up local builds..."
	rm -rf $(DEMO_DIR)/*
	rm -rf $(REACT_DIR)/dist