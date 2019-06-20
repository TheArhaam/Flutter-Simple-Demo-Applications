import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        canvasColor: Color(0xFF484848),
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _signIn(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    FirebaseUser userDetails =
        await _firebaseAuth.signInWithCredential(credential);

    ProviderDetails providerInfo = ProviderDetails(userDetails.providerId);
    List<ProviderDetails> providerData = List<ProviderDetails>();
    providerData.add(providerInfo);
    UserDetails details = UserDetails(
        userDetails.providerId,
        userDetails.displayName,
        userDetails.email,
        providerData,
        userDetails.photoUrl);

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoggedInPage(details)));
    return userDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOG IN'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          RaisedButton(
            color: Colors.black,
            onPressed: () {
              _signIn(context);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
                Text(
                  '  Sign in with Google',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoggedInPage extends StatelessWidget {
  final UserDetails details;
  LoggedInPage(this.details);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        canvasColor: Color(0xFF484848),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(details.userName),
        ),
        body: Column(
          children: <Widget>[
            Image.network(details.photoUrl),
            Text(details.userName,style: TextStyle(color: Colors.white),),
            Text(details.userEmail,style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}

class ProviderDetails {
  final String providerDetails;
  ProviderDetails(this.providerDetails);
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String userEmail;
  final String photoUrl;
  final List<ProviderDetails> providerData;
  UserDetails(this.providerDetails, this.userName, this.userEmail,
      this.providerData, this.photoUrl);
}
