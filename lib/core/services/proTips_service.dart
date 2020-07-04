import 'dart:convert';
import 'package:Valoguide/core/models/proTipsList_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class ProTipsService {
  static Future fetchProTips(String agent) async {
    return await rootBundle
        .loadString("assets/proTipsData/$agent.json")
        .then((jsonStr) {
      var fileData = jsonDecode(jsonStr);
      return fileData;
    });
  }
}
