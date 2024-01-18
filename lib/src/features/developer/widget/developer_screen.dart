import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jukebox_music_player/src/common/constant/pubspec.yaml.g.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/scaffold_padding.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/space.dart';
import 'package:octopus/octopus.dart';

/// {@template developer_screen}
/// DeveloperScreen widget.
/// {@endtemplate}
class DeveloperScreen extends StatelessWidget {
  /// {@macro developer_screen}
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            // --- App Bar --- //

            const SliverAppBar(
              title: Text('Developer'),
              pinned: true,
              floating: true,
              snap: true,
            ),

            // --- Application information --- //
            const _GroupSeparator(title: 'Application information'),
            const _ShowApplicationInformationTile(),
            const _ShowLicensePageTile(),
            const _ShowApplicationDependenciesTile(),
            const _ShowApplicationDevDependenciesTile(),
            const _ShowLogsScreenTile(),

            // --- Navigation --- //
            const _GroupSeparator(title: 'Navigation'),
            const _ResetNavigationTile(),

            SliverToBoxAdapter(child: Space.lg()),
          ],
        ),
      );
}

class _GroupSeparator extends StatelessWidget {
  const _GroupSeparator({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: ScaffoldPadding.of(context),
        sliver: SliverToBoxAdapter(
          child: SizedBox(
            height: 48,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  width: 48,
                  child: Divider(
                    indent: 16,
                    endIndent: 16,
                  ),
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1),
                ),
                const Expanded(
                    child: Divider(
                  indent: 16,
                  endIndent: 16,
                ))
              ],
            ),
          ),
        ),
      );
}

class _ShowApplicationInformationTile extends StatelessWidget {
  const _ShowApplicationInformationTile();

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: ScaffoldPadding.of(context),
        sliver: SliverToBoxAdapter(
          child: ListTile(
            title: const Text('Application information'),
            subtitle: const Text(
              'Show information about the application',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => Octopus.of(context).showDialog<void>(
              (context) => AboutDialog(
                applicationVersion: Pubspec.version.representation,
                applicationIcon: const SizedBox.square(
                  dimension: 64,
                  child: Icon(Icons.apps, size: 64),
                ),
                children: [
                  const _CopyTile(
                    title: 'Name',
                    subtitle: Pubspec.name,
                    content: Pubspec.name,
                  ),
                  _CopyTile(
                    title: 'Version',
                    subtitle: Pubspec.version.representation,
                    content: Pubspec.version.representation,
                  ),
                  const _CopyTile(
                    title: 'Description',
                    subtitle: Pubspec.description,
                    content: Pubspec.description,
                  ),
                  const _CopyTile(
                    title: 'Homepage',
                    subtitle: Pubspec.homepage,
                    content: Pubspec.homepage,
                  ),
                  const _CopyTile(
                    title: 'Repository',
                    subtitle: Pubspec.repository,
                    content: Pubspec.repository,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _CopyTile extends StatelessWidget {
  const _CopyTile({
    required this.title,
    this.subtitle,
    this.content,
  });

  final String title;
  final String? subtitle, content;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(title),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        onTap: () {
          Clipboard.setData(
            ClipboardData(
              text: content ?? (subtitle == null ? title : '$title: $subtitle'),
            ),
          );
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              const SnackBar(
                content: Text('Copied to clipboard'),
                duration: Duration(seconds: 3),
              ),
            );
        },
      );
}

class _ShowLicensePageTile extends StatelessWidget {
  const _ShowLicensePageTile();

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: ScaffoldPadding.of(context),
        sliver: SliverToBoxAdapter(
          child: ListTile(
            title: Text(MaterialLocalizations.of(context).viewLicensesButtonLabel),
            subtitle: Text(
              MaterialLocalizations.of(context).licensesPageTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => showLicensePage(
              context: context,
              applicationName: Pubspec.name,
              applicationVersion: Pubspec.version.representation,
              applicationIcon: const SizedBox.square(dimension: 64, child: Icon(Icons.apps, size: 64)),
              useRootNavigator: true,
            ),
          ),
        ),
      );
}

//FIXME: overflow
class _ShowApplicationDependenciesTile extends StatelessWidget {
  const _ShowApplicationDependenciesTile();

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: ScaffoldPadding.of(context),
        sliver: SliverToBoxAdapter(
          child: ListTile(
            title: const Text('Dependencies'),
            subtitle: const Text(
              'Show dependencies.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => Octopus.of(context).showDialog<void>(
              (context) => Dialog(
                insetPadding: const EdgeInsets.all(64),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 480,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'Dependencies',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          children: <Widget>[
                            for (final dependency in Pubspec.dependencies.entries)
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: Chip(
                                  label: Text('${dependency.key}: ${dependency.value}'),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _ShowApplicationDevDependenciesTile extends StatelessWidget {
  const _ShowApplicationDevDependenciesTile();

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: ScaffoldPadding.of(context),
        sliver: SliverToBoxAdapter(
          child: ListTile(
            title: const Text('Dev Dependencies'),
            subtitle: const Text(
              'Show developers dependencies.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => Octopus.of(context).showDialog<void>(
              (context) => Dialog(
                insetPadding: const EdgeInsets.all(64),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 480,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'Dev Dependencies',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          children: <Widget>[
                            for (final dependency in Pubspec.devDependencies.entries)
                              Padding(
                                padding: const EdgeInsets.all(4),
                                child: Chip(
                                  label: Text('${dependency.key}: ${dependency.value}'),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

//TODO: add logs viewer
class _ShowLogsScreenTile extends StatelessWidget {
  const _ShowLogsScreenTile();

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: ScaffoldPadding.of(context),
        sliver: const SliverToBoxAdapter(
          child: Opacity(
            opacity: 0.5,
            child: ListTile(
              title: Text('Logs'),
              subtitle: Text(
                'Show logs.',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: null,
            ),
          ),
        ),
      );
}

class _ResetNavigationTile extends StatelessWidget {
  const _ResetNavigationTile();

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: ScaffoldPadding.of(context),
        sliver: SliverToBoxAdapter(
          child: ListTile(
            title: const Text('Reset navigation'),
            subtitle: const Text(
              'Reset navigation stack.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => Octopus.of(context).popAll(),
          ),
        ),
      );
}
