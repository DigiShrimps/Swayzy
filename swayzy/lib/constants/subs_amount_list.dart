import 'dart:collection';

import '../screens/creation/creation.dart';

class SubsAmount{
  static const List<String> subsAmount = <String>[
    "<100",
    "100+",
    "500+",
    "1000+",
    "10000+",
    "50000+",
    "100000+",
    "500000+",
    "1000000+",
  ];
  static final List<DropdownEntry> subsEntries = UnmodifiableListView<DropdownEntry>(
    subsAmount.map<DropdownEntry>(
      (String title) => DropdownEntry(value: title, label: title),
    ),
  );

  static String dropdownSubsValue = subsAmount.first;
}
