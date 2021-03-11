import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loja_virtual_pro/helpers/validators.dart';
import 'package:loja_virtual_pro/models/user.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  final User user = User();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          title: const Text('Criar conta'),
          centerTitle: true,
        ),
        body: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formkey,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                        enabled: !userManager.loading,
                        decoration:
                            const InputDecoration(hintText: 'Nome Completo'),
                        validator: (name) {
                          if (name.isEmpty)
                            return 'Campo Obrigatótio';
                          else if (name.trim().split(' ').length <= 1)
                            return 'Preencha seu nome completo';
                          return null;
                        },
                        onSaved: (name) => user.name = name,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'E-mail'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email.isEmpty)
                            return 'Campo obrigatório';
                          else if (!emailValid(email))
                            return 'E-email invalido';
                          return null;
                        },
                        onSaved: (email) => user.email = email,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: 'Senha'),
                        obscureText: true,
                        validator: (pass) {
                          if (pass.isEmpty)
                            return 'Campo obrigatório';
                          else if (pass.length < 6) return 'Senha muito curta';
                          return null;
                        },
                        onSaved: (pass) => user.password = pass,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        enabled: !userManager.loading,
                        decoration:
                            const InputDecoration(hintText: 'Repita a senha'),
                        obscureText: true,
                        validator: (pass) {
                          if (pass.isEmpty)
                            return 'Campo obrigatório';
                          else if (pass.length < 6) return 'Senha muito curta';
                          return null;
                        },
                        onSaved: (pass) => user.confirmPass = pass,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 44,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          textColor: Colors.white,
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  if (formkey.currentState.validate()) {
                                    formkey.currentState.save();
                                    if (user.password != user.confirmPass) {
                                      scaffoldkey.currentState
                                          .showSnackBar(SnackBar(
                                        content:
                                            const Text('Senhas não coincidem!'),
                                        backgroundColor: Colors.red,
                                      ));
                                      return;
                                    }
                                    userManager.signUp(
                                        user: user,
                                        onSucess: () {
                                          Navigator.of(context).pop();
                                        },
                                        onFail: (e) {
                                          scaffoldkey.currentState
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text('Falha ao cadastrar: $e'),
                                            backgroundColor: Colors.red,
                                          ));
                                        });
                                  }
                                },
                          child: userManager.loading ?
                           CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white) ,
                          ) 
                         : const Text(
                            'Criar Conta',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }
}
