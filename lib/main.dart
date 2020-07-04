import 'package:Valoguide/core/constants/data.dart';
import 'package:Valoguide/core/models/proTipsList_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/models/eventList_model.dart';
import 'core/models/newsList_model.dart';
import 'core/routes/route_generator.dart';
import 'core/store/store.dart';
import 'views/home_page.dart';

void main() {
  runApp(RootView());
}

class RootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store store = Store();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProTipsListModel>(
          create: (_) {
            final ProTipsListModel proTipsList =
                store.invokeModel(ProTipsListModel);
            proTipsList.getProTips(agentNames[8], maps[1]['name']);
            return proTipsList;
          },
          lazy: false,
        ),
        ChangeNotifierProvider<NewsListModel>(
          create: (_) {
            final NewsListModel postsList = store.invokeModel(NewsListModel);
            postsList.getPosts();
            return postsList;
          },
          lazy: false,
        ),
        ChangeNotifierProvider<EventsListModel>(
          create: (_) {
            final EventsListModel eventsList =
                store.invokeModel(EventsListModel);
            eventsList.getEvents();
            return eventsList;
          },
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Valorant Master-Guide',
        theme: ThemeData.dark(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        home: HomePage(),
      ),
    );
  }
}
