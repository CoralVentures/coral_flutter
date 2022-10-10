enum CoralTesterRecords {
  testDescription,
  checkpoint,
  screen,
}

abstract class CoralTesterRecord {
  CoralTesterRecord({
    required this.recordType,
  });

  final CoralTesterRecords recordType;

  String toMarkdown();
}

class CoralTesterTestDescription extends CoralTesterRecord {
  CoralTesterTestDescription({
    super.recordType = CoralTesterRecords.testDescription,
    required this.description,
  });

  final String description;

  @override
  String toString() {
    return '''
====================
$description
====================
''';
  }

  @override
  String toMarkdown() {
    return '# $description\n';
  }
}

class CoralTesterScreen extends CoralTesterRecord {
  CoralTesterScreen({
    super.recordType = CoralTesterRecords.screen,
    required this.screenName,
  });

  final String screenName;

  @override
  String toString() {
    return '--- SCREEN: $screenName ---\n';
  }

  @override
  String toMarkdown() {
    return '\n## $screenName\n';
  }
}

enum CoralTesterActions { tap }

class CoralTesterAction {
  CoralTesterAction({
    required this.action,
    required this.finderDescription,
  });

  final CoralTesterActions action;
  final String finderDescription;

  @override
  String toString() {
    return '${action.name.toUpperCase()}: $finderDescription';
  }
}

class CoralTesterCheckpoint extends CoralTesterRecord {
  CoralTesterCheckpoint({
    super.recordType = CoralTesterRecords.checkpoint,
    required this.screenshotPath,
    required this.expectationReasons,
    required this.actions,
    required this.events,
    required this.analytics,
    this.comment,
  });

  final String screenshotPath;
  final List<String> expectationReasons;
  final List<CoralTesterAction> actions;
  final List<Type> events;
  final List<String> analytics;
  final String? comment;

  @override
  String toString() {
    final buffer = StringBuffer();

    if (comment != null) {
      buffer
        ..writeln(comment)
        ..writeln();
    }

    if (expectationReasons.isNotEmpty) {
      buffer.writeln('Expect:');

      for (final element in expectationReasons) {
        buffer.writeln('  $element');
      }
      buffer.writeln();
    }

    if (actions.isNotEmpty) {
      buffer.writeln('Actions:');

      for (final element in actions) {
        buffer.writeln('  $element');
      }

      buffer.writeln();
    }

    if (events.isNotEmpty) {
      buffer.writeln('Events:');

      for (final element in events) {
        buffer.writeln('  $element');
      }

      buffer.writeln();
    }

    if (analytics.isNotEmpty) {
      buffer.writeln('Analytics:');

      for (final element in analytics) {
        buffer.writeln('  $element');
      }
      buffer.writeln();
    }

    buffer.writeln('---');

    return buffer.toString();
  }

  @override
  String toMarkdown() {
    final buffer = StringBuffer();

    if (comment != null) {
      buffer.write('\n### $comment\n');
    }

    buffer.write(
      '''
<table>
  <tbody>
   <tr>
      <td>
''',
    );

    if (expectationReasons.isNotEmpty) {
      buffer
        ..writeln('<b>Expect:</b>')
        ..writeln('<ul>');
      for (final element in expectationReasons) {
        buffer.writeln('  <li>$element</li>');
      }
      buffer.writeln('</ul>');
    }

    if (actions.isNotEmpty) {
      buffer
        ..writeln('<b>Actions:</b>')
        ..writeln('<ul>');
      for (final element in actions) {
        buffer.writeln('  <li>$element</li>');
      }
      buffer.writeln('</ul>');
    }

    if (events.isNotEmpty) {
      buffer
        ..writeln('<b>Events:</b>')
        ..writeln('<ul>');
      for (final element in events) {
        buffer.writeln('  <li>$element</li>');
      }
      buffer.writeln('</ul>');
    }

    if (analytics.isNotEmpty) {
      buffer
        ..writeln('<b>Analytics:</b>')
        ..writeln('<ul>');
      for (final element in analytics) {
        buffer.writeln('  <li>$element</li>');
      }
      buffer.writeln('</ul>');
    }

    buffer.write(
      '''
      </td>
      <td>
      <img src="../test/user_stories/goldens/$screenshotPath.iphone11.png">
      </td>
   </tr>
  </tbody>
</table>
''',
    );

    return buffer.toString();
  }
}
