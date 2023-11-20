import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class FireButton extends StatefulWidget {
  const FireButton({super.key});

  @override
  State<FireButton> createState() => _FireButtonState();
}

class _FireButtonState extends State<FireButton> {
  late StateMachineController controller;
  late SMIBool smiOn;
  late SMIBool smiHover;

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/rive/fire-button.riv',
      stateMachines: [
        'State Machine 1',
      ],
      onInit: (p0) {
        controller = StateMachineController.fromArtboard(
          p0,
          'State Machine 1',
        )!;
        controller.isActive = true;
        p0.addController(controller);
        smiOn = controller.findInput<bool>('ON') as SMIBool;
        smiHover = controller.findInput<bool>('Hover') as SMIBool;
        smiOn.value = true;
      },
    );
  }
}
