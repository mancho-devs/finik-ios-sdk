import 'package:finik_sdk/finik_sdk.dart';

TextScenario? parseTextScenario(String? value) {
  if (value == null) {
    return TextScenario.payment;
  }
  return TextScenario.values.firstWhere((e) {
    return e.name == value;
  }, orElse: () => throw ArgumentError('Invalid TextScenario value: $value'));
}
