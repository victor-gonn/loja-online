import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {

bool isLoading = false;

void SignIn() {
isLoading = true;
notifyListeners();
Future.delayed(Duration(seconds: 3));
isLoading = false;
notifyListeners();
}

void SignUp() {

}

void RecoveryPass() {
  
}

}