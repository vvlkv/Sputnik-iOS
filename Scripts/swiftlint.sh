cat ./lintPaths.yml ../../lintRules.yml > ./lintConfig.yml
mint run swiftlint swiftlint --config ./lintConfig.yml
