import 'package:flutter/material.dart';
import 'package:islamicinstapp/Provider/calendar_provider.dart';
import 'package:islamicinstapp/Styles/calendar_styles.dart';
import 'package:islamicinstapp/screens/calenderDetailScreen.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:islamicinstapp/widgets/bottom_nav_bar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CalendarStyles.backgroundColor,
      bottomNavigationBar: const CustomBottomNavBar(),
      body: SafeArea(
        child: Consumer<CalendarProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(context),
                _buildCalendarSection(context, provider),
                _buildEventsSection(context, provider),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Local Events',
            style: CalendarStyles.sectionTitleTextStyle(context),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: CalendarStyles.searchInputDecoration(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection(BuildContext context, CalendarProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TableCalendar(
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: provider.focusedDay,
        selectedDayPredicate: (day) => isSameDay(provider.selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          provider.setSelectedDay(selectedDay, focusedDay);
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: CalendarStyles.primaryColor.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: CalendarStyles.primaryColor,
            shape: BoxShape.circle,
          ),
          defaultTextStyle: TextStyle(color: CalendarStyles.primaryColor),
          weekendTextStyle: TextStyle(
              color: CalendarStyles.primaryColor.withOpacity(0.8)),
          outsideTextStyle: TextStyle(
              color: CalendarStyles.primaryColor.withOpacity(0.4)),
        ),
        headerStyle: HeaderStyle(
          titleTextStyle: TextStyle(
            color: CalendarStyles.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          formatButtonVisible: false,
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: CalendarStyles.primaryColor,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: CalendarStyles.primaryColor,
          ),
          titleCentered: true,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: CalendarStyles.primaryColor),
          weekendStyle: TextStyle(color: CalendarStyles.primaryColor),
        ),
      ),
    );
  }

  Widget _buildEventsSection(BuildContext context, CalendarProvider provider) {
    return Expanded(
      child: Container(
        decoration: CalendarStyles.eventsContainerDecoration(context),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upcoming Events',
                  style: CalendarStyles.eventsHeaderTextStyle(context),
                ),
                TextButton(
                  onPressed: () => _navigateToAllEvents(context),
                  child: Text(
                    'View More',
                    style: CalendarStyles.viewMoreTextStyle(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: provider.getUpcomingEvents().map((event) {
                  return _buildEventCard(
                    context: context,
                    date: event['date']!,
                    time: event['time']!,
                    title: event['title']!,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard({
    required BuildContext context,
    required String date,
    required String time,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: CalendarStyles.eventCardDecoration(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Date Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: CalendarStyles.dateBoxDecoration(context),
            child: Text(
              date,
              style: CalendarStyles.dateTextStyle(context),
            ),
          ),
          const SizedBox(width: 12),
          // Vertical Divider
          Container(
            width: 1.5,
            height: 50,
            color: Colors.white.withOpacity(0.4),
          ),
          const SizedBox(width: 12),
          // Event Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => _navigateToEventDetail(context),
                  child: Text(
                    title,
                    style: CalendarStyles.eventTitleTextStyle(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: CalendarStyles.eventTimeTextStyle(context),
                ),
              ],
            ),
          ),
          const Icon(Icons.bookmark_border, color: Colors.white),
        ],
      ),
    );
  }

  void _navigateToAllEvents(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AllEventsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  void _navigateToEventDetail(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            EventDetailScreen(selectedDate: DateTime.now()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}

class AllEventsScreen extends StatelessWidget {
  const AllEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CalendarStyles.primaryColor,
      appBar: AppBar(
        backgroundColor: CalendarStyles.primaryColor,
        elevation: 0,
        title: const Text(
          'All Upcoming Events',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<CalendarProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.getAllEvents().length,
            itemBuilder: (context, index) {
              final event = provider.getAllEvents()[index];
              return _buildEventCard(
                context: context,
                date: event['date']!,
                time: event['time']!,
                title: event['title']!,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEventCard({
    required BuildContext context,
    required String date,
    required String time,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: CalendarStyles.eventCardDecoration(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: CalendarStyles.dateBoxDecoration(context),
            child: Text(
              date,
              style: CalendarStyles.dateTextStyle(context),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 1.5,
            height: 50,
            color: Colors.white.withOpacity(0.4),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CalendarStyles.eventTitleTextStyle(context),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: CalendarStyles.eventTimeTextStyle(context),
                ),
              ],
            ),
          ),
          const Icon(Icons.bookmark_border, color: Colors.white),
        ],
      ),
    );
  }
}