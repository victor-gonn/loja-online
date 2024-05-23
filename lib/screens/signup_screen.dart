import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey2 = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _pass = TextEditingController();
  final _confirmPass = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar conta"),
          centerTitle: true,
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return Form(
              key: _formkey2,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Nome Completo"),
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'Nome inválido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                    validator: (text) {
                      if (text!.isEmpty || !text.contains('@')) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _pass,
                    decoration: InputDecoration(
                      hintText: "Senha",
                    ),
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6) {
                        return 'Senha inválida';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _confirmPass,
                    decoration: InputDecoration(
                      hintText: "Confirmar senha",
                    ),
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6) {
                        return 'Senha inválida';
                      }
                      if (text != _pass.text) {
                        return 'Senha divergente';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formkey2.currentState!.validate()) {
                          Map<String, dynamic> userData = {
                            'name': _nameController.text,
                            'email': _emailController.text,
                          };

                          model.SignUp(
                              userData: userData,
                              pass: _pass.text,
                              onSuccess: _onSuccess,
                             onFailure: _onFailure,
                              );
                        }
                      },
                      child: Text(
                        'Criar conta',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue))
                ],
              ));
        }));
  }

  void _onSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Usuário criado com sucesso"),
      duration: Duration(seconds: 2),)
    );

    Future.delayed(Duration(seconds: 2)).then(
      (_) { Navigator.of(context).pop();
      }
    );

    print('Sucesso');
  }

  void _onFailure() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Falha ao criar usuário"),
      duration: Duration(seconds: 2),)
    );
    print('falha');
  }
  
}
