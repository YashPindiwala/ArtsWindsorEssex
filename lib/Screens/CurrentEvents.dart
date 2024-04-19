import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import '../API/Endpoints.dart';
import '../Utils/EventCard.dart';
import 'AboutApp.dart';
import 'package:artswindsoressex/Utils/CardLoadingShimmer.dart';
import 'package:artswindsoressex/Screens/Models/EventModel.dart';
import 'package:artswindsoressex/ChangeNotifiers/EventProvider.dart';
import 'package:provider/provider.dart';

class CurrentEvents extends StatefulWidget {
  static const id = "CurrentEvents";

  const CurrentEvents({super.key});

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
                      Consumer<EventProvider>(
                        builder: (context, eventProvider, child) {
                          List<EventDetails> details = eventProvider.eventsCurr;
                          if (!eventProvider.loaded) {
                            return Center(
                              child: CardLoadingShimmer(),
                            );
                          } else {
                            return _buildEventsContent(details, Endpoint.GET_EVENT_CURR);
                          }
                        },
                      ),
                      Consumer<EventProvider>(
                        builder: (context, eventProvider, child) {
                          List<EventDetails> details = eventProvider.eventsPast;
                          if (!eventProvider.loaded) {
                            return Center(
                              child: CardLoadingShimmer(),
                            );
                          } else {
                            return _buildEventsContent(details, Endpoint.GET_EVENT_PAST);
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
          Provider.of<EventProvider>(context,listen: false).fetchPastEvents();
        else
          Provider.of<EventProvider>(context,listen: false).fetchPastEvents();
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
