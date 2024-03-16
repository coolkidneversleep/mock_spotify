import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayMusicButton extends StatelessWidget {
  const PlayMusicButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.play_arrow,
          color: Colors.black,
          size: 40,
        ),
      ),
      onPressed: () {},
    );
  }
}
