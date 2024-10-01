import 'package:intl/intl.dart' as intl;
import 'package:jukebox_music_player/src/common/util/date_util.dart';

extension DateUtilX on DateTime {
  /// Format date
  String format({intl.DateFormat? format}) => DateUtil.format(this, format: format);
}
