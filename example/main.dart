// Check the repository for [derry.yaml] file and more informative example
// [derry.yaml] will probably look like this
//
// version: dart --version # example that stderr is also shown
// ping: ping google.com && echo ok # example that stdout is served with stream
// # example for list commands
// list:
//   - echo test
//   - echo done
// # example for advanved configurations
// run_once:
//   (execution): once
//   (scripts):
//     - echo test
//     - exit
//     - echo "this wont be called"
// # example for subcommands
// prep:
//   - echo step 1
//   - echo step 2
// test: # call with derry test
//   - $prep
//   - echo pub run test
// build: # call with derry build
//   - \$prep # should not work
//   - echo flutter build
// nested: # example for nested scripts
//   foo:
//     - echo bar

void main() {
  print('Derry.');
}
