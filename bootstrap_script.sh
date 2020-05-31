NETWORK_FRAMEWORK="NetworkSputnik"

#Folders
mkdir -p Frameworks/${NETWORK_FRAMEWORK}/${NETWORK_FRAMEWORK}/Resources/Generated/
mkdir -p Frameworks/${NETWORK_FRAMEWORK}/${NETWORK_FRAMEWORK}/Service/Generated/

#brew dependencies
brew bundle

#mint dependencies
mint bootstrap

declare -a frameworks=("Resources" ${NETWORK_FRAMEWORK} "Database" "Service" "SputnikUI" "Utils")

for name in ${frameworks[@]}; do
  cp -a Mintfile Frameworks/$name/
done
cp -a Mintfile UISandbox/

#git submodules
git submodule update --init --recursive

#carthage
carthage bootstrap --cache-builds --platform iOS

(cd Scripts; sh xcodegen_script.sh)
