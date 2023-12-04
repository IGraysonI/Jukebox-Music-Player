import 'package:firebase_core/firebase_core.dart';

import '../../../common/cache/shared_prefs_store.dart';
import '../../../common/router/application_navigation.dart';
import 'app_metadata.dart';

abstract interface class Dependencies {
  /// App metadata
  abstract final AppMetadata appMetadata;

  /// GoRouter navigator
  abstract final ApplicationNavigation navigation;

  /// SharedPrefsStore
  abstract final SharedPrefsStore sharedPrefsStore;

  /// Firebase
  abstract final FirebaseApp firebaseApp;
}
