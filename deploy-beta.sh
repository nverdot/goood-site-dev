echo "########## Déploiement en béta ##########" 
read "Entrez le descriptif des changements et tapez [ENTRÉE]: " commitmsg
if test commitmsg -eq ""
then
    echo "Commit message empty. Exiting."
    exit -1
fi
set -e
GITURL=https://github.com/gooodhub/goood-site-dev.git
if [ -d "./dist" ]
then
rm -rf dist
fi
git clone -b gh-pages --single-branch $GITURL dist
cd dist
git checkout gh-pages
# ls -a | grep -v '^\.$' | grep -v '^\.\.$' | grep -v '^\.git$' | xargs rm -rf
mv .git ../gitdeploy
cd ..
npm install
NODE_ENV=production node index.js
cd dist
mv ../gitdeploy .git
git add .
git commit -am "$commitmsg"
git push --force 
cd ..