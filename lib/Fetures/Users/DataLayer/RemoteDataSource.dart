// ignore_for_file: non_constant_identifier_names

import 'package:my_app/Fetures/Users/DataLayer/UserModel.dart';
import 'package:my_app/core/error/APIException.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserDataSource {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final response = await supabase
          .from('users')
          .select()
          .order('created_at', ascending: false);
      ;
      print("==================${response}");

      return response ;
    } on PostgrestException catch (e) {
      throw ApiException(message: "error is ${e.message}", StutusCode: 400);
    } catch (e) {
      rethrow;
    }
  }

Future<void> addUser(Usermodel user) async {
  try {
    final insertedUser = await supabase
        .from('users')
        .insert({
          "name": user.name,
          "address": user.address,
          "phone": user.phone,
        })
        .select()
        .single();

    final userId = insertedUser["id"];

    if (user.Content.isNotEmpty) {
      await supabase.from('content').insert({
        "content": user.Content[0],
        "user_id": userId,
      });
    }

  } on PostgrestException catch (e) {

    if (e.code == "23505") {
      throw ApiException(
        message: "هذا المستخدم موجود بالفعل بنفس الاسم والرقم",
        StutusCode: 409,
      );
    }

  
  } catch (e) {
    rethrow;
  }
}



  Future<void> delete_user(String userId) async {
    try {
      final response = await supabase
          .from('users')
          .delete()
          .eq('id', userId)
          .select(); // 👈 مهم لو عايز تعرف هل اتمسح فعلاً

      if (response.isEmpty) {
        throw ApiException(message: "User not found", StutusCode: 404);
      }

      print("Deleted user: $response");
    } on PostgrestException catch (e) {
      throw ApiException(
        message: e.message,
        StutusCode: e.code == 'PGRST116' ? 404 : 400,
      );
    } catch (e) {
      rethrow;
    }
  }
}
