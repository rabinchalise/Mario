import 'package:flutter/material.dart';

extension SizedBoxExtension on double {
  SizedBox get verticalSpacer {
    return SizedBox(height: this);
  }

  SizedBox get horizontalSpacer {
    return SizedBox(height: this);
  }
}
