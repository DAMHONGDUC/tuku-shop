import 'package:tuku_shop/src/features/home/presentation/config/home_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginOTPScreen extends StatelessWidget {
  const LoginOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter OTP'),
            ElevatedButton(
              onPressed: () {
                context.go(HomeRoutes.home.fullPath);
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
