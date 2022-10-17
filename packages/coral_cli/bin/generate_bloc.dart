#! /usr/bin/env dcli

import 'dart:io';

import 'package:dcli/dcli.dart' as dcli;
import 'package:recase/recase.dart' as r;

const templateDir = 'bin/templates/bloc';
const fileNames = <String>['analytic_listener', 'bloc', 'event', 'state'];

void main(List<String> args) {
  final applicationPath = args.first;
  final blocsPath = '$applicationPath/lib/blocs/'..replaceAll('//', '/');

  final blocName = dcli.ask(
    '${dcli.green('New bloc name')} (e.g. counter or foo_bar):',
    validator: dcli.Ask.all(
      [
        dcli.Ask.required,
      ],
    ),
  );

  final blocPath = '$blocsPath/$blocName';

  ///
  /// Generate Bloc directory files
  ///
  final files = <dcli.Progress>[];

  for (final fileName in fileNames) {
    files.add(dcli.read('$templateDir/$fileName.txt'));
  }

  if (dcli.exists(blocPath)) {
    dcli.deleteDir(blocPath);
  }

  final path = dcli.createDir(blocPath, recursive: true);
  print('${dcli.grey('\nGenerated Bloc files here:')} $path\n');

  files.asMap().forEach((index, file) {
    final fileWithBlocName = addBlocNameToFile(file, blocName);
    final fileName = fileNames[index];
    '$blocPath/${blocName.snakeCase}_$fileName.dart'.write(fileWithBlocName);
  });

  ///
  /// Update AppBlocObserver
  ///
  final appBlocObserverPath = '$blocsPath/analytic_listeners.dart';
  final appBlocObserverFileCurrent = dcli.read(appBlocObserverPath);
  final appBlocObserverFileNew = appBlocObserverFileCurrent
      .toParagraph()
      .replaceFirst(
        '// CORAL_CLI_IMPORT',
        "import './${blocName.snakeCase}/${blocName.snakeCase}_analytic_listener.dart';\n// CORAL_CLI_IMPORT",
      )
      .replaceFirst(
        '// CORAL_CLI_LISTENER',
        '${blocName.pascalCase}Event_AnalyticListener(),\n  // CORAL_CLI_LISTENER',
      );
  appBlocObserverPath.write(appBlocObserverFileNew);
  print('${dcli.grey('AppBlocObserver updated:')} $appBlocObserverPath\n');

  ///
  /// Update BlocType
  ///
  final coralBlocTypePath = '$blocsPath/bloc_type.dart';
  final coralBlocFileCurrent = dcli.read(coralBlocTypePath);
  final coralBlocFileNew = coralBlocFileCurrent.toParagraph().replaceFirst(
        '// CORAL_CLI_BLOC_TYPE',
        '${blocName.camelCase},\n  // CORAL_CLI_BLOC_TYPE',
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
        "import './${blocName.snakeCase}/${blocName.snakeCase}_bloc.dart';\n// CORAL_CLI_IMPORT",
      )
      .replaceFirst(
        '// CORAL_CLI_DB_THIS',
        'this.${blocName.camelCase}State,\n    // CORAL_CLI_DB_THIS',
      )
      .replaceFirst(
        '// CORAL_CLI_DB_ATTR',
        'final ${blocName.pascalCase}State? ${blocName.camelCase}State;\n  // CORAL_CLI_DB_ATTR',
      )
      .replaceFirst(
        '// CORAL_CLI_COPY_WITH_PARAMETER',
        '${blocName.pascalCase}State? ${blocName.camelCase}State,\n    bool clear${blocName.pascalCase}State = false,\n    // CORAL_CLI_COPY_WITH_PARAMETER',
      )
      .replaceFirst(
        '// CORAL_CLI_COPY_WITH_CLEAR',
        'var _${blocName.camelCase}State = ${blocName.camelCase}State ?? this.${blocName.camelCase}State;\n    if(clear${blocName.pascalCase}State) {\n      _${blocName.camelCase}State = null;\n    }\n    // CORAL_CLI_COPY_WITH_CLEAR',
      )
      .replaceFirst(
        '// CORAL_CLI_COPY_WITH_ARG',
        '${blocName.camelCase}State: _${blocName.camelCase}State,\n      // CORAL_CLI_COPY_WITH_ARG',
      )
      .replaceFirst(
        '// CORAL_CLI_ON_EVENT',
        'case BlocType.${blocName.camelCase}:\n        devtoolsDB = devtoolsDB.copyWith(\n          ${blocName.camelCase}State: state as ${blocName.pascalCase}State,\n        );\n        break;\n      // CORAL_CLI_ON_EVENT',
      )
      .replaceFirst(
        '// CORAL_CLI_ON_CLOSE',
        'case BlocType.${blocName.camelCase}:\n        devtoolsDB = devtoolsDB.copyWith(clear${blocName.pascalCase}State: true);\n        break;\n      // CORAL_CLI_ON_CLOSE',
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

String addBlocNameToFile(dcli.Progress file, String blocName) => file
    .toParagraph()
    .replaceAll('EXAMPLESC', blocName.snakeCase)
    .replaceAll('EXAMPLEPC', blocName.pascalCase)
    .replaceAll('EXAMPLECC', blocName.camelCase);
