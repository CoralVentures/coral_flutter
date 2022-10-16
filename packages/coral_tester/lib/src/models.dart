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
    return '\n### $screenName page\n';
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
      buffer.write('\n## $comment\n');
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
      final screenshotPathParts = screenshotPath.split('/');

      buffer
        ..writeln('</ul>')
        ..writeln('<br>')
        ..writeln(
          '<img src="./${screenshotPathParts.first}/${screenshotPathParts.last}.png", width=400>',
        )
        ..writeln('<br>');
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
      <img src="../user_stories/goldens/$screenshotPath.iphone11.png">
      </td>
   </tr>
  </tbody>
</table>
''',
    );
    return buffer.toString();
  }

  String toGraphviz() {
    final buffer = StringBuffer()..writeln('digraph {');

    final subgraphs = <String, List<String>>{};

    final graphvizEvents = [
      'Event_Start',
      ...events.map((e) => e.toString()),
      'Event_End',
    ];

    for (var i = 0; i < graphvizEvents.length; i++) {
      final eventParts = graphvizEvents[i].split('_');

      final eventBlocName = eventParts.first.replaceAll('Event', '');
      final eventName = eventParts.last;

      subgraphs[eventBlocName] = (subgraphs[eventBlocName] ?? [])
        ..add('$i [label="$eventName";];');

      if (i + 1 < graphvizEvents.length) {
        buffer.writeln('  $i -> ${i + 1};');
      }
    }

    var subgraphCounter = 0;
    subgraphs.forEach((blocName, eventNames) {
      buffer
        ..writeln('  subgraph cluster_$subgraphCounter {')
        ..writeln('    label="$blocName";');

      for (final eventName in eventNames) {
        buffer.writeln('    $eventName');
      }

      buffer.writeln('  }');

      subgraphCounter++;
    });

    buffer.writeln('}');

    return buffer.toString();
  }
}
