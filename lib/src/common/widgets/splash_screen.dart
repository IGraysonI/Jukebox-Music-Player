import 'package:flutter/material.dart';

import 'space.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MediaQuery(
        data: MediaQueryData.fromView(View.of(context)),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Material(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.music_note_rounded, size: 96),
                  Space.xl(),
                  const Text(
                    'Пожалуйства подождите',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                  const Text(
                    'Приложение инициализируется',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
