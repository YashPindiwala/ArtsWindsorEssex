import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import '../API/Endpoints.dart';
import '../Utils/EventCard.dart';
import 'AboutApp.dart';
import 'package:artswindsoressex/Utils/CardLoadingShimmer.dart';
import 'package:artswindsoressex/Screens/Models/EventModel.dart';
import 'package:artswindsoressex/API/EventRequest.dart';

class CurrentEvents extends StatefulWidget {
  static const id = "CurrentEvents";

  const CurrentEvents({super.key});

  @override
  State<CurrentEvents> createState() => _CurrentEventsState();
}

class _CurrentEventsState extends State<CurrentEvents>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late Future _currentEvents, _pastEvents;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchCurrentEvents();
    _fetchPastEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AboutApp.id);
                          },
                          icon: const Icon(Icons.info_outline_rounded),
                        )
                      ],
                    ),
                    Text(
                      "Art Windsor-Essex Events",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge
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
                  enableFeedback: false,
                  padding: EdgeInsets.symmetric(horizontal: 25),
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
                      FutureBuilder(
                        future: _currentEvents,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CardLoadingShimmer(); // Show loading indicator while waiting for data
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              List<EventDetails> details =
                                  EventDetails.listFromJson(snapshot.data);
                              return _buildEventsContent(
                                  details,
                                  Endpoint
                                      .GET_EVENT_CURR); // Show data if available
                            } else {
                              return Text(
                                  'No data'); // Show message if no data is available
                            }
                          } else {
                            return CircularProgressIndicator(); // Show a generic loading indicator for other connection states
                          }
                        },
                      ),
                      FutureBuilder(
                        future: _pastEvents,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CardLoadingShimmer(); // Show loading indicator while waiting for data
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              List<EventDetails> details =
                                  EventDetails.listFromJson(snapshot.data);
                              return _buildEventsContent(
                                  details,
                                  Endpoint
                                      .GET_EVENT_PAST); // Show data if available
                            } else {
                              return Text(
                                  'No data'); // Show message if no data is available
                            }
                          } else {
                            return CircularProgressIndicator(); // Show a generic loading indicator for other connection states
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _fetchCurrentEvents() async {
    _currentEvents = EventRequest.getCurrentEvents();
  }

  _fetchPastEvents() async {
    _pastEvents = EventRequest.getPastEvents();
  }

  Widget _buildEventsContent(List<EventDetails> events, Endpoint endpoint) {
    return RefreshIndicator(
      displacement: 10,
      child: ListView.separated(
          padding: EdgeInsets.only(bottom: 100, top: 10),
          itemBuilder: (context, index) {
            return EventCard(eventDetails: events[index]);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: events.length),
      onRefresh: () async {
        if (endpoint == Endpoint.GET_EVENT_PAST)
          _fetchPastEvents();
        else
          _fetchCurrentEvents();
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
