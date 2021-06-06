/// Classe responsável realizar as operações de autenticação de usuário.
///
/// {@category Firebase}
// ignore: library_names
library LoginAuth;
import 'package:firebase/firebase.dart';

class LoginAuth {

  /// Valida o login com email e senha.
  static Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth().signInWithEmailAndPassword(email, password);
    } on FirebaseError catch (e) {
      if (e.code == 'auth/weak-password') {
        return 'A senha dever ter pelo menos seis caracteres.';
      } else if (e.code == 'auth/email-already-in-use') {
        return 'Já existe uma conta regist  rada nesse email.';
      } else if (e.code == "auth/invalid-email") {
        return 'Email inválido.';
      } else if (e.code == "auth/user-not-found") {
        return 'Email não registrado.';
      } else if (e.code == "auth/wrong-password") {
        return 'Senha inválida.';
      } else if (e.code == "auth/too-many-requests") {
        return "Muitas requisições, tente novamente mais tarde.";
      } else {
        return "Erro ao entrar, tente novamente mais tarde.";
      }
    }
    return "";
  }
  /// Retorna o usuário atual.
  static User? getUser() {
    return auth().currentUser;
  }

  /// Faz o logout.
  static signOut() async {
    await auth().signOut();
  }
}
