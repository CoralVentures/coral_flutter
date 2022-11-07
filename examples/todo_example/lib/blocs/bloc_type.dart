import 'package:flutter/foundation.dart';

extension BlocTypeEx on String {
  BlocType toBlocTypeEnum() => BlocType.values
      .firstWhere((bt) => describeEnum(bt).toLowerCase() == toLowerCase());
}

enum BlocType {
  todos,
  // CORAL_CLI_BLOC_TYPE
}
