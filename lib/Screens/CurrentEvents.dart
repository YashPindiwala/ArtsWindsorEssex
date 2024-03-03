import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';

import 'AboutApp.dart';

class CurrentEvents extends StatefulWidget {
  static const id = "CurrentEvents";

  const CurrentEvents({Key? key}) : super(key: key);

  @override
  State<CurrentEvents> createState() => _CurrentEventsState();
}

class _CurrentEventsState extends State<CurrentEvents>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AboutApp()),
              );
            },
            icon: const Icon(Icons.info_outline_rounded),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: Center(
                    child: Text(
                      "Art Windsor-Essex Events",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.transparent, // Make the indicator transparent
              ),
              labelColor: orangeColor, // Set the selected tab color
              labelPadding: EdgeInsets.zero, // Remove label padding
              tabs: const [
                Tab(text: 'Current Events'),
                Tab(text: 'Past Events'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              color: Colors.white,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCurrentEventsContent(),
                  _buildPastEventsContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentEventsContent() {
    return ListView(
      children: [
        _buildEventCard(
          title: 'Event Title 1',
          image: 'assets/awe_logo.png',
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          date: 'Date 1',
          admissionFee: '\$10',
        ),
        _buildEventCard(
          title: 'Event Title 2',
          image: 'assets/awe_logo.png',
          description:
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          date: 'Date 2',
          admissionFee: '\$15',
        ),
      ],
    );
  }

  Widget _buildPastEventsContent() {
    return const Center(
      child: Text(
        'Past Events Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget _buildEventCard({
    required String title,
    required String image,
    required String description,
    required String date,
    required String admissionFee,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        date,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Text(
                      'Admission: $admissionFee',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: CurrentEvents(),
  ));
}
