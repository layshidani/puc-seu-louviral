import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/loading/24209-house-ou-apartment.json',
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Carregando',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
