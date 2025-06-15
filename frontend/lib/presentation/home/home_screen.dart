import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/home/home_state.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/utils/platform.dart';

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
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Form(state),
          const Spacer(),
          Text(
            state.version,
            style: TextStyle(color: Palette.TEXT_COLOR_PRIMARY.withAlpha(128)),
          ),
          const VBox(20),
        ],
      ),
    );
  }
}

class Form extends StatelessWidget {
  final HomeState state;

  const Form(this.state);

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
                  labelStyle: TextStyle(color: Palette.TEXT_COLOR_PRIMARY),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.PRIMARY),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.PRIMARY),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.PRIMARY),
                  ),
                  counterText: '',
                ),
                style: const TextStyle(color: Palette.TEXT_COLOR_PRIMARY),
                onChanged: (text) => state.notify(),
              ),
              const VBox(20),
              ElevatedButton(
                onPressed: state.canPlay ? state.onPlay : null,
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.resolveWith<Color>(
                    (states) => Palette.TEXT_COLOR_SECONDARY,
                  ),
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((
                    states,
                  ) {
                    if (states.contains(WidgetState.disabled)) {
                      return Palette.BUTTON_DISABLED;
                    } else {
                      return Palette.PRIMARY;
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.PRIMARY,
                      foregroundColor: Palette.TEXT_COLOR_SECONDARY,
                    ),
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
