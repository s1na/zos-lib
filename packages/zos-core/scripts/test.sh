# Exit script as soon as a command fails.
set -o errexit

run_lib_tests() {
  echo "Testing root project..."
  node_modules/.bin/truffle compile
  node_modules/.bin/truffle test "$@"
}

run_example_tests() {
  echo "Testing examples..."
  npm run prepack
  cd ../zos-complex-example
  npm i
  npm test
}

if [ "$SOLIDITY_COVERAGE" = true ]; then
  echo "Measuring coverage..."
  node_modules/.bin/solidity-coverage
  if [ "$CONTINUOUS_INTEGRATION" = true ]; then
    cat coverage/lcov.info | node_modules/.bin/coveralls
  fi
else
  run_lib_tests && run_example_tests
fi
