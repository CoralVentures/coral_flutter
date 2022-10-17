import 'package:flutter/foundation.dart';

extension BlocTypeEx on String {
  BlocType toEnum() =>
      BlocType.values.firstWhere((bt) => describeEnum(bt) == toLowerCase());
}

enum BlocType {
  greetings,
  // CORAL_CLI_BLOC_TYPE
}
