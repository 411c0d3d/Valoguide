import 'package:Valoguide/core/constants/params.dart';
import 'package:Valoguide/core/services/events_service.dart';

import 'model.dart';

class EventsListModel extends Model {
  List<Event> _eventsList;
  ViewState viewState = ViewState.Busy;

  Future getEvents() async {
    viewState = ViewState.Busy;
    List<Event> tempEventsList = await EventsService.fetchEvents();
    _eventsList = (tempEventsList != null) ? tempEventsList : _eventsList;
    if (_eventsList != tempEventsList && tempEventsList != null)
      setNetState(NetState.on);
    else if (_eventsList == null || tempEventsList == null)
      setNetState(NetState.off);
    viewState = ViewState.Idle;
    notifyListeners();
  }

  getEventAt(int index) {
    if (_eventsList != null) {
      return _eventsList[index];
    } else {
      return 0;
    }
  }

  addEvent(Event event) {
    if (_eventsList != null) {
      _eventsList.add(event);
    } else {
      this._eventsList = <Event>[];
      _eventsList.add(event);
    }
    notifyListeners();
  }

  listLength() {
    if (_eventsList != null) {
      return _eventsList.length;
    } else {
      return 0;
    }
  }
}

class Event {
  final String title;
  final String date;
  final String prize;
  final String location;
  final String logo;
  final List<String> teams;

  Event(
      {this.title,
      this.date,
      this.prize,
      this.location,
      this.logo,
      this.teams});
  Event.construct(
      this.title, this.date, this.prize, this.location, this.logo, this.teams);
}
