import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/models/response_result.dart';
import 'package:todoapp/providers/adapter.dart';
import 'package:todoapp/models/user.dart' as _User;
import 'dart:io';

class UserProvider {
  Adapter _adapter = Adapter();
  FirebaseAuth _authInstance = FirebaseAuth.instance;
  ResponseResult _result = ResponseResult();
  Dio _http;

  UserProvider() {
    _http = _adapter.getAdapter();
  }
  
  Future<ResponseResult> register(_User.User user) async{
    try {
      await _authInstance.createUserWithEmailAndPassword(email: user.email, password: user.password);
      user.uuid = _authInstance.currentUser.uid;
      user.token = await _authInstance.currentUser.getIdToken();
      await _authInstance.currentUser.updateProfile(displayName: user.name);
      // await _http.post('collections/users',
      //   data: user.toJson(),
      //   options: Options(
      //     responseType: ResponseType.json,
      //     headers: {
      //       HttpHeaders.authorizationHeader: 'Bearer ${user.token}',
      //       HttpHeaders.contentTypeHeader: 'application/json'
      //     }
      //   )
      // );
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
    } on DioError catch(error) {
      _result.code = error.response.statusCode;
      _result.message = error.message;
    } catch (error) {
      _result.code = 500;
      _result.message = 'There was an error, please try later.';
    }
    return _result;
  }
}