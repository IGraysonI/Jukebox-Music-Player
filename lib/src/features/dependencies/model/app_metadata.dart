import 'package:meta/meta.dart';

/// App metadata
@immutable
class AppMetadata {
  const AppMetadata({
    required this.environment,
    required this.isRelease,
    required this.appVersion,
    required this.appVersionMajor,
    required this.appVersionMinor,
    required this.appVersionPatch,
    required this.appBuildTimestamp,
    required this.appName,
    required this.operatingSystem,
    required this.processorCount,
    required this.locale,
    required this.deviceVersion,
    required this.deviceLogicalScreenSize,
    required this.appLaunchedTimestamp,
  });

  /// Environment
  /// Possible values: development, staging, production
  final String environment;

  /// Is release build
  final bool isRelease;

  /// App version
  final String appVersion;

  /// App version major
  final int appVersionMajor;

  /// App version minor
  final int appVersionMinor;

  /// App version patch
  final int appVersionPatch;

  /// App build timestamp
  final int appBuildTimestamp;

  /// App name
  final String appName;

  /// Operating system
  final String operatingSystem;

  /// Processor count
  final int processorCount;

  /// Locale
  final String locale;

  /// Device reprecenation
  final String deviceVersion;

  /// Device logical screen size
  final String deviceLogicalScreenSize;

  /// App launched timestamp
  final DateTime appLaunchedTimestamp;

  /// Convert to headers
  Map<String, String> toHeaders() => <String, String>{
        'X-Meta_Environment': environment,
        'X-Meta_Is-Release': isRelease ? 'true' : 'false',
        'X-Meta_App-Version': appVersion,
        'X-Meta_App-Version-Major': appVersionMajor.toString(),
        'X-Meta_App-Version-Minor': appVersionMinor.toString(),
        'X-Meta_App-Version-Patch': appVersionPatch.toString(),
        'X-Meta_Build-Timestamp': appBuildTimestamp.toString(),
        'X-Meta_App-Name': appName,
        'X-Meta_Operating-System': operatingSystem,
        'X-Meta_Processor-Count': processorCount.toString(),
        'X-Meta_Locale': locale,
        'X-Meta_Device-Representation': deviceVersion,
        'X-Meta_Device-Logical-Screen-Size': deviceLogicalScreenSize,
        'X-Meta_App-Launched-Timestamp': appLaunchedTimestamp.toIso8601String(),
      };
}
