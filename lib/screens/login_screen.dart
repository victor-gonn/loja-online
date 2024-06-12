import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/user_model.dart';
import 'package:lojaonline2/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _pass = TextEditingController();
  final _emailController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var showPassword = false;

  @override
  Widget build(BuildContext context) {
    print('build 1');
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              child: const Text(
                'Criar conta',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue))
            
          ],
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: "Email"),
                      keyboardType: TextInputType.emailAddress,
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
                    StatefulBuilder(builder: (context, setState) {
                      return TextFormField(
                        controller: _pass,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          hintText: 'Senha',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                                print('build 2');
                              });
                            },
                            icon: Icon(!showPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        validator: (text) {
                          if (text!.isEmpty || text.length < 6) {
                            return 'Senha inválida';
                          }
                          return null;
                        },
                      );
                    }),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            if (_emailController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Digite seu email"),
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              model.RecoveryPass(_emailController.text);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Confira seu email cadastrado"),
                                duration: Duration(seconds: 2),
                              ));
                            }
                          },
                          child: Text(
                            'Esqueci minha senha',
                            textAlign: TextAlign.right,
                          )),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                          model.SignIn(
                            email: _emailController.text,
                            pass: _pass.text,
                            onSuccess: _onSuccess,
                            onFailure: _onFailed,
                          );
                        },
                        child: Text(
                          'Entrar',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue))
                  ],
                ));
          }
        }));
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFailed() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Falha ao realizar login"),
      duration: Duration(seconds: 2),
    ));
  }
}
