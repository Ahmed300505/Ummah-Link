import 'package:flutter/material.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

class UserHomePageScreen extends StatefulWidget {
  const UserHomePageScreen({super.key});

  @override
  State<UserHomePageScreen> createState() => _UserHomePageScreenState();
}

class _UserHomePageScreenState extends State<UserHomePageScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmall = width < 400;
    final padding = isSmall ? 16.0 : 20.0;
    final avatarSize = isSmall ? 40.0 : 48.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFEFDEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEFDEB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "User",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF03B9C2),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(child: Column(children: [Text("36"), Text("Communities")])),
            Tab(child: Column(children: [Text("5"), Text("Awliya")])),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildSearchField(),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCommunityList(avatarSize),
                  _buildAwliyaList(avatarSize),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar:CustomBottomNavBar()
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          icon: Icon(Icons.search),
          hintText: "SEARCH",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCommunityList(double avatarSize) {
    final communities = [
      {"name": "Grounded Twin Cities ", "image": "image1.png"},
      {"name": "SMIC Masjid", "image": "image2.png"},
      {"name": "Dar Al - Farooq", "image": "image3.png"},
      {"name": "Masjid Tawfiq", "image": "image4.png"},
      {"name": "Masjid As-Sunnah", "image": "image5.png"},
      {"name": "Al Amaan Center", "image": "image6.png"},
      {"name": "ETCIC ", "image": "image7.png"},
    ];

    return ListView.builder(
      itemCount: communities.length,
      itemBuilder: (context, index) {
        final community = communities[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // 👈 spacing between items
          child: ListTile(
            leading: CircleAvatar(
              radius: avatarSize / 2,
              backgroundImage: AssetImage("assets/images/${community['image']}"),
            ),
            title: Text(community['name']!),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFE6E6E6),
              ),
              child: const Text(
                "Member",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAwliyaList(double avatarSize) {
    final awliya = [
      {"name": "Fatima Ahmed", "image": "image1.png"},
      {"name": "Salmaxx", "image": "image2.png"},
      {"name": "Aishaali", "image": "image3.png"},
      {"name": "Samira_m", "image": "image4.png"},
    ];

    return ListView.builder(
      itemCount: awliya.length,
      itemBuilder: (context, index) {
        final user = awliya[index];
        return ListTile(
          leading: CircleAvatar(
            radius: avatarSize / 2,
            backgroundImage: AssetImage("assets/images/${user['image']}"),
          ),
          title: Text(user['name']!),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF033941),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text("Awliya", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
