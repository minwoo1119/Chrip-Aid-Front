import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("확인되었습니다."),
      ),
      body: Center(
        child: Text(
          "모든 절차를 확인했습니다.",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
