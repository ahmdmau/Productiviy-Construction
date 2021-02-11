import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_contruction/models/models.dart';
import 'package:productivity_contruction/services/services.dart';

part 'firebase_user_extension.dart';
part 'context_extensions.dart';

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay add({int hour = 0, int minute = 0}) {
    return this.replacing(hour: this.hour + hour, minute: this.minute + minute);
  }
}

extension ContextExtensions on BuildContext {
  Size size() => MediaQuery.of(this).size;

  double width() => MediaQuery.of(this).size.width;

  double height() => MediaQuery.of(this).size.height;

  double pixelRatio() => MediaQuery.of(this).devicePixelRatio;
}

extension IntExtensions on int {
  /// Validate given int is not null and returns given value if null.
  int validate({int value = 0}) => this ?? value;

  /// Leaves given height of space
  Widget get height => SizedBox(height: this.toDouble());

  /// Leaves given width of space
  Widget get width => SizedBox(width: this.toDouble());

  /// HTTP status code
  bool isSuccessful() {
    return this >= 200 && this <= 206;
  }
}

extension DoubleExtensions on double {
  /// Validate given double is not null and returns given value if null.
  double validate({double value = 0.0}) => this ?? value;
}
