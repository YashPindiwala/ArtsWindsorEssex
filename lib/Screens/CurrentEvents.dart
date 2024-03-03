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
        const SizedBox(
            height:
                12), // Space between the top of the white container and the first card
        _buildEventCard(
          title: 'St. Clair College Art Exhibition',
          image: 'assets/awe_logo.png',
          description:
              'Join us at St. Clair College South Campus as we showcase our latest artworks.',
          date: 'July 21st from 2 PM - 5 PM',
          admissionFee: '\$10',
        ),
        _buildEventCard(
          title: 'Art Windsor-Essex Color Exhibition',
          image: 'assets/awe_logo.png',
          description:
              'Join us at the Art Windsor-Essex building for our colorful displays. All the current artwork in the show was produced by local artists.',
          date: 'July 21st from 2 PM to 5 PM',
          admissionFee: '\$5',
        ),
        _buildEventCard(
          title: 'St. Clair College Art Exhibition',
          image: 'assets/awe_logo.png',
          description:
              'Join us at St. Clair College South Campus as we showcase our latest artworks.',
          date: 'July 21st from 2 PM - 5 PM',
          admissionFee: '\$10',
        ),
        _buildEventCard(
          title: 'Art Windsor-Essex Color Exhibition',
          image: 'assets/awe_logo.png',
          description:
              'Join us at the Art Windsor-Essex building for our colorful displays. All the current artwork in the show was produced by local artists.',
          date: 'July 21st from 2 PM to 5 PM',
          admissionFee: '\$5',
        ),
      ],
    );
  }

  Widget _buildPastEventsContent() {
    return ListView(
      children: [
        _buildEventCard(
          title: 'St. Clair College Art Exhibition',
          image: 'assets/awe_logo.png',
          description:
              'Join us at St. Clair College South Campus as we showcase our latest artworks.',
          date: 'July 21st from 2 PM - 5 PM',
          admissionFee: '\$10',
        ),
        _buildEventCard(
          title: 'Art Windsor-Essex Color Exhibition',
          image: 'assets/awe_logo.png',
          description:
              'Join us at the Art Windsor-Essex building for our colorful displays. All the current artwork in the show was produced by local artists.',
          date: 'July 21st from 2 PM to 5 PM',
          admissionFee: '\$5',
        ),
      ],
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
      color: mintColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: size18,
                  fontWeight: FontWeight.bold,
                  color: purpleColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: size13, color: textColor),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontSize: size12,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                    Text(
                      'Admission: $admissionFee',
                      style: const TextStyle(
                        fontSize: size12,
                        fontWeight: FontWeight.bold,
                        color: textColor,
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
