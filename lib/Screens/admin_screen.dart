import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customCheckBox_component.dart';
import 'package:site_historia/Components/customTextFormField_component.dart';
import 'package:site_historia/Components/erroMsg_component.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/firebase/login_auth.dart';
import 'package:velocity_x/velocity_x.dart';

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
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
        body: Center(
          child: FittedBox(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)),
              width: 400,
              height: 340,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Area do Admin",
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
                            CustomCheckBox(
                              title: "Manter Conectado",
                              value: checkedValue,
                              onChanged: (newValue) {
                                setState(() {
                                  checkedValue = newValue!;
                                });
                              },
                            ),
                            msgError == "" ? Container() : ErrorMsg(msgError),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: double.infinity,
                                  child: CustomButton(
                                    text: "Entrar",
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        String msg = await LoginAuth
                                            .loginWithEmailAndPassword(
                                                controllerEmail.text,
                                                controllerPassword.text);
                                        if (msg != "") {
                                          setState(() {
                                            msgError = msg;
                                          });
                                        } else {
                                          VxNavigator.of(context).push(
                                              Uri.parse(RouteNames.ADMIN_INFO),
                                              params: {"logged": true});
                                        }
                                      }
                                    },
                                  )),
                            )
                          ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
