import 'package:Valoguide/core/constants/params.dart';
import 'package:flutter/foundation.dart';

abstract class Model extends ChangeNotifier {
  ViewState _viewState = ViewState.Idle;
  NetState _netState = NetState.off;
  NetState get netState => _netState;

  void setNetState(NetState netState) {
    _netState = netState;
  }

  ViewState get viewState => _viewState;
  void setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  dispose();
}
