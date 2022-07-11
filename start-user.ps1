

Write-Output "Configuring git..."
git config --global user.name "Jean Honlet"
git config --global user.email jehon@users.noreply.github.com

git config --global push.default current
# Push tags
git config --global push.followtags true
git config --global pull.rebase true
git config --global rebase.autoStash true
git config --global fetch.prune true
git config --global fetch.writeCommitGraph true
git config --global init.defaultBranch main
Write-Output "Configuring git done"

