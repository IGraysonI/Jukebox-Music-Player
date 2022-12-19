import 'package:flutter/material.dart';

import 'instruments_configurator.dart';
import 'shared_preferences_component.dart';

class DebugInstruments extends StatelessWidget {
  const DebugInstruments({required this.instrumentConfigurator, Key? key})
      : super(key: key);

  final InstrumentConfigurator instrumentConfigurator;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).push<MaterialPageRoute>(
        MaterialPageRoute(
          builder: (context) => _DebugInstrumentsPage(
            instrumentConfigurator: instrumentConfigurator,
          ),
        ),
      ),
      icon: const Icon(Icons.code_rounded),
    );
  }
}

class _DebugInstrumentsPage extends StatelessWidget {
  const _DebugInstrumentsPage({required this.instrumentConfigurator, Key? key})
      : super(key: key);

  final InstrumentConfigurator instrumentConfigurator;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🛠️ Debug Instruments 🛠️')),
      body: ListView(
        children: [
          ListTile(
            onTap: () => Navigator.of(context).push<MaterialPageRoute>(
              MaterialPageRoute(
                builder: (context) => const SharedPrefsComponent(),
              ),
            ),
            title: const Text('Cache'),
            leading: const Icon(Icons.storage_rounded),
          )
        ],
      ),
    );
  }
}
