import 'package:Valoguide/core/constants/adMob.dart';
import 'package:Valoguide/core/constants/params.dart';
import 'package:Valoguide/core/models/eventList_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  void initState() {
    // TODO: implement initState
//    isFooterShown = false;
    Ads?.showBannerAd();
    super.initState();
  }

  final WillPopCallback onWillPop = () {
    Ads?.hideBannerAd();
    return Future.value(true);
  };
//  bool willBannerShow() async {
//    if (await Ads.bannerAd.isLoaded()) {
//      isFooterShown = true;
//      return true;
//    } else {
//      isFooterShown = false;
//      return false;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    final eventsList = Provider.of<EventsListModel>(context, listen: false);

    final eventsPlaceHolder = EventsListModel();
    for (var i = 0; i < 12; i++)
      eventsPlaceHolder?.addEvent(Event.construct("", "", "", "", ""));
    print(eventsPlaceHolder.listLength());
    return Consumer<EventsListModel>(builder: (context, __, _) {
      return WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background/bg00.png"),
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
                        style: TextStyle(fontSize: 13, fontFamily: "Tisa"),
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
                        baseColor: Colors.black45.withOpacity(0.7),
                        highlightColor: Color(0xFF080618).withOpacity(0.7),
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
//          color: Color(0xFF080618).withOpacity(0.7),
            color: Colors.black45.withOpacity(0.7),
            child: Container(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 20, bottom: 12),
                    child: Center(
                      child: (eventsList != null)
                          ? Text(
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
                            )
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 12),
                    child: Text(
                      "Date : " + eventsList.getEventAt(index).date ??
                          'Still Unknown',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 12),
                    child: Text(
                      "Prize : " + eventsList.getEventAt(index).prize ??
                          'Still Unknown',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 12),
                    child: Text(
                      "Location : " + eventsList.getEventAt(index).location ??
                          'Still Unknown',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 12),
                    child: Text(
                      "Winner : ${(eventsList.getEventAt(index).winner != '') ? eventsList.getEventAt(index).winner : 'Still Unknown'}",
                      style: TextStyle(color: Colors.white),
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
