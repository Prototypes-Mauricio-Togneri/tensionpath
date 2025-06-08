import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/home/home_state.dart';
import 'package:tensionpath/utils/platform.dart';
import 'package:tensionpath/widgets/game_container.dart';

class HomeScreen extends StatelessWidget {
  final HomeState state;

  const HomeScreen._(this.state);

  factory HomeScreen.instance() => HomeScreen._(HomeState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(child: Content(state));
  }
}

class Content extends StatelessWidget {
  final HomeState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<HomeState>(
      state: state,
      builder: (context, state) => Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: state.nameController,
                maxLength: 15,
                textCapitalization: TextCapitalization.words,
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
                  counterText: '',
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (text) => state.notify(),
              ),
              const VBox(20),
              ElevatedButton(
                onPressed: state.canPlay ? state.onPlay : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((
                    states,
                  ) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.grey;
                    } else {
                      return Colors.white;
                    }
                  }),
                ),
                child: const Text('PLAY'),
              ),
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
