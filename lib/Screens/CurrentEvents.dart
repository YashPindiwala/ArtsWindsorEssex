import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import '../Utils/EventCard.dart';
import '../Utils/ExpandedCardModal.dart';
import 'AboutApp.dart';
import 'Models/EventModel.dart';
import 'package:artswindsoressex/Utils/CardLoadingShimmer.dart';

class CurrentEvents extends StatefulWidget {
  static const id = "CurrentEvents";

  const CurrentEvents({super.key});

  @override
  State<CurrentEvents> createState() => _CurrentEventsState();
}

class _CurrentEventsState extends State<CurrentEvents>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _showModal = false;
  late EventDetails _selectedEvent;

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
      body: Stack(
        children: [
          Column(
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
                    color: Colors.transparent,
                  ),
                  labelColor: orangeColor,
                  labelPadding: EdgeInsets.zero,
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
                      CardLoadingShimmer(),
                      // _buildCurrentEventsContent(),
                      _buildPastEventsContent(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_showModal)
            GestureDetector(
              onTap: () {
                setState(() {
                  _showModal = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          if (_showModal)
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(20),
                  child: ExpandedCardModal(selectedEvent: _selectedEvent),
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
        const SizedBox(height: 12),
        _buildEventCards(currentEvents),
      ],
    );
  }

  Widget _buildPastEventsContent() {
    return ListView(
      children: [
        _buildEventCards(pastEvents),
      ],
    );
  }

  Widget _buildEventCards(List<EventDetails> events) {
    return Column(
      children: events.map((event) {
        return EventCard(
          eventDetails: event,
          onPressed: () {
            setState(() {
              _selectedEvent = event;
              _showModal = true;
            });
          },
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
