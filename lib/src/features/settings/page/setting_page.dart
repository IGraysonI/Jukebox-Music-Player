import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/widgets/button/arrow_button.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  static String page() => 'SettingPage';

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Настройки'),
            floating: true,
            pinned: true,
            centerTitle: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton.withSwitch(
                    title: const Text('Тема'),
                    description: 'Светлая / темная тема',
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton.withDropdown(
                    title: const Text('Язык'),
                    description: 'Сменить язык приложения',
                    items: const [],
                    onChange: (p0) {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
