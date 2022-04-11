import 'package:flutter/widgets.dart';

extension HeightFromContext on BuildContext {
  double getHeight() {
    return MediaQuery.of(this).size.height;
  }
}

extension WidthFromContext on BuildContext {
  double getWidth() {
    return MediaQuery.of(this).size.width;
  }
}
