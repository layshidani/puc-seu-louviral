extension DSStringExtensions on String {
  String toCapitalize() {
    if (this == null || this.length < 1) {
      return '';
    }
    return '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}

extension DSStringRegex on String {
  bool isValidName() {
    return RegExp(
            r'^[A-ZÀ-ŸA-zÀ-ÿ][A-ZÀ-ŸA-zÀ-ÿ]+\s([A-ZÀ-ŸA-zÀ-ÿ]\s?)*[A-ZÀ-ŸA-zÀ-ÿ][A-ZÀ-ŸA-zÀ-ÿ]+$')
        .hasMatch(this);
  }
}
