import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({super.key});

  final _formkey2 = GlobalKey<FormState>();
  final _pass = TextEditingController();
  final _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true,
        
      ),
      body: Form(
        key: _formkey2,
          child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextFormField(
            
            
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
            decoration: InputDecoration(
              hintText: "Email",
            ),
            validator: (text) {
              if(text!.isEmpty || !text.contains('@')) {
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
                if(text!.isEmpty || text.length <6) {
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
                if(text!.isEmpty || text.length <6) {
                  return 'Senha inválida';
                } if(text != _pass.text) {
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
               if( _formkey2.currentState!.validate()) {
                print('Login aceito');
               }
              },
              child: Text(
                'Criar conta',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue))
        ],
      )),
    );
  }
}
