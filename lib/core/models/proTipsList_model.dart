import 'package:Valoguide/core/constants/params.dart';
import 'package:Valoguide/core/services/proTips_service.dart';

import 'model.dart';

class ProTipsListModel extends Model {
  List<Tip> _proTipsList;
  ViewState viewState = ViewState.Busy;

  Future getProTips(agent, map) async {
    viewState = ViewState.Busy;
    List<Tip> tempProTipsList = <Tip>[];
    var fileData = await ProTipsService.fetchProTips(agent);
    for (var tip in fileData) {
      if (tip['map'].toLowerCase() == map.toLowerCase()) {
        tempProTipsList.add(Tip.fromJson(tip));
      }
    }
    _proTipsList = (tempProTipsList != null) ? tempProTipsList : _proTipsList;
    if (_proTipsList != tempProTipsList && tempProTipsList != null)
      setNetState(NetState.on);
    else if (_proTipsList == null || tempProTipsList == null)
      setNetState(NetState.off);
    viewState = ViewState.Idle;
    notifyListeners();
  }

  getTipAt(int index) {
    if (_proTipsList != null) {
      return _proTipsList[index];
    } else {
      return 0;
    }
  }

  addTip(Tip event) {
    if (_proTipsList != null) {
      _proTipsList.add(event);
    } else {
      this._proTipsList = <Tip>[];
      _proTipsList.add(event);
    }
    notifyListeners();
  }

  listLength() {
    if (_proTipsList != null) {
      return _proTipsList.length;
    } else {
      return 0;
    }
  }
}

class Tip {
  String title;
  String map;
  String dfclty;
  String agentName;
  String agentFace;
  String clipId;
  String clipThumb;
  Tip(
      {this.title,
      this.map,
      this.dfclty,
      this.agentName,
      this.agentFace,
      this.clipId,
      this.clipThumb});
  Tip.construct(this.title, this.map, this.dfclty, this.agentName,
      this.agentFace, this.clipId, this.clipThumb);

  Tip.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.map = json['map'];
    this.dfclty = json['dfclty'];
    this.agentName = json['agentName'];
    this.agentFace = json['agentFace'];
    this.clipId = json['clipId'];
    this.clipThumb = json['clipThumb'];
  }
}
