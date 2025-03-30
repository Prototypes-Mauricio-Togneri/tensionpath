import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class GameContainer extends StatelessWidget {
  final Widget child;

  const GameContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return DarkStatusBar(child: Scaffold(body: SafeArea(child: child)));
  }
}
