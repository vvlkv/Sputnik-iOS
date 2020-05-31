ROOT=../
FRAMEWORKS_PATH=$ROOT/Frameworks
declare -a frameworks=("Database" "Resources" "Utils" "NetworkSputnik" "Service" "SputnikUI")

for name in ${frameworks[@]}; do
  mint run xcodegen xcodegen generate --spec $FRAMEWORKS_PATH/$name/$name.yml --project $FRAMEWORKS_PATH/$name/ --use-cache
done

SANDBOX_NAME=UISandbox
# mint run xcodegen xcodegen generate --spec $ROOT/$SANDBOX_NAME/$SANDBOX_NAME.yml --project $ROOT/$SANDBOX_NAME/ --use-cache
mint run xcodegen xcodegen generate --spec $ROOT/Sputnik.yml --use-cache
