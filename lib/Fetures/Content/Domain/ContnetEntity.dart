
  import 'package:intl/intl.dart';

class ContentEntity {
  final int id;
  final String content;
  final DateTime createdAt;

  ContentEntity({
    required this.id,
    required this.content,
    required this.createdAt,
  });

  String get formattedDate {
    return DateFormat('dd-MM-yyyy – kk:mm').format(createdAt.toLocal());
  }

  String get safeContent {
    return content.isEmpty ? "لا توجد ملاحظات" : content;
  }
}
