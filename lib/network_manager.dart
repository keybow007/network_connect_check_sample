import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class NetworkManager extends ChangeNotifier{

  //Connectivity_plus
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  bool isFailed = false;
  bool isLoading = false;
  String result = "アプリ起動直後";

  final BASE_URL = "https://newsapi.org/v2/top-headlines?country=jp";
  //TODO ご自分のAPIキーを入れて下さい。
  final API_KEY = "977d1428acaa4e859fe2c429f52ec654";

  void initConnection() {
    print("initConnection");
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void disposeConnection() {
    connectivitySubscription.cancel();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;
    this.isFailed = (connectionStatus == ConnectivityResult.none) ? true : false;
    this.isLoading = false;
    this.result = (connectionStatus == ConnectivityResult.none) ? "ネットワークにつながっていません" : "ネットワークにつながっています";
    notifyListeners();
  }

  Future<void> getData() async {
    if (connectionStatus == ConnectivityResult.none) {
      result = "ネットワークにつながっていません";
      this.isFailed = false;
      notifyListeners();
      return;
    };

    this.isLoading = true;
    notifyListeners();

    http.Response? response;

    final requestUrl = Uri.parse(BASE_URL + "&apiKey=$API_KEY");
    response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      result = response.body;
      this.isFailed = false;
    } else {
      this.isFailed = true;
    }

    this.isLoading = false;
    notifyListeners();
  }



}