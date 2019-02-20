import 'package:flutter/material.dart';
import 'package:spe_66_days/classes/Global.dart';
import 'package:spe_66_days/widgets/habits/edit_notification_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screen_navigation.dart';

class SignInWidget extends StatefulWidget {

  SignInWidget();

  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}


class SignInState extends State<SignInWidget> {
  SignInState();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Widget build(BuildContext context)  {
    Global.auth.currentUser().then((user) {
      if (user != null)
        Navigator.pushReplacementNamed(context, "home");

    });
    //if ((await Global.auth.currentUser() != null){

    //}
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('66  DAYS',
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        body:  Container(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(children: <Widget>[
              FlatButton(child: Text("Sign in with Google"), onPressed: () async {
                final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
                final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

                final AuthCredential credential = GoogleAuthProvider.getCredential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken,
                );

                FirebaseUser user = await Global.auth.signInWithCredential(credential).catchError((err) => print(err));
                print(user);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ScreenNavigation()));
              }),
              FlatButton(child: Text("test"), onPressed: () async {
                FirebaseUser existing_user = await Global.auth.currentUser();
                print(existing_user);
                FirebaseUser user = await Global.auth.signInAnonymously();
                print(user);
                Navigator.pushReplacementNamed(context, "home");

              })
            ]),
        ));
  } // Build
} // _HabitsState