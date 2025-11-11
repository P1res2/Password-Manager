import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../themes/app_colors.dart';

class PasswordCard extends StatelessWidget {
  final String site;
  final String user;
  final String password;
  final VoidCallback showEditDialog;
  final Widget image;

  const PasswordCard({
    super.key,
    required this.site,
    required this.user,
    required this.password,
    required this.showEditDialog,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        height: 115,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Logo
              Expanded(
                flex: 1,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: showEditDialog,
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(width: 50, height: 50, child: image),
                        ),
                        Text(
                          site,
                          style: TextStyle(color: PasswordWidgetColor.logoText),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Login and Password
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      user,
                      style: TextStyle(
                        color: PasswordWidgetColor.text,
                        fontSize: 17,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      password,
                      style: TextStyle(
                        color: PasswordWidgetColor.text,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),

              // Clipboards
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: user));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('O login foi Copiado!')),
                        );
                      },
                      icon: Icon(
                        Icons.copy,
                        color: PasswordWidgetColor.icon,
                        size: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: password));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('A senha foi copiada!')),
                        );
                      },
                      icon: Icon(
                        Icons.copy,
                        color: PasswordWidgetColor.icon,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
