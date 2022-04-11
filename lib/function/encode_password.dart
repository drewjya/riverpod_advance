import 'dart:convert';

extension Encryption on String {
  String encode() {
    return base64.encode(utf8.encode(this));
  }
}
