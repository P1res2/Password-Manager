import 'package:flutter/material.dart';
import 'package:flutter_password_manager/ui/widgets/password_widget.dart';

class PasswordsScreen extends StatefulWidget {
  const PasswordsScreen({super.key});

  @override
  State<PasswordsScreen> createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.45,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 13),
            itemCount: 10,
            itemBuilder: (context, index) => PasswordWidget(),
          ),
        ),
      ),
    );
  }
}
