import 'package:flutter/material.dart';
import 'Authentication.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({
    this.auth,
    this.onSignedIn,
  });
  final AuthImplementaion auth;
  final VoidCallback onSignedIn;

  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }
}

enum FormType { login, register }

class _LoginRegisterState extends State<LoginRegisterPage> {
  final formkey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";

  //methods
  bool validateAndSave() {
    final form = formkey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.sigIn(_email, _password);
          print("login userId = " + userId);
        } else {
          String userId = await widget.auth.sigUp(_email, _password);
          print("Register userId = " + userId);
        }
        widget.onSignedIn();
      } catch (e) {
        print("Error = " + e.toString());
      }
    }
  }

  void moveToRegister() {
    formkey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formkey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  //Desgin
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('hoco.', style: new TextStyle(fontSize: 25.0)),
      ),
      body: new Container(
          margin: EdgeInsets.all(15.0),
          child: new Form(
            key: formkey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: createInputs() + createBottons(),
            ),
          )),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 10.0,
      ),
      logo(),
      SizedBox(
        height: 20.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) {
          return value.isEmpty ? 'Email is required .' : null;
        },
        onSaved: (value) {
          return _email = value;
        },
      ),
      SizedBox(
        height: 10.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) {
          return value.isEmpty ? 'password is required .' : null;
        },
        onSaved: (value) {
          return _password = value;
        },
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  Widget logo() {
    return new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('images/app_logo.png'),
      ),
    );
  }

  List<Widget> createBottons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.lightBlue,
          onPressed: validateAndSave,
        ),
        new FlatButton(
          child: new Text('Not have an Account? Create Account?',
              style: new TextStyle(fontSize: 14.0)),
          textColor: Colors.black,
          color: Colors.white,
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        new RaisedButton(
          child:
              new Text('Create Account', style: new TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.lightBlue,
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text('Already have an Account ! Login ',
              style: new TextStyle(fontSize: 14.0)),
          textColor: Colors.red,
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
