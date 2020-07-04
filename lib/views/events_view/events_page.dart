import 'dart:math';

import 'package:Valoguide/core/constants/adMob.dart';
import 'package:Valoguide/core/constants/params.dart';
import 'package:Valoguide/core/models/eventList_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  void initState() {
    Ads?.showBannerAd();
    super.initState();
  }

  final WillPopCallback onWillPop = () {
    Ads?.hideBannerAd();
    return Future.value(true);
  };

  @override
  Widget build(BuildContext context) {
    final eventsList = Provider.of<EventsListModel>(context, listen: false);
    final eventsPlaceHolder = EventsListModel();
    for (var i = 0; i < 6; i++)
      eventsPlaceHolder?.addEvent(new Event.construct("", "", "", "", "", []));
    return Consumer<EventsListModel>(builder: (context, __, _) {
      return WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background/bg00.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: (eventsList.listLength() > 0)
                    ? Center(
                        child: Text(
                          'Events Section',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "Orbitron"),
                        ),
                      )
                    : Text(
                        'Check your network connection  ...  pull to refresh ',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, fontFamily: "Tisa Sans"),
                      ),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  eventsList.setViewState(ViewState.Busy);
                  await eventsList.getEvents();
                },
                child: (eventsList.listLength() == 0 ||
                        eventsList.viewState == ViewState.Busy)
                    ? Shimmer.fromColors(
                        baseColor: Colors.black45.withOpacity(0.8),
                        highlightColor: Colors.blueGrey.withOpacity(0.8),
                        child: CardsList(eventsList: eventsPlaceHolder),
                      )
                    : CardsList(eventsList: eventsList),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CardsList extends StatelessWidget {
  const CardsList({
    Key key,
    @required this.eventsList,
  }) : super(key: key);

  final dynamic eventsList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: eventsList?.listLength(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 6,
            color: Colors.black45.withOpacity(0.4),
            child: Container(
              height: 210,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 20, bottom: 12),
                    child: Row(
                      children: <Widget>[
                        (eventsList.getEventAt(index).logo != '' &&
                                eventsList.getEventAt(index).logo != null)
                            ? Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        "assets/images/background/loader02.jpg",
                                    image: eventsList.getEventAt(index).logo,
                                  ),
                                ),
                              )
                            : Text("Icon"),
                        Expanded(
                          flex: 8,
                          child: (eventsList.getEventAt(index).title != '' &&
                                  eventsList.getEventAt(index).title != null)
                              ? Center(
                                  child: Text(
                                    eventsList.getEventAt(index)?.title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: (eventsList
                                                    .getEventAt(index)
                                                    .title
                                                    .length <
                                                30)
                                            ? 22
                                            : 15),
                                  ),
                                )
                              : Text(
                                  "Title",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 30),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 12),
                      child: (eventsList.getEventAt(index) != null)
                          ? (eventsList.getEventAt(index).date != '' &&
                                  eventsList.getEventAt(index).date != null)
                              ? Text(
                                  "Date : " + eventsList.getEventAt(index).date,
                                  style: TextStyle(color: Colors.white),
                                )
                              : Text(
                                  "Date : Still Unknown",
                                  style: TextStyle(color: Colors.white),
                                )
                          : null),
                  Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 12),
                      child: (eventsList.getEventAt(index) != null)
                          ? (eventsList.getEventAt(index).prize != '' &&
                                  eventsList.getEventAt(index).prize != null)
                              ? Text(
                                  "Prize : ${eventsList.getEventAt(index).prize}",
                                  style: TextStyle(color: Colors.white),
                                )
                              : Text(
                                  "Prize : Still Unknown",
                                  style: TextStyle(color: Colors.white),
                                )
                          : null),
                  Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 12),
                      child: (eventsList.getEventAt(index).location != '' &&
                              eventsList.getEventAt(index).location != null)
                          ? Text(
                              "Location : " +
                                  eventsList.getEventAt(index).location,
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              "Location : Still Unknown",
                              style: TextStyle(color: Colors.white),
                            )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 12),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Participants : ",
                          style: TextStyle(color: Colors.white),
                        ),
                        (eventsList.getEventAt(index).teams.length != 0)
                            ? Expanded(
                                child: SizedBox(
                                  height: 30,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget>[
                                      ...eventsList
                                          .getEventAt(index)
                                          .teams
                                          .map<Widget>((team) {
                                        return CircleAvatar(
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                "assets/images/background/loader02.jpg",
                                            image: team,
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              )
                            : Text(
                                " Still Unknown",
                                style: TextStyle(color: Colors.white),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 0,
      ),
    );
  }
}
