import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Failed extends StatelessWidget {
  const Failed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openWeb(),
      child: Container(
        color: Colors.blueAccent,
        child: Center(
            child: Text(
                "インターネットに接続されていないか\nサーバダウン等により取得できません\nインターネットに接続されている場合は\nタップして気象庁公式サイトを表示します")),
      ),
    );
  }

  _openWeb() async {
    final _url = Uri.parse("https://www.jma.go.jp/bosai/");
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
}
