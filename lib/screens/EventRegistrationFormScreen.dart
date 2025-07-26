import 'package:flutter/material.dart';
import 'package:islamicinstapp/screens/linkregisteration.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

class EventRegistrationFormScreen extends StatefulWidget {
  const EventRegistrationFormScreen({super.key});

  @override
  State<EventRegistrationFormScreen> createState() => _EventRegistrationFormScreenState();
}

class _EventRegistrationFormScreenState extends State<EventRegistrationFormScreen> {
  bool hidePublicRegistration = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isSmall = screenWidth < 400;
        final padding = isSmall ? 16.0 : 24.0;
        final fieldHeight = isSmall ? 45.0 : 52.0;
        final fontSize = isSmall ? 14.0 : 16.0;

        return Scaffold(
          backgroundColor: const Color(0xFFFEFDEB),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Grounded: In the Prophetic Legacy',
                          style: TextStyle(
                            fontSize: fontSize + 2,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Name Fields
                  _buildInputField('Name', fontSize, fieldHeight),
                  const SizedBox(height: 14),
                  _buildInputField('Last Name', fontSize, fieldHeight),
                  const SizedBox(height: 14),

                  _buildInputField('Email', fontSize, fieldHeight),
                  const SizedBox(height: 14),

                  _buildInputField('Number', fontSize, fieldHeight),

                  const SizedBox(height: 12),

                  // Switch
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Don't Show Public Registration",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: fontSize - 1,
                        ),
                      ),
                      Switch(
                        activeColor: const Color(0xFF033941),
                        value: hidePublicRegistration,
                        onChanged: (val) => setState(() {
                          hidePublicRegistration = val;
                        }),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF033941),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (_) => const ConfirmationScreen()),
                      );
                      },
                      child: const Text('Register', style: TextStyle(color:Colors.white,fontSize: 16)),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Bottom Navigation Bar
          bottomNavigationBar: CustomBottomNavBar(),
        );
      },
    );
  }

  Widget _buildInputField(String hint, double fontSize, double height) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFE5),
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(fontSize: fontSize, color: Colors.black54),
        ),
      ),
    );
  }
}
