import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:jukebox_music_player/src/common/widgets/basic/elevated_card.dart';

/// Button with arrow icon as default trailing.
class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.title,
    this.description,
    this.trailing,
    this.prefixIcon,
    this.onTap,
    super.key,
  });

  /// Button with switch.
  factory CustomButton.withSwitch({
    required Widget title,
    required bool value,
    required ValueChanged<bool> onChanged,
    String? description,
    IconData? prefixIcon,
  }) =>
      CustomButton(
        title: title,
        description: description,
        prefixIcon: prefixIcon,
        trailing: Switch(
          value: value,
          onChanged: onChanged,
        ),
      );

  /// Button with DropdownButton.
  factory CustomButton.withDropdown({
    required Widget title,
    required List<DropdownMenuItem<Widget>>? items,
    required void Function(Object?) onChange,
    Widget? value,
    String? description,
    IconData? prefixIcon,
  }) =>
      CustomButton(
        title: title,
        description: description,
        prefixIcon: prefixIcon,
        trailing: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: value,
            items: items,
            onChanged: onChange,
          ),
        ),
      );

  final Widget title;
  final String? description;
  final Widget? trailing;
  final IconData? prefixIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => _Body(
        title: title,
        description: description,
        trailing: trailing,
        prefixIcon: prefixIcon,
        onTap: onTap,
      );
}

class _Body extends StatelessWidget {
  const _Body({
    required this.title,
    this.description,
    this.trailing,
    this.prefixIcon,
    this.onTap,
  });

  final Widget title;
  final String? description;
  final Widget? trailing;
  final IconData? prefixIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => ElevatedCard(
        child: ListTile(
          minLeadingWidth: 24,
          onTap: () {
            unawaited(HapticFeedback.lightImpact());
            onTap?.call();
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          leading: prefixIcon != null
              ? Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Icon(prefixIcon, size: 22),
                )
              : null,
          title: title,
          subtitle: description != null
              ? Text(
                  description!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                )
              : null,
          trailing: trailing ??
              const Icon(Icons.arrow_forward_ios_outlined, size: 22),
        ),
      );
}
