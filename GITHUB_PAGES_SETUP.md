# GitHub Pages Setup Instructions

Follow these steps to deploy your BroToBread app to GitHub Pages.

## Step 1: Merge to Main Branch

Since the GitHub Pages workflow is configured to run on the `main` or `master` branch, you need to merge this feature branch first.

### Option A: Via GitHub Web Interface (Recommended)

1. **Go to your repository on GitHub**:
   - Visit: https://github.com/ofirer92/BroToBread

2. **Create a Pull Request**:
   - Click on "Pull requests" tab
   - Click "New pull request"
   - Set base branch to `main` (or `master`)
   - Set compare branch to `claude/improve-mobile-ux-011CUKrdSwhKyEX1KhySd6ZG`
   - Click "Create pull request"
   - Add title: "Add mobile UX improvements and GitHub Pages deployment"
   - Click "Create pull request"

3. **Merge the Pull Request**:
   - Review the changes
   - Click "Merge pull request"
   - Click "Confirm merge"

### Option B: Create Main Branch from Feature Branch

If there's no `main` branch yet:

1. **On GitHub, go to Settings**:
   - Click on "Settings" tab
   - Click on "Branches" in the left sidebar
   - Under "Default branch", click the pencil icon
   - Create a new branch called `main` from `claude/improve-mobile-ux-011CUKrdSwhKyEX1KhySd6ZG`

## Step 2: Enable GitHub Pages

1. **Go to Repository Settings**:
   - Click on "Settings" tab in your repository
   - Scroll down to "Pages" in the left sidebar

2. **Configure Source**:
   - Under "Build and deployment"
   - Under "Source", select **"GitHub Actions"** (not "Deploy from a branch")
   - This will use the workflow we created

3. **Save** (if prompted)

## Step 3: Verify Deployment

1. **Check GitHub Actions**:
   - Go to the "Actions" tab in your repository
   - You should see the "Deploy Flutter Web to GitHub Pages" workflow running
   - Wait for it to complete (usually 2-5 minutes)

2. **Access Your Site**:
   - Once the workflow succeeds, your site will be available at:
   - **https://ofirer92.github.io/BroToBread/**
   - This link is also shown in Settings → Pages

## Step 4: Set as Default Branch (Optional)

To make future deployments automatic:

1. **Go to Settings → Branches**
2. **Set default branch to `main`**
3. **Any future push to `main` will auto-deploy**

## Manual Deployment Trigger

You can manually trigger a deployment anytime:

1. Go to "Actions" tab
2. Select "Deploy Flutter Web to GitHub Pages" workflow
3. Click "Run workflow"
4. Select branch (main/master)
5. Click "Run workflow" button

## Troubleshooting

### Workflow Not Running
- **Cause**: GitHub Pages not set to "GitHub Actions" source
- **Solution**: Go to Settings → Pages → Source → Select "GitHub Actions"

### Build Fails
- **Check**: Actions tab for error logs
- **Common issue**: Missing dependencies
- **Solution**: Ensure `pubspec.yaml` lists all dependencies

### 404 Page Not Found
- **Cause**: Base href mismatch
- **Solution**: Verify repository name matches "BroToBread" exactly
- Current base-href: `/BroToBread/`

### Changes Not Appearing
- **Clear browser cache**: Ctrl+Shift+R (Windows/Linux) or Cmd+Shift+R (Mac)
- **Wait 2-5 minutes** for CDN propagation
- **Check deployment**: Ensure workflow completed successfully

## What's Deployed

The workflow automatically:
- ✅ Sets up Flutter 3.24.0 stable
- ✅ Installs project dependencies
- ✅ Builds optimized web release
- ✅ Configures correct base URL
- ✅ Deploys to GitHub Pages
- ✅ Makes site available at ofirer92.github.io/BroToBread

## Next Steps

After successful deployment:

1. **Test on mobile devices**: Visit the URL from your phone
2. **Share the link**: The app is now publicly accessible
3. **Monitor**: Check Actions tab for deployment history
4. **Update**: Any push to main will auto-deploy changes

## Need Help?

- Check [DEPLOYMENT.md](./DEPLOYMENT.md) for detailed deployment options
- Review workflow file: `.github/workflows/deploy-github-pages.yml`
- GitHub Pages docs: https://docs.github.com/pages
- Flutter Web docs: https://docs.flutter.dev/platform-integration/web

---

**Note**: The deployment is completely automated. Once you merge to main and enable GitHub Pages with "GitHub Actions" source, every push to main will automatically deploy your app!
