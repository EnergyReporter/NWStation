import 'package:flutter/material.dart';

import 'auth.dart';

class LoginButton extends StatelessWidget {
  final bool showLogin;

  LoginButton(this.showLogin);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          if (showLogin) {
            return GestureDetector(
              onTap: () => authService.signOut(),
              child: ListTile(
                title: Text('Signout'),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () => authService.googleSignIn(),
              child: ListTile(
                title: Text('Login with Google'),
              ),
            );
          }
        });
  }
}
