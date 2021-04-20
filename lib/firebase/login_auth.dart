import 'package:firebase_auth/firebase_auth.dart';

class LoginAuth {

  static Future<String> loginWithEmailAndPassword(String email, String password) async {
    try {
      
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        return 'A senha dever ter pelo menos seis caracteres.';
      } else if (e.code == 'email-already-in-use') {
        return 'Já existe uma conta registrada nesse email.';
      }else if(e.code=="invalid-email"){
        return 'Email inválido.';
      }else if(e.code=="user-not-found"){
        return 'Email não registrado.';
      }else if(e.code=="wrong-password"){
        return 'Senha inválida.';

      }else if(e.code=="too-many-requests"){
        return "Muitas requisições, tente novamente mais tarde.";
      }
      
      else {
        return "Erro ao entrar, tente novamente mais tarde.";
      }
    }
    return "";
  }

  static User? getUser(){
    return FirebaseAuth.instance.currentUser;
  }
}
