import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(),
          const CircularProgressIndicator(),
          const CircularProgressIndicator
              .adaptive(), // ios에서는  ios인디케이터, android에선 android인디케이터 보여줌
          SizedBox(
            height: 500,
            child: ListWheelScrollView(
              itemExtent: 100, // 리스트 안의 아이템 높이를 지정
              children: [
                for (var x in [1, 2, 3, 4, 5, 6, 7, 8, 9])
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.amber,
                      child: const Text(
                        "pick!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size36,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
