import 'package:flutter/material.dart';
import 'package:network_connect_check_sample/network_manager.dart';
import 'package:network_connect_check_sample/view_model.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => NetworkManager(),
          ),
          ChangeNotifierProxyProvider<NetworkManager, ViewModel>(
            create: (context) => ViewModel(
              networkManager: context.read<NetworkManager>(),
            ),
            update: (context, nwManager, vm) => vm!..onNetworkManagerUpdated(nwManager),
          )
        ],
        child: MyApp(),
      ),

    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
