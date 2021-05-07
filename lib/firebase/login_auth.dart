import 'package:firebase/firebase.dart';

class LoginAuth {
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

  static User? getUser() {
    return auth().currentUser;
  }

  static signOut() async {
    await auth().signOut();
  }
}
