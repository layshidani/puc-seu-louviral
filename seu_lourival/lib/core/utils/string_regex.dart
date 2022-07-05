extension StringRegex on String {
  bool isValidName() {
    return RegExp(
            r'^[A-ZÀ-ŸA-zÀ-ÿ][A-ZÀ-ŸA-zÀ-ÿ]+\s([A-ZÀ-ŸA-zÀ-ÿ]\s?)*[A-ZÀ-ŸA-zÀ-ÿ][A-ZÀ-ŸA-zÀ-ÿ]+$')
        .hasMatch(this);
  }
}
