class SmsAuthenticationService {
  String phone = '';
  String id = '';
  String token = '';

  String getUnmaskedPhone() {
    return phone
        .replaceAll(" ", "")
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("-", "")
        .replaceAll("+", "");
  }
}
