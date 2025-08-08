import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test", style: TextStyle(color: Colors.black12)),
      ),
      body: Center(child: Text("HOme screen")),
    );
  }
}
