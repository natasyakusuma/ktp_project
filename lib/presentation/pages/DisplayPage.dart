import 'package:flutter/material.dart';

class DisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Next Page'),
        ),
        body: Center(
          child: Text('This is the next page!'),
        ),
      ),
    );
  }
}
