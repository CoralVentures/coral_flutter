#! /usr/bin/env dcli

import 'dart:io';

import 'package:dcli/dcli.dart' as dcli;
import 'package:recase/recase.dart' as r;

const templateFilePath = 'bin/templates/cubit/cubit.txt';

void main(List<String> args) {
  final applicationPath = args.first;
  final blocsPath = '$applicationPath/lib/blocs'..replaceAll('//', '/');
  final cubitsPath = '$applicationPath/lib/blocs/cubits'..replaceAll('//', '/');

  final cubitPrefix = dcli.ask(
    '${dcli.green('Cubit name')} (e.g. Foo):',
  );

  final cubitName = '${cubitPrefix}Cubit';

  ///
  /// Generate Cubit file
  ///

  final file = dcli.read(templateFilePath);
  final fileWithCubitName = addCubitNameToFile(file, cubitName);
  '$cubitsPath/${cubitName.snakeCase}.dart'.write(fileWithCubitName);

  print(
    '${dcli.grey('\nGenerated cubit file here:')} $cubitsPath/${cubitName.snakeCase}.dart\n',
  );

  ///
  /// Update BlocType
  ///
  final coralBlocTypePath = '$blocsPath/bloc_type.dart';
  final coralBlocFileCurrent = dcli.read(coralBlocTypePath);
  final coralBlocFileNew = coralBlocFileCurrent.toParagraph().replaceFirst(
        '// CORAL_CLI_BLOC_TYPE',
        '${cubitName.camelCase},\n  // CORAL_CLI_BLOC_TYPE',
      );
  coralBlocTypePath.write(coralBlocFileNew);
  print('${dcli.grey('BlocType updated:')} $coralBlocTypePath\n');

  ///
  /// Update DevtoolsDb
  ///
  final remoteDevtoolsPath = '$blocsPath/redux_remote_devtools.dart';
  final remoteDevtoolsFileCurrent = dcli.read(remoteDevtoolsPath);
  final remoteDevtoolsFileNew = remoteDevtoolsFileCurrent
      .toParagraph()
      .replaceFirst(
        '// CORAL_CLI_IMPORT',
        "import './${cubitName.snakeCase}/${cubitName.snakeCase}_bloc.dart';\n// CORAL_CLI_IMPORT",
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
  Process.run('bin/build_runner.sh', [applicationPath]).then((value) {
    print(
      dcli.orange('Note: you will likely need to restart your analysis server'),
    );
  });
}

String addCubitNameToFile(dcli.Progress file, String cubitName) => file
    .toParagraph()
    .replaceAll('EXAMPLESC', cubitName.snakeCase)
    .replaceAll('EXAMPLEPC', cubitName.pascalCase)
    .replaceAll('EXAMPLECC', cubitName.camelCase);
