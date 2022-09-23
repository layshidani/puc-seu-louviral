import 'package:dio/dio.dart';

class EmailServiceModel {
  final String name;
  final String email;
  final String phone;

  EmailServiceModel({
    required this.name,
    required this.email,
    required this.phone,
  });
}

class EmailService {
  final url = "https://api.emailjs.com/api/v1.0/email/send";
  Future<void> sendEmail({required EmailServiceModel model}) async {
    try {
      final response = await Dio().post(url, data: {
        "service_id": "service_embw1ig",
        "template_id": "template_ghamq7f",
        "user_id": "user_AxchveUftEkkCKXgyBwA6",
        "template_params": {
          "receiver_name": model.name,
          "phone_number": model.phone,
          "receiver_email": model.email,
        },
      });
      print(response);
    } catch (e) {
      print("--> erro ao enviar email: ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
