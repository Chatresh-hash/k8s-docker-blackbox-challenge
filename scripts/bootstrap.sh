#!/bin/bash
set -e

echo "🚀 Bootstrapping CI/CD pipeline..."

# 1. Install Git pre-push hook
echo "🔧 Installing Git pre-push hook..."
mkdir -p .git/hooks
cp git-hooks/pre-push.sh .git/hooks/pre-push
chmod +x .git/hooks/pre-push

# 2. Create secrets placeholders
echo "🔑 Creating secrets placeholders..."
cat <<EOF > .github/secrets.env
DOCKER_USERNAME=your-docker-username
DOCKER_PASSWORD=your-docker-password
KUBECONFIG=your-kubeconfig-content
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/XXX/YYY/ZZZ
TEAMS_WEBHOOK_URL=https://outlook.office.com/webhook/XXX/YYY/ZZZ
EOF

echo "⚠️  Remember to add these secrets in GitHub repo settings under Settings → Secrets and variables → Actions."

# 3. Trigger sample tag push
echo "🏷️ Creating sample release tag..."
git tag v0.1.0
git push origin v0.1.0

echo "✅ Bootstrap complete! Workflows will now run:"
echo "   - PR checks"
echo "   - Changelog generation"
echo "   - Docker image build & publish"
echo "   - Kubernetes deploy + rollback"
echo "   - Chaos injection (scheduled/manual)"
echo "   - Dashboard summary"
