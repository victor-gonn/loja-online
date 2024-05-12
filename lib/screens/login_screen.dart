import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Criar conta',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
                ),
                
              ),
              )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: "Email"
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if(text!.isEmpty || !text.contains('@')) {
                  return 'Email inválido';
                }
                return null;
              },
            ),
            SizedBox(height: 16,),
            TextFormField(
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
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {}, 
                child: Text('Esqueci minha senha',
                textAlign: TextAlign.right,)),
            ),
            SizedBox(height: 24,),
            ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()) {

                }
              },
               child: Text('Entrar',
               style: TextStyle(
                fontSize: 18, 
                color: Colors.white
               ),),
               style: ElevatedButton.styleFrom(backgroundColor: Colors.blue))
          ],
        )),
    );
  }
}
