import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';

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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
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
            margin: EdgeInsets.symmetric(horizontal: 25),
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white,
              ),
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
    return SingleChildScrollView(
      child: Center(
        child: Text(
          'Current Events Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildPastEventsContent() {
    return SingleChildScrollView(
      child: Center(
        child: Text(
          'Past Events Content',
          style: TextStyle(fontSize: 24),
        ),
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
