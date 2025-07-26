import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:islamicinstapp/Provider/add_post_provider.dart';
import 'package:islamicinstapp/Provider/auth_selection_provider.dart';
import 'package:islamicinstapp/Provider/calendar_provider.dart';
import 'package:islamicinstapp/Provider/edit_profile_provider.dart';
import 'package:islamicinstapp/Provider/forum_provider.dart';
import 'package:islamicinstapp/Provider/messaging_provider.dart';
import 'package:islamicinstapp/Provider/new_chat_provider.dart';
import 'package:islamicinstapp/Provider/notification_provider.dart';
import 'package:islamicinstapp/Provider/profile_provider.dart';
import 'package:islamicinstapp/Provider/register_provider.dart';
import 'package:islamicinstapp/Provider/splash_provider.dart';
import 'package:islamicinstapp/Service/AuthService.dart';
import 'package:islamicinstapp/screens/AuthSelectionScreen.dart';
import 'package:islamicinstapp/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/SplashScreens/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()), // ✅ ADD THIS LINE
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => AuthSelectionProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => NewChatProvider()),
        ChangeNotifierProvider(create: (_) => MessagingProvider()),
        ChangeNotifierProvider(create: (_) => ForumProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileProvider()),
        ChangeNotifierProvider(create: (_) => AddPostProvider()),
        ChangeNotifierProvider(create: (_) => CalendarProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _showSplash = true;
  bool _isFirstTime = true;
  Widget _initialRoute = SplashScreen();

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
    _checkAuthState();
  }

  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    _isFirstTime = prefs.getBool('first_time') ?? true;
    if (_isFirstTime) {
      await prefs.setBool('first_time', false);
    }
  }

  Future<void> _checkAuthState() async {
    // Add slight delay to allow splash screen to be visible
    await Future.delayed(Duration(milliseconds: 1500));

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && user.emailVerified) {
        // User is logged in and email is verified
        setState(() {
          _initialRoute = HomePage(); // Your main app screen
          _showSplash = _isFirstTime;
        });
      } else {
        // User is not logged in or email not verified
        setState(() {
          _initialRoute = AuthSelectionScreen(); // Your auth selection screen
          _showSplash = _isFirstTime;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSplash ? SplashScreen() : _initialRoute;
  }
}
