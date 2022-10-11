#! /usr/bin/env dcli

import 'dart:io';

import 'package:dcli/dcli.dart' as dcli;
import 'package:recase/recase.dart' as r;

const templateFilePath = 'bin/templates/cubit/cubit.txt';
const cubitPath = '../../lib/blocs/cubits';

void main(List<String> args) {
  final cubitName = dcli.ask(
    '${dcli.green('Cubit name')} (e.g. FooCubit):',
  );

  ///
  /// Generate Cubit file
  ///

  final file = dcli.read(templateFilePath);
  final fileWithCubitName = addCubitNameToFile(file, cubitName);
  '$cubitPath/${cubitName.snakeCase}.dart'.write(fileWithCubitName);

  print(
    '${dcli.grey('\nGenerated cubit file here:')} $cubitPath/${cubitName.snakeCase}.dart\n',
  );

  ///
  /// Update BlocType
  ///
  const coralBlocPath = '../../lib/blocs/blocs.dart';
  final coralBlocFileCurrent = dcli.read(coralBlocPath);
  final coralBlocFileNew = coralBlocFileCurrent.toParagraph().replaceFirst(
        '// CORAL_CLI_BLOC_TYPE',
        '${cubitName.camelCase},\n  // CORAL_CLI_BLOC_TYPE',
      );
  coralBlocPath.write(coralBlocFileNew);
  print('${dcli.grey('BlocType updated:')} $coralBlocPath\n');

  ///
  /// Update DevtoolsDb
  ///
  const remoteDevtoolsPath = '../../lib/blocs/redux_remote_devtools.dart';
  final remoteDevtoolsFileCurrent = dcli.read(remoteDevtoolsPath);
  final remoteDevtoolsFileNew = remoteDevtoolsFileCurrent
      .toParagraph()
      .replaceFirst(
        '// CORAL_CLI_IMPORT',
        "import './cubits/${cubitName.snakeCase}.dart';\n// CORAL_CLI_IMPORT",
      )
      .replaceFirst(
        '// CORAL_CLI_DB_THIS',
        'this.${cubitName.camelCase}State,\n    // CORAL_CLI_DB_THIS',
      )
      .replaceFirst(
        '// CORAL_CLI_DB_ATTR',
        'final ${cubitName.pascalCase}State? ${cubitName.camelCase}State;\n  // CORAL_CLI_DB_ATTR',
      )
      .replaceFirst(
        '// CORAL_CLI_COPY_WITH_PARAMETER',
        '${cubitName.pascalCase}State? ${cubitName.camelCase}State,\n    bool clear${cubitName.pascalCase}State = false,\n    // CORAL_CLI_COPY_WITH_PARAMETER',
      )
      .replaceFirst(
        '// CORAL_CLI_COPY_WITH_CLEAR',
        'var _${cubitName.camelCase}State = ${cubitName.camelCase}State ?? this.${cubitName.camelCase}State;\n    if(clear${cubitName.pascalCase}State) {\n      _${cubitName.camelCase}State = null;\n    }\n    // CORAL_CLI_COPY_WITH_CLEAR',
      )
      .replaceFirst(
        '// CORAL_CLI_COPY_WITH_ARG',
        '${cubitName.camelCase}State: _${cubitName.camelCase}State,\n      // CORAL_CLI_COPY_WITH_ARG',
      )
      .replaceFirst(
        '// CORAL_CLI_ON_EVENT',
        'case BlocType.${cubitName.camelCase}:\n        devtoolsDB = devtoolsDB.copyWith(\n          ${cubitName.camelCase}State: state as ${cubitName.pascalCase}State,\n        );\n        break;\n      // CORAL_CLI_ON_EVENT',
      )
      .replaceFirst(
        '// CORAL_CLI_ON_CLOSE',
        'case BlocType.${cubitName.camelCase}:\n        devtoolsDB = devtoolsDB.copyWith(clear${cubitName.pascalCase}State: true);\n        break;\n      // CORAL_CLI_ON_CLOSE',
      );
  remoteDevtoolsPath.write(remoteDevtoolsFileNew);
  print('${dcli.grey('DevtoolsDb updated:')} $remoteDevtoolsPath\n');

  ///
  /// Update Json Serialization
  ///

  print('Please wait while build_runner is running...');
  Process.run('bin/build_runner.sh', []).then((value) {
    print(
      dcli.orange('Note: you will likely need to restart your analysis server'),
    );
  });
}

String addCubitNameToFile(dcli.Progress file, String blocName) => file
    .toParagraph()
    .replaceAll('EXAMPLESC', blocName.snakeCase)
    .replaceAll('EXAMPLEPC', blocName.pascalCase)
    .replaceAll('EXAMPLECC', blocName.camelCase);
