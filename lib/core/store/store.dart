import 'package:Valoguide/core/models/eventList_model.dart';
import 'package:Valoguide/core/models/model.dart';
import 'package:Valoguide/core/models/newsList_model.dart';
import 'package:Valoguide/core/models/proTipsList_model.dart';
import 'package:Valoguide/core/services/events_service.dart';
import 'package:Valoguide/core/services/news_service.dart';
import 'package:Valoguide/core/services/proTips_service.dart';

class Store {
// Here stored invoked services
  Map<dynamic, Model> repository = {};
  static int navCounter = 0;
  static final Store _singleton = Store._internal();

  Store._internal();
  factory Store() => _singleton;

  Map<dynamic, Function> _factories = {
    EventsListModel: () => EventsListModel(),
    NewsListModel: () => NewsListModel(),
    ProTipsListModel: () => ProTipsListModel(),
    NewsService: () => NewsService(),
    EventsService: () => EventsService(),
    ProTipsService: () => ProTipsService(),
    // TODO : instantiation of services / managers or view models
  };

  invokeModel(name) {
    if (_factories.containsKey(name)) {
      Function serviceFactory = _factories[name];
      var serviceInstance = serviceFactory();
      repository[name] = serviceInstance;
      return repository[name];
    } else {
      print('wrong service name');
    }
  }

  fetchModel(name) => (repository.containsKey(name)) ? repository[name] : null;

  releaseModel(name) {
    repository[name].dispose();
    repository.remove(name);
  }
}
