.gitignore
In the root directory of your app and simply write

**/.DS_Store
In it. This will never allow the .DS_Store file to sneak in your git.

But, if it's already there, write in your terminal:

find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch
then commit and push the changes to remove the .DS_Store from your remote repo:

git commit -m "Remove .DS_Store from everywhere"

git push origin master
