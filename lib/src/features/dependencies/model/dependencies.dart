import '../../../common/router/application_navigation.dart';
import 'app_metadata.dart';

abstract interface class Dependencies {
  /// App metadata
  abstract final AppMetadata appMetadata;

  /// GoRouter navigator
  abstract final ApplicationNavigation navigation;
}
