import 'package:flutter/material.dart';
import 'package:islamicinstapp/screens/EventInterestFormScreen.dart';
import 'package:islamicinstapp/screens/linkregisteration.dart';
import 'package:provider/provider.dart';
import 'package:islamicinstapp/Styles/text_styles.dart';
import 'package:islamicinstapp/Provider/event_detail_provider.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

class EventDetailScreen extends StatelessWidget {
  final DateTime selectedDate;

  const EventDetailScreen({Key? key, required this.selectedDate}) : super(key: key);
  static const backgroundColor = Color(0xFFFCF5DB);
  static const primaryColor = Color(0xFF063A39);
  static const textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventDetailProvider(selectedDate: selectedDate),
      child: _EventDetailContent(selectedDate: selectedDate),
    );
  }
}

class _EventDetailContent extends StatelessWidget {
  final DateTime selectedDate;

  const _EventDetailContent({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventDetailProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 375;

    return Scaffold(
      backgroundColor: EventDetailScreen.backgroundColor,
      bottomNavigationBar: const CustomBottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with connected banner
              Stack(
                children: [
                  // Banner image extended to header
                  Container(
                    height: isSmallScreen ? 200 : 240,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/islamicevent.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Back button and title with semi-transparent background
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, isSmallScreen ? 8 : 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          EventDetailScreen.primaryColor.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white, size: isSmallScreen ? 24 : 28),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              ),

              // Info Row (Location | Date | Register)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Location Section
                    Expanded(
                      child: Column(
                        children: [
                          Icon(Icons.location_on, color: EventDetailScreen.primaryColor, size: 28),
                          const SizedBox(height: 4),
                          Text(
                            'Masjid Al-Haram',
                            style: TextStyles.eventDetailInfoText(context),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // Vertical dotted divider
                    Container(
                      height: 60,
                      width: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: EventDetailScreen.primaryColor,
                            width: 3,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),

                    // Date Section
                    SizedBox(
                      width: 70,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            // Header (Month)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              decoration: const BoxDecoration(
                                color: Color(0xFF094B4A),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'MAR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // Body (Day)
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF094B4A).withOpacity(0.8),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    selectedDate.day.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 30),

                    // Vertical dotted divider
                    Container(
                      height: 60,
                      width: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: EventDetailScreen.primaryColor,
                            width: 3,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),

                    // Register Section
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EventInterestFormScreen(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              provider.isRegistered ? Icons.event_available : Icons.event_note,
                              color: EventDetailScreen.primaryColor,
                              size: 28,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              provider.isRegistered ? 'Registered' : 'Register',
                              style: TextStyles.eventDetailInfoText(context),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Time section
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Container(
                  width: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    '6:00 - 8:00 PM',
                    style: TextStyles.eventDetailTimeText(context),
                  ),
                ),
              ),

              // About section
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Container(
                  width: 599,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: TextStyles.eventDetailSectionTitleText(context),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Join us for a powerful evening exploring the profound and '
                            'timeless legacy of the Prophet. This event will provide '
                            'an opportunity to reflect on the life, teachings, and '
                            'enduring impact of the Prophet Muhammad through a '
                            'grounded and meaningful lens.',
                        style: TextStyles.eventDetailDescriptionText(context),
                      ),
                    ],
                  ),
                ),
              ),

              // People attending section
              Padding(
                padding: EdgeInsets.fromLTRB(isSmallScreen ? 12 : 24, 16, isSmallScreen ? 12 : 24, 16),
                child: Container(
                  padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'People Attending',
                        style: TextStyles.eventDetailAttendeesText(context),
                      ),
                      SizedBox(height: isSmallScreen ? 10 : 12),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(6, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: CircleAvatar(
                                      radius: isSmallScreen ? 16 : 20,
                                      backgroundImage: AssetImage('assets/images/profile_${index + 1}.jpg'),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Flexible(
                            flex: 1,
                            child: Text(
                              '${provider.attendeesCount}+',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: isSmallScreen ? 13 : 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const Spacer(),

                          Flexible(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {
                                provider.connectWithAttendees();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Connecting with attendees...')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 10 : 12,
                                  vertical: isSmallScreen ? 6 : 8,
                                ),
                                backgroundColor: EventDetailScreen.primaryColor,
                                minimumSize: Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'Connect',
                                style: TextStyles.eventDetailConnectButtonText(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}