import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class HelpHutFirebaseUser {
  HelpHutFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

HelpHutFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<HelpHutFirebaseUser> helpHutFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<HelpHutFirebaseUser>(
        (user) => currentUser = HelpHutFirebaseUser(user));
