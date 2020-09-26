import 'package:flutter/material.dart';
import 'LoginRegisterPage.dart';
import 'HomePage.dart';
import 'Authentication.dart';

class MappingPage extends StatefulWidget {
  final AuthImplementaion auth;

  MappingPage({
    this.auth,
  });

  State<StatefulWidget> createState() {
    return _MappingPageState();
  }
}

enum AuthStaus {
  notSingnedIn,
  signedIn,
}

class _MappingPageState extends State<MappingPage> {
  AuthStaus authStaus = AuthStaus.notSingnedIn;

  @override
  void initState() {
    super.initState();

    // widget.auth.getCurrentUser().then((FirebaseUserId) {
    //   setState(() {
    //     authStaus = FirebaseUserId == null
    //         ? AuthStaus.notSingnedIn
    //         : AuthStaus.signedIn;
    //   });
    // });
  }

  void _signedIn() {
    setState(() {
      authStaus = AuthStaus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStaus = AuthStaus.notSingnedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStaus) {
      case AuthStaus.notSingnedIn:
        return new LoginRegisterPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );

      case AuthStaus.signedIn:
        return new HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
    return null;
  }
}
