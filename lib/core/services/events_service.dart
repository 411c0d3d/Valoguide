import 'dart:io';
import 'package:Valoguide/core/models/eventList_model.dart';
import 'package:http/http.dart'
    as http; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart';
// Contains DOM related classes for extracting data from elements

class EventsService {
  static var client = http.Client();
  static List<Event> _eventsList = [];
  static const endpoint = 'https://liquipedia.net/valorant/Show_Matches';

  static Future fetchEvents() async {
    try {
      http.Response response = await client.get(endpoint);

      if (response.statusCode != 200) return response.body;

      var document = parse(response.body);

      List<Element> divRows = document.querySelectorAll('.divRow');
      List<Element> divCells;

      for (var divRow in divRows) {
        divCells = divRow.querySelectorAll('.divCell');
        Event tempEvent = new Event.construct(
            divCells[0].text,
            divCells[1].text,
            divCells[2].text,
            divCells[3].text,
            divCells[4].text);
        _eventsList.add(tempEvent);
//        setNetState(NetworkState.on);
      }
//      client.close();
    } on SocketException catch (e) {
//      setNetState(NetworkState.off);
      print(e);
    }
    if (_eventsList.length > 0)
      return _eventsList;
    else
      return null;
  }
}
