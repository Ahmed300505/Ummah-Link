import 'package:flutter/material.dart';

class PersonMessageScreen extends StatelessWidget {
  const PersonMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = const Color(0xFFFEFDEB);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final profileRadius = screenWidth * 0.14;

          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                child: Column(
                  children: [
                    const SizedBox(height: 50),

                    // Top Row (Back, Name, Info)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.arrow_back, size: 26, color: Colors.black),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 14,
                              backgroundImage: AssetImage('assets/images/launchingicon.png'),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              "Grounded Twin Cities",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.info_outline, size: 22, color: Colors.black),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Main Large Logo
                    CircleAvatar(
                      radius: profileRadius,
                      backgroundColor: backgroundColor,
                      backgroundImage: const AssetImage('assets/images/launchingicon.png'),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "Grounded Twin Cities",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "@groundedtwincities",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("46 Communities", style: TextStyle(fontSize: 12, color: Colors.black87)),
                        SizedBox(width: 24),
                        Text("2,390 Members", style: TextStyle(fontSize: 12, color: Colors.black87)),
                      ],
                    ),

                    const Spacer(),

                    // Message Input
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: TextField(
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "Message...",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFE6E1CB),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.send, size: 20, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
