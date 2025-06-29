# Build Setup Guide

This document describes the build environment and release process for the Metadata Menu Obsidian plugin.

## Local Development Environment

### Prerequisites
- Node.js 18+ 
- npm

### Setup
1. Clone the repository
2. Install dependencies: `npm install`
3. Verify setup: `npm run verify`

### Available Scripts

| Script | Description |
|--------|-------------|
| `npm run build` | Build TypeScript and bundle with esbuild (production) |
| `npm run build:css` | Compile SCSS to CSS |
| `npm run dev` | Development mode with watch and debug enabled |
| `npm run dev:silent` | Development mode with watch (no debug output) |
| `npm run build:css:watch` | Watch CSS files for changes |
| `npm run verify` | Complete build verification |

### Build Artifacts
- `main.js` - Compiled and bundled plugin code
- `styles.css` - Compiled CSS styles
- `manifest.json` - Plugin manifest file

### Test Vault
The build process automatically updates the test vault at `test-vault-mdm/` with the latest build artifacts for testing in Obsidian.

## GitHub Actions Workflows

### Build and Test (`build.yml`)
- **Triggers**: Push to main/master, Pull requests
- **Purpose**: Verify builds work correctly
- **Actions**: Install dependencies, type check, build CSS, verify artifacts

### Release (`release.yml`)
- **Triggers**: Push tags matching `v*` (e.g., `v1.0.0`)
- **Purpose**: Create GitHub releases with built artifacts
- **Actions**: 
  - Build the plugin
  - Create GitHub release
  - Attach `main.js`, `styles.css`, and `manifest.json`

## Release Process

### 1. Update Version
```bash
npm run version
```
This updates version numbers in `manifest.json` and `versions.json`.

### 2. Create Release
```bash
git add .
git commit -m "Release v1.0.0"
git tag v1.0.0
git push origin main
git push origin v1.0.0
```

### 3. Automatic Release
The GitHub Actions workflow will automatically:
- Build the plugin
- Create a GitHub release
- Attach the built files
- Generate release notes

## Development Workflow

1. **Start development**: `npm run dev` (watches for changes)
2. **Make changes** to TypeScript/SCSS files
3. **Test changes** in the test vault
4. **Build for production**: `npm run build && npm run build:css`
5. **Verify build**: `npm run verify`

## Troubleshooting

### Build Issues
- Ensure Node.js 18+ is installed
- Run `npm install` to install dependencies
- Check TypeScript errors: `npx tsc --noEmit`
- Verify esbuild configuration in `esbuild.config.mjs`

### CSS Issues
- Ensure SASS is installed: `npm install -g sass`
- Check SCSS syntax in `src/assets/css/`
- Verify CSS compilation: `npm run build:css`

### Test Vault Issues
- Ensure the test vault directory exists
- Check file permissions
- Verify the plugin is enabled in Obsidian test vault 