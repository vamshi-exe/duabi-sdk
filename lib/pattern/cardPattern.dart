class CardPattern {
  static const visa = r"^4[0-9]{2,12}(?:[0-9]{3})?$";
  static const master = r"^(5[1-5][0-9]{14}|2(22[1-9][0-9]{12}|2[3-9][0-9]{13}|[3-6][0-9]{14}|7[0-1][0-9]{13}|720[0-9]{12}))$";
  static const amex = r"^3[47][0-9]{1,13}$";
  static const discover = r"^6(?:011|5[0-9]{2})[0-9]{1,12}$";
  static const dinersclub = r"^3(?:0[0-5]|[68][0-9])[0-9]{1,11}$";
  static const jcb = r"^35[0-9]{1,14}$";
}
