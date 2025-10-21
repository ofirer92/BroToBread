# GitHub Pages Deployment Guide

This document explains how to deploy the BroToBread Flutter web app to GitHub Pages.

## Automatic Deployment (Recommended)

The project is configured with GitHub Actions for automatic deployment.

### Setup Steps

1. **Enable GitHub Pages**:
   - Go to your repository on GitHub
   - Navigate to `Settings` → `Pages`
   - Under "Source", select `GitHub Actions`
   - Save the settings

2. **Push to Main Branch**:
   - Any push to `main` or `master` branch will trigger automatic deployment
   - You can also manually trigger the workflow from the Actions tab

3. **Access Your Site**:
   - After deployment completes (usually 2-5 minutes)
   - Visit: `https://ofirer92.github.io/BroToBread/`

### Workflow Details

The GitHub Actions workflow (`.github/workflows/deploy-github-pages.yml`) automatically:
- Checks out the code
- Sets up Flutter environment
- Installs dependencies
- Builds the web app with correct base-href
- Deploys to GitHub Pages

## Manual Deployment (Alternative)

If you prefer to deploy manually:

### Option 1: Using GitHub Actions Manually

1. Go to the `Actions` tab in your GitHub repository
2. Select the "Deploy Flutter Web to GitHub Pages" workflow
3. Click "Run workflow"
4. Select the branch (main/master)
5. Click "Run workflow" button

### Option 2: Local Build and Push

1. **Build the web app locally**:
```bash
flutter build web --release --base-href /BroToBread/
```

2. **Install gh-pages package** (if not already):
```bash
npm install -g gh-pages
```

3. **Deploy to gh-pages branch**:
```bash
gh-pages -d build/web
```

## Troubleshooting

### Pages Not Showing Up
- Check that GitHub Pages is enabled in repository settings
- Verify the workflow completed successfully in the Actions tab
- Clear browser cache and try again
- Check that the base-href in the workflow matches your repository name

### Build Failures
- Check the Actions tab for error messages
- Ensure all dependencies are properly listed in `pubspec.yaml`
- Verify Flutter version compatibility

### 404 Errors on Refresh
- This is normal for Flutter web SPAs on GitHub Pages
- The app uses client-side routing
- Consider adding a 404.html that redirects to index.html if needed

## Custom Domain (Optional)

To use a custom domain:

1. **Add CNAME file**:
```bash
echo "yourdomain.com" > web/CNAME
```

2. **Configure DNS**:
   - Add a CNAME record pointing to `ofirer92.github.io`
   - Or add A records for GitHub Pages IPs

3. **Enable in GitHub Settings**:
   - Go to Settings → Pages
   - Enter your custom domain
   - Enable "Enforce HTTPS"

## Environment Variables

The workflow uses these configurations:
- **Flutter Version**: 3.24.0 (stable channel)
- **Base URL**: `/BroToBread/`
- **Build Mode**: Release
- **Platform**: Web

## Monitoring Deployments

- View deployment history in the `Actions` tab
- Each deployment creates a new commit to the `gh-pages` branch
- Check deployment status in `Settings` → `Pages`

## Security

The workflow uses GitHub's built-in GITHUB_TOKEN with these permissions:
- `contents: read` - Read repository content
- `pages: write` - Deploy to GitHub Pages
- `id-token: write` - Required for GitHub Pages deployment

---

For issues or questions, please check:
- [GitHub Pages Documentation](https://docs.github.com/pages)
- [Flutter Web Documentation](https://docs.flutter.dev/platform-integration/web)
- Repository Issues tab
