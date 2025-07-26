import 'package:flutter/material.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmall = width < 400;
    final gridItemSize = isSmall ? width * 0.38 : width * 0.42;
    final padding = isSmall ? 16.0 : 20.0;

    // Separate images for "All" and "Events"
    final allImages = [
      'assets/images/homepagepost1.png',
      'assets/images/homepagepost2.png',
      'assets/images/homepagepost3.png',
      'assets/images/homepagepost1.png',
    ];

    final eventImages = [
      'assets/images/postimage2.jpg',
      'assets/images/event2.jpg',
      'assets/images/event3.jpg',
      'assets/images/event4.jpg',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFEFDEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEFDEB),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Saved",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Rows
            Row(
              children: [
                _imageGroup("All", gridItemSize, allImages),
                const SizedBox(width: 12),
                _imageGroup("Events", gridItemSize, eventImages),
              ],
            ),
            const SizedBox(height: 24),

            // Create Collection Section
              Column(
                children: [
                  Container(
                    width: gridItemSize,
                    height: gridItemSize,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6E6E6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add, size: 40, color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Create collection",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
          ],
        ),
      ),

      // Bottom NavBar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF033941),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }

  Widget _imageGroup(String label, double size, List<String> images) {
    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: GridView.count(
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            children: images.map((imagePath) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        ),
      ],
    );
  }
}
