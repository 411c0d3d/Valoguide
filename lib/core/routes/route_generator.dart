import 'package:Valoguide/core/store/store.dart';
import 'package:Valoguide/views/news_view/post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Valoguide/core/constants/data.dart';
import 'package:Valoguide/views/agents_view/agent_details.dart';
import 'package:Valoguide/views/coming_soon.dart';
import 'package:Valoguide/views/events_view/events_page.dart';
import 'package:Valoguide/views/maps_view/map_details.dart';
import 'package:Valoguide/views/maps_view/map_guide.dart';
import 'package:Valoguide/views/maps_view/maps_page.dart';
import 'package:Valoguide/views/news_view/news_page.dart';
import 'package:Valoguide/views/tips_view/tips_page.dart';
import 'package:Valoguide/views/weapons_view/weapon_details.dart';
import 'package:Valoguide/views/agents_view/agents_page.dart';
import 'package:Valoguide/views/home_page.dart';
import 'package:Valoguide/views/weapons_view/weapons_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final RoutArgument routArgument = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/agentsPage':
        return MaterialPageRoute(builder: (_) => AgentsPage());
      case '/weaponsPage':
        return MaterialPageRoute(builder: (_) => WeaponsPage());
      case '/mapsPage':
        return MaterialPageRoute(builder: (_) => MapsPage());
      case '/tipsPage':
        return MaterialPageRoute(builder: (_) => TipsPage());
      case '/newsPage':
        return MaterialPageRoute(builder: (_) => NewsPage());
      case '/eventsPage':
        return MaterialPageRoute(builder: (_) => EventsPage());
      case '/comingSoon':
        return MaterialPageRoute(builder: (_) => ComingSoon());
      case '/agentDetails':
        if (routArgument.agentArguments is AgentArguments) {
          return MaterialPageRoute(
              builder: (_) => AgentDetails(args: routArgument.agentArguments));
        }
        return _errorRoute();
      case '/postDetails':
        if (routArgument.postArgument is PostArgument) {
          return MaterialPageRoute(
              builder: (_) => PostDetails(args: routArgument.postArgument));
        }
        return _errorRoute();
      case '/weaponDetails':
        if (routArgument.weaponArguments is WeaponArguments) {
          return MaterialPageRoute(
              builder: (_) =>
                  WeaponDetails(args: routArgument.weaponArguments));
        }
        return _errorRoute();
      case '/mapDetails':
        if (routArgument.mapArguments is MapArguments) {
          return MaterialPageRoute(
              builder: (_) => MapDetails(args: routArgument.mapArguments));
        }
        return _errorRoute();
      case '/mapGuide':
        if (routArgument.mapArguments is MapArguments) {
          return MaterialPageRoute(
              builder: (_) => MapGuide(args: routArgument.mapArguments));
        }
        return _errorRoute();

      default:
        // if given Route is not one of the switch cases :
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error N` 404'),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.black54),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Text(
                  'You\'re Lost Bub ?',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 50),
                ),
              ),
              FloatingActionButton(
                child: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(_);
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
