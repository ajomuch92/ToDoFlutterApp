import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/models/response_result.dart';
import 'package:todoapp/models/user.dart' as _User;

class UserProvider {
  FirebaseAuth _authInstance = FirebaseAuth.instance;
  ResponseResult _result = ResponseResult();
  
  Future<ResponseResult> register(_User.User user) async{
    try {
      await _authInstance.createUserWithEmailAndPassword(email: user.email, password: user.password);
      user.uuid = _authInstance.currentUser.uid;
      user.token = await _authInstance.currentUser.getIdToken();
      await _authInstance.currentUser.updateProfile(displayName: user.name);
      await _authInstance.signOut();
      _result.code = 200;
      _result.message = 'The user was registered successfully';
    } on FirebaseAuthException catch (e) {
      _result.code = 500;
      if (e.code == 'weak-password') {
        _result.message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        _result.message = 'The account already exists for that email.';
      } 
    } catch (error) {
      _result.code = 500;
      _result.message = 'There was an error, please try later.';
    }
    return _result;
  }

  Future<ResponseResult> login(_User.User user) async{
    try {
      await _authInstance.signInWithEmailAndPassword(email: user.email, password: user.password);
      user.uuid = _authInstance.currentUser.uid;
      user.token = await _authInstance.currentUser.getIdToken();
      user.name = _authInstance.currentUser.displayName;
      _result.code = 200;
      _result.result = user;
    } on FirebaseAuthException catch (e) {
      _result.code = 500;
      _result.message = 'There was an error, please try later.';
      _result.result = e.message;
    } catch (error) {
      _result.code = 500;
      _result.message = 'There was an error, please try later.';
    }
    return _result;
  }

  Future<ResponseResult> logout() async{
    try {
      await _authInstance.signOut();
      _result.code = 200;
    } on FirebaseAuthException catch (e) {
      _result.code = 500;
      _result.message = 'There was an error, please try later.';
      _result.result = e.message;
    } catch (error) {
      _result.code = 500;
      _result.message = 'There was an error, please try later.';
    }
    return _result;
  }
}