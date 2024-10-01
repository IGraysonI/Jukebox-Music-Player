import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/extension/locale_extension.dart';
import 'package:jukebox_music_player/src/common/localization/localization.dart';
import 'package:jukebox_music_player/src/common/widgets/button/custom_button.dart';
import 'package:jukebox_music_player/src/features/settings/scope/setting_scope.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  static String page() => 'SettingPage';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = SettingsScope.themeOf(context).theme;
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
                  padding: const EdgeInsets.all(8),
                  child: CustomButton.withSwitch(
                    title: const Text('Тема'),
                    description: 'Светлая / темная тема',
                    //TODO: Get system theme
                    value: theme.mode == ThemeMode.dark,
                    onChanged: (value) {
                      if (value) {
                        SettingsScope.of(context).setThemeMode(ThemeMode.dark);
                      } else {
                        SettingsScope.of(context).setThemeMode(ThemeMode.light);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomButton<Locale>.withDropdown(
                    title: const Text('Язык'),
                    description: 'Сменить язык приложения',
                    value: Localization.current.locale,
                    items: Localization.supportedLocales
                        .map(
                          (e) => DropdownMenuItem<Locale>(
                            value: e,
                            child: Text(
                              e.getDisplayLanguage(),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        )
                        .toList(),
                    onChange: (p0) => SettingsScope.of(context).setLocale(p0!),
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
