# come cli

## init main cli

```sh
# config author name and email for git
git config --global user.email "ymc.github@gmail.com"
git config --global user.name "yemiancheng"

# initing file
git add .editorconfig .gitignore license readme.md package.json

# lint commit msg for git
cat ./.git/COMMIT_EDITMSG | ./node_modules/.bin/commitlint

git commit --file ./.git/COMMIT_EDITMSG
```

## push to git

```sh
GITHUB_REPO=vscode-snippet-shell
# the first push
git remote add origin https://github.com/YMC-GitHub/${GITHUB_REPO}.git
git push -u origin master

# tag and push
git tag v1.0.0
git push origin master --tags
```

## push to npm
```sh
npm publish --dry-run
npm publish
```

## push to vscode extension

```sh
npm install -g vsce


vsce create-publisher yemiancheng
echo "login remote ext server"
vsce login yemiancheng
echo "gen ext xx.vsix file"
vsce package
#echo "mv ext xx.vsix file to archive dir"

token=(cat secret/vs-token.txt)
echo "push ext xx.vsix file"
#vsce publish --help
vsce publish --pat "$token"

#https://code.visualstudio.com/api/working-with-extensions/publishing-extension
```
