import 'package:ontrack_backoffice/services/api_login.dart';
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

Future<void> saveUserEmailENome(String userEmail, int userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userEmail', userEmail);

  getProfessorNome(userId).then((value) => {
    prefs.setString('userName', value)
  });
}

Future<String> getUserEmail() async {
  final prefs = await SharedPreferences.getInstance();
  final userEmail = prefs.getString('userEmail');
  return userEmail ?? '';
}

Future<void> clearUserEmail() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userEmail');
}

Future<String> getUserName() async {
  final prefs = await SharedPreferences.getInstance();
  final userName = prefs.getString('userName');
  return userName ?? '';
}

Future<void> clearUserName() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userName');
}




