import 'package:my_app/core/error/APIException.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class ContentDataSource {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> GetContent(String userId) async {
    try {
      final response = await supabase
          .from('content')
          .select()
          .eq('user_id', userId);

      print(response);
      return response;
    } on PostgrestException catch (e) {
      throw ApiException(
        message: e.message,
        StutusCode: e.code == 'PGRST116' ? 404 : 400,
      );
    }
  }

  Future<void> addContent(String Content, String user_id) async {
    try {
      final insertedContent = await supabase.from('content').insert({
        "content": Content,
        "user_id": user_id,
      });

      print("Inserted User: $insertedContent");
    } on PostgrestException catch (e) {
      throw ApiException(message: "error is ${e.message}", StutusCode: 400);
    } catch (e) {
      rethrow;
    }
  }


Future<void> updateContent(String content, int contentId) async {
  try {
    final response = await supabase
        .from('content')
        .update({
          'content': content,
        })
        .eq('id', contentId); // لازم تحدد السطر بالـ id

    print("Updated Content: $response");
  } on PostgrestException catch (e) {
    throw ApiException(
        message: "Supabase error: ${e.message}", StutusCode: 400);
  } catch (e) {
    rethrow;
  }
}


  Future<void> deleteContent(int contentId) async {
    await supabase.from('content').delete().eq('id', contentId);
  }
}
