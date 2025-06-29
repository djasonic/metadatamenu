#!/bin/bash

echo "🔍 Verifying build environment..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed"
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed"
    exit 1
fi

# Check if dependencies are installed
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

# Build the plugin
echo "🔨 Building plugin..."
npm run build

# Build CSS
echo "🎨 Building CSS..."
npm run build:css

# Check if build artifacts exist
if [ -f "main.js" ] && [ -f "styles.css" ] && [ -f "manifest.json" ]; then
    echo "✅ Build successful!"
    echo "📁 Build artifacts:"
    ls -lh main.js styles.css manifest.json
else
    echo "❌ Build failed - missing artifacts"
    exit 1
fi

# Check if test vault was updated
if [ -f "test-vault-mdm/.obsidian/plugins/metadata-menu/main.js" ]; then
    echo "✅ Test vault updated successfully"
else
    echo "⚠️  Test vault not updated"
fi

echo "🎉 Build environment is ready!" 