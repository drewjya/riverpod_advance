class Validator {
  int? minLenth;
  Validator({this.minLenth});
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "This field cannot be empty";
    } else if (password.length < (minLenth ?? 8)) {
      return "Password minimum length is ${minLenth ?? 8}";
    }

    return null;
  }

  String? checkEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "This field cannot be empty";
    }
    if (minLenth != null && value.length < minLenth!) {
      return "Password minimum length is $minLenth";
    }
    return null;
  }

  String? checkNumberPhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Minimum Length is 10";
    } else if (value.contains(RegExp(r'[!@#$%^&*()?><}{:/"|=~,./+-]|[A-z]'))) {
      return "This field only receive number";
    } else if ((value.length < 10)) {
      return "Minimum Length is 10";
    } else if ((value.length > 13)) {
      return "Maximum Length is 13";
    }

    return null;
  }
}
