import 'package:shared_preferences/shared_preferences.dart';

// Função para guardar o ID do user
Future<void> saveUserID(int userID) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userID', userID);
}

// Função para obter o ID do user
Future<int> getUserID() async {
  final prefs = await SharedPreferences.getInstance();
  final userID = prefs.getInt('userID');
  return userID ?? 0;
}

// Função para limpar o ID do user ao fazer logout
Future<void> clearUserID() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userID');
}

