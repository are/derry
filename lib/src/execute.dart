part of derry;

/// The function to execute scripts from ffi, which
/// takes a [YamlMap] of definitions, an argument to parse and execute,
/// an extra bit of command which will be passed down to the script,
/// a `boolean` value to decide whether to print output
/// or not, and a [String] to print before executing the script.
void execute(
  Map definitions,
  String arg, {
  String extra = '',
  bool silent = false,
  String infoLine,
}) {
  final searchResult = search(definitions, arg);

  /// for incomplete calls for nested scripts
  if (searchResult is YamlMap && !searchResult.value.containsKey('(scripts)')) {
    throw Error(
      type: ErrorType.snf,
      body: {
        'script': arg,
        'definitions': makeKeys(definitions),
      },
    );
  }

  final definition = parseDefinition(searchResult);

  if (infoLine != null) stdout.writeln(infoLine);
  switch (definition.execution) {
    case 'once':
      final script = definition.scripts.join(' && ');
      executor('$script $extra', silent);
      break;
    case 'multiple':
      for (final script in definition.scripts) {
        final sub = subcommand(script);
        if (sub['command'].isNotEmpty) {
          execute(
            definitions,
            sub['command'],
            extra: sub['extra'],
            silent: silent,
          );
        } else {
          // replace all \$ with $ but are not subcommands
          final unparsed = script.replaceAll('\\\$', '\$');
          executor('$unparsed $extra', silent);
        }
      }
      break;
    default:
      throw 'Incorrect execution type ${definition.execution}.';
      break;
  }
}
