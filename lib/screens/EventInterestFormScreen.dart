import 'package:flutter/material.dart';
import 'package:islamicinstapp/screens/EventRegistrationFormScreen.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

class EventInterestFormScreen extends StatefulWidget {
  const EventInterestFormScreen({super.key});

  @override
  State<EventInterestFormScreen> createState() => _EventInterestFormScreenState();
}

class _EventInterestFormScreenState extends State<EventInterestFormScreen> {
  int ticketCount = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final isSmall = screenWidth < 400;
      final padding = isSmall ? 16.0 : 24.0;
      final imageHeight = isSmall ? 200.0 : 260.0;
      final fontSize = isSmall ? 16.0 : 18.0;

      return Scaffold(
        backgroundColor: const Color(0xFFFEFDEB),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Image with back button
              Stack(
                children: [
                  Container(
                    height: imageHeight,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/homepagepost1.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 8,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Text(
                  'Grounded: In the Prophetic Legacy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize + 2,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Ticket box
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFEFE5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16), // 🔺 Increased vertical padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Grounded: Prophetic Legacy',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, size: 20, color: Colors.black87),
                                onPressed: () {
                                  if (ticketCount > 1) {
                                    setState(() => ticketCount--);
                                  }
                                },
                              ),
                              const SizedBox(width: 8),
                              Text('$ticketCount', style: TextStyle(fontSize: fontSize)),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(Icons.add, size: 20, color: Colors.black87),
                                onPressed: () => setState(() => ticketCount++),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 1.5,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF033941),
                              width: 1.2,
                              style: BorderStyle.solid, // No native dotted support, using workaround
                            ),
                          ),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                (constraints.maxWidth / 6).floor(),
                                    (index) => const SizedBox(
                                  width: 3,
                                  height: 1,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(color: Color(0xFF033941)),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 12),

                      // 🔹 "Free" label
                      const Text(
                        'Free',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 32),

                    ],
                  ),
                ),
              ),
              const Spacer(),

              // Continue Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding, vertical: 16),
                child: SizedBox(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const EventRegistrationFormScreen()),
                      );
                    },         child: const Text('Continue', style: TextStyle(color:Colors.white,fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bottom Navbar
        bottomNavigationBar: CustomBottomNavBar()
      );
    });
  }
}

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CircleBtn({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFE6E6E6),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18),
        onPressed: onPressed,
      ),
    );
  }
}
