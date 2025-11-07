import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../themes/app_colors.dart';

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({super.key});

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
                    onTap: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_rounded, size: 50),
                        Text('Discord', style: TextStyle(color: PasswordWidgetColor.logoText)),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'exemplo@email.com',
                      style: TextStyle(color: PasswordWidgetColor.text, fontSize: 17),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'senha123456',
                      style: TextStyle(color: PasswordWidgetColor.text, fontSize: 17),
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
                        Clipboard.setData(
                          ClipboardData(text: 'exemplo@email.com'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('O login foi Copiado!')),
                        );
                      },
                      icon: Icon(Icons.copy, color: PasswordWidgetColor.icon, size: 16),
                    ),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: 'senha123'));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('A senha foi copiada!')),
                        );
                      },
                      icon: Icon(Icons.copy, color: PasswordWidgetColor.icon, size: 16),
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
