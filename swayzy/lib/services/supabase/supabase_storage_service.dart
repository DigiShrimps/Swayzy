import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<String> uploadFile({
    required File file,
    required String fileName,
  }) async {
    final bucket = _client.storage.from('ad-images');
    final String path = fileName;

    try {
      await bucket.upload(path, file);
      return bucket.getPublicUrl(path);
    } catch (e) {
      throw Exception('Помилка при завантаженні: $e');
    }
  }
}