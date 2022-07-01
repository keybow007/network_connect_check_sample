import 'dart:async';

import 'package:flutter/material.dart';
import 'package:network_connect_check_sample/network_manager.dart';

class ViewModel extends ChangeNotifier {

  bool get isFailed => networkManager.isFailed;
  bool get isLoading => networkManager.isLoading;
  String get result => networkManager.result;

  final NetworkManager networkManager;
  ViewModel({required this.networkManager}) {
    initConnection();
  }

  void initConnection() {
    networkManager.initConnection();
  }

  @override
  void dispose() {
    networkManager.disposeConnection();
    super.dispose();
  }

  void getData() async {
    await networkManager.getData();
  }

  //NetworkManagerでnotifyListenersされたときに呼ばれるコールバック
  onNetworkManagerUpdated(NetworkManager networkManager) {
    notifyListeners();
  }

}