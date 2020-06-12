import 'dart:io';
import 'package:Valoguide/core/models/eventList_model.dart';
import 'package:http/http.dart'
    as http; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart';
// Contains DOM related classes for extracting data from elements

class EventsService {
  static Future fetchEvents() async {
    var client = http.Client();
    http.Response response = await client.get('https://www.thespike.gg/events');

    if (response.statusCode != 200) return response.body;

    var document = parse(response.body);
    var events = <Event>[];

    List<Element> eventsSections =
        document.querySelectorAll('.events-list-overview');
    List<Element> eventsRows = [
      ...eventsSections[0]
          .querySelectorAll('.standard-event , .featured-event'),
      ...eventsSections[1].querySelectorAll('.standard-event , .featured-event')
    ];
    Element eventsItem;
//    print(eventsRows.length);
    var title = '';
    var logo = '';
    Element locationElement;
    var date = '';
    var prize = '';
    var location = '';
    List<String> teams = [];
    List<Element> teamsList;

    for (var eventsRow in eventsRows) {
      eventsItem = eventsRow.querySelector('.item');
      // print(eventsItem);
      title = eventsItem.querySelector('.info-content > h2')?.text;
      date = eventsItem.querySelector('.event-date')?.text;
      prize = eventsItem.querySelector('.amount')?.text;
      logo = eventsItem.querySelector('.event-fixed-logo').attributes['src'];
      locationElement = eventsItem.querySelector('.event-location');
      location = (locationElement != null)
          ? locationElement
              .querySelector('.flag-icon')
              .attributes['class']
              .replaceAll('flag-icon', '')
              .replaceAll('-', '')
              .toUpperCase()
          : '';
      teamsList = eventsItem.querySelectorAll('.small-team-logo > img');
      teams = [];
      for (var teamNode in teamsList) {
        teams.add(teamNode.attributes['src']);
      }

      events.add(new Event(
          title: title,
          date: date,
          prize: prize,
          location: location,
          logo: logo,
          teams: teams));
    }
    events.forEach((event) {
      print(
          "${event.title},${event.date},${event.prize},${event.location},${event.logo},${[
        ...event.teams
      ]}");
    });

    return events;
  }
}
