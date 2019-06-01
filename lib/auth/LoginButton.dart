import 'package:flutter/material.dart';

import 'auth.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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