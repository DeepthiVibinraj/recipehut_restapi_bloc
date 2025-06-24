import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipehut/core/constants/api_constants.dart';
import '../models/user_model.dart';

class AuthRepository {
  Future<UserModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<void> signup(String userName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userName': userName,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
