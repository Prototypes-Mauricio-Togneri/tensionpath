import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/splash/splash_state.dart';
import 'package:tensionpath/utils/platform.dart';
import 'package:tensionpath/widgets/game_container.dart';

class SplashScreen extends StatelessWidget {
  final SplashState state;

  const SplashScreen._(this.state);

  factory SplashScreen.instance() => SplashScreen._(SplashState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(child: Content(state));
  }
}

class Content extends StatelessWidget {
  final SplashState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<SplashState>(
      state: state,
      builder:
          (context, state) => Center(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: state.nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (text) => state.notify(),
                  ),
                  if (state.canCreate) ...[
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: HorizontalDivider(color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: state.canCreate ? state.onCreateRoom : null,
                      child: const Text('CREATE MATCH'),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: HorizontalDivider(color: Colors.white),
                    ),
                    TextField(
                      controller: state.roomController,
                      decoration: const InputDecoration(
                        labelText: 'Room Id',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (text) => state.notify(),
                    ),
                    const VBox(20),
                    ElevatedButton(
                      onPressed: state.canJoin ? state.onJoinRoom : null,
                      child: const Text('JOIN MATCH'),
                    ),
                  ],
                  if (Platform.isMobile)
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: ElevatedButton(
                        onPressed: state.onFullscreen,
                        child: const Text('FULL SCREEN'),
                      ),
                    ),
                ],
              ),
            ),
          ),
    );
  }
}
