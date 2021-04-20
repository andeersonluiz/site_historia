import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
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
  String msgError="";
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
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0)
            ),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: controllerEmail,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  hintText: 'Insira o email',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  )),
                              validator: (word) {
                                if (word == null || word.isEmpty) {
                                  return 'Este campo é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: controllerPassword,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: "Senha",
                                  hintText: 'Insira a senha',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  )),
                              validator: (word) {
                                if (word == null || word.isEmpty) {
                                  return 'Este campo é obrigatório';
                                }
                                return null;
                              },
                            ),
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                                unselectedWidgetColor:
                                    Theme.of(context).primaryColor),
                            child: CheckboxListTile(
                              title: Text(
                                "Manter Conectado",
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                              value: checkedValue,
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Theme.of(context).primaryColor,
                              selectedTileColor: Theme.of(context).primaryColor,
                              onChanged: (newValue) {
                                setState(() {
                                  checkedValue = newValue!;
                                });
                              },
                            ),
                          ),

                          msgError==""?Container():Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(msgError,style: Theme.of(context).textTheme.caption!.copyWith(color:Colors.red),),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                  
                                  onPressed: ()async 
                                      {if (_formKey.currentState!.validate()){
                                        String msg =await LoginAuth.loginWithEmailAndPassword(controllerEmail.text, controllerPassword.text);
                                        if(msg !=""){
                                          setState((){
                                            msgError=msg;
                                          });
                                        }else{
                                          VxNavigator.of(context).push(Uri.parse(RouteNames.ADMIN_INFO));
                                        }
                                      }},
                                  style:
                                      Theme.of(context).elevatedButtonTheme.style,
                                  child: Text("ENTRAR",
                                      style: Theme.of(context)
                                          .textTheme
                                          .button!)),
                            ),
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
