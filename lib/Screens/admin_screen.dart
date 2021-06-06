/// Tela responsável  por exibir a tela de login para a Área do administrador.
///
/// {@category Screen}
// ignore: library_names
library AdminScreen;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customTextFormField_component.dart';
import 'package:site_historia/Components/widget/erroMsg_component.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:site_historia/firebase/login_auth.dart';
import 'package:velocity_x/velocity_x.dart';
/// Widget uqe exibe um formulário que necessita do email e senha, com os dados validados, a informação
/// é enviada para o banco de dados que verifica se usuário é registrado no banco (A adição de novos usuários deve ser
/// feito manualmente no banco de dados).
class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String msgError = "";
  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  bool checkedValue = false;
  bool _buttonDisabled = false;
  @override
  Widget build(BuildContext context) {
    final projectStore = Provider.of<ProjectStore>(context);

   return Scaffold(
        body: Center(
          child: FittedBox(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)),
              width: 400,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Área do Admin",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextFormField(
                              controller: controllerEmail,
                              textInputType: TextInputType.emailAddress,
                              labelText: "Email",
                              hintText: 'Insira o email',
                              validator: (word) {
                                if (word!.isEmpty) {
                                  return 'Este campo é obrigatório';
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(word)) {
                                  return 'Email inválido';
                                }
                                return null;
                              },
                            ),
                            CustomTextFormField(
                              controller: controllerPassword,
                              textInputType: TextInputType.visiblePassword,
                              obscureText: true,
                              labelText: "Senha",
                              hintText: 'Insira a senha',
                              validator: (word) {
                                if (word!.isEmpty) {
                                  return 'Este campo é obrigatório';
                                }
                                return null;
                              },
                            ),
                            msgError == "" ? Container() : ErrorMsg(msgError),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: double.infinity,
                                  child: CustomButton(
                                    style: !_buttonDisabled
                                        ? null
                                        : ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    Theme.of(context)
                                                        .primaryColor
                                                        .withAlpha(170)),
                                          ),
                                    text: !_buttonDisabled
                                        ? "Entrar"
                                        : "Entrando...",
                                    onPressed: !_buttonDisabled
                                        ? () async {
                                            setState(() {
                                              msgError = "";
                                            });
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                _buttonDisabled = true;
                                              });
                                              String msg = await LoginAuth
                                                  .loginWithEmailAndPassword(
                                                      controllerEmail.text,
                                                      controllerPassword.text);
                                              await Future.delayed(
                                                  Duration(seconds: 1));
                                              setState(() {
                                                _buttonDisabled = false;
                                              });
                                              if (msg != "") {
                                                setState(() {
                                                  msgError = msg;
                                                });
                                              } else {
                                                await projectStore
                                                    .getUsernameByUid(
                                                        LoginAuth.getUser()!
                                                            .uid);
                                                VxNavigator.of(context)
                                                    .clearAndPush(
                                                  Uri.parse(RouteNames
                                                      .ADMIN_PROJECTS),
                                                );
                                              }
                                            }
                                          }
                                        : null,
                                  )),
                            )
                          ]))
                ],
              ),
            ),
          ),
        ),
      );

  }
}
