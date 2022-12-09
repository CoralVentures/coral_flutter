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
    required this.userStoryId,
    required this.description,
  });

  final String userStoryId;
  final String description;

  @override
  String toString() {
    return '''
====================
$userStoryId: $description
====================
''';
  }

  @override
  String toMarkdown() {
    return '# $userStoryId: $description\n';
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

class CoralTesterAction {
  CoralTesterAction({
    required this.description,
  });

  final String description;

  @override
  String toString() {
    return description;
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
    this.description,
    required this.testerTotalTripCount,
  });

  final String screenshotPath;
  final List<String> expectationReasons;
  final List<CoralTesterAction> actions;
  final List<Type> events;
  final List<String> analytics;
  final String? description;
  final int testerTotalTripCount;

  @override
  String toString() {
    final buffer = StringBuffer();

    if (description != null) {
      buffer
        ..writeln(description)
        ..writeln();
    }

    if (actions.isNotEmpty) {
      buffer.writeln('User Actions:');

      for (final element in actions) {
        buffer.writeln('  $element');
      }

      buffer.writeln();
    }

    if (expectationReasons.isNotEmpty) {
      buffer.writeln('Expect:');

      for (final element in expectationReasons) {
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

    if (description != null) {
      buffer.write('\n## $description\n');
    }

    buffer.write(
      '''
<table>
  <tbody>
   <tr>
      <td width="300" style="vertical-align:top">
''',
    );

    if (actions.isNotEmpty) {
      buffer
        ..writeln('<b>User Actions:</b>')
        ..writeln('<ul>');
      for (final element in actions) {
        buffer.writeln('  <li>$element</li>');
      }
      buffer.writeln('</ul>');
    }

    if (expectationReasons.isNotEmpty) {
      buffer
        ..writeln('<b>Expect:</b>')
        ..writeln('<ul>');
      for (final element in expectationReasons) {
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

      final screenshotPathListSansUserStoryId = screenshotPath.split('/')
        ..removeAt(0);

      // only show graphviz image if more than one event
      if (events.length > 1) {
        buffer
          ..writeln('</ul>')
          ..writeln('<br>')
          ..writeln(
            '<img width="300" src="./${screenshotPathListSansUserStoryId.join('/')}.png">',
          )
          ..writeln('<br>');
      }
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

    // We are only going to run `toMarkdown` on the first trip, but we want to
    // see all the images from each trip.
    final _trips = List<int>.generate(testerTotalTripCount, (i) => i);
    for (final _trip in _trips) {
      buffer.write('''
      </td>
      <td>
      <img width="300" src="../../user_stories/goldens/$screenshotPath.$_trip.iphone11.png">
      </td>''');
    }

    buffer.write(
      '''
   </tr>
  </tbody>
</table>
''',
    );
    return buffer.toString();
  }

  String? toGraphviz() {
    // only return if more than one event
    if (events.length > 1) {
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
    return null;
  }
}
