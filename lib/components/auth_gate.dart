import 'package:app1/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/note.dart';
import '../pages/login_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key, required this.orderHistory});
  final List<Sweet> orderHistory;

  @override
  _AuthGateState createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator())
          );
        }

        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null) {
          return ProfilePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}