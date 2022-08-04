class StringFormater {
  static String getOnlyNumbers(String str) {
    return str.replaceAll(RegExp('[^0-9]'), '');
  }
}
