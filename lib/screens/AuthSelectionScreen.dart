// auth_selection_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:islamicinstapp/Service/AuthService.dart';
import 'package:islamicinstapp/SplashScreens/splashscreen.dart';
import 'package:islamicinstapp/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/Provider/auth_selection_provider.dart';

class AuthSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: authService.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;

            if (user != null) {
              // Check email verification
              return FutureBuilder<bool>(
                future: authService.isEmailVerified(),
                builder: (context, emailVerifiedSnapshot) {
                  if (emailVerifiedSnapshot.connectionState == ConnectionState.done) {
                    if (emailVerifiedSnapshot.data == true) {
                      return HomePage(); // User is logged in and verified
                    } else {
                    }
                  }
                  return SplashScreen(); // Show splash while checking
                },
              );
            }
          }
          return SplashScreen(); // Show splash while checking auth state
        },
      ),
    );
  }
}