import 'package:flutter/material.dart';
import 'package:flutter_password_manager/ui/widgets/app_text_field.dart';
import 'package:flutter_password_manager/ui/widgets/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../app/services/password_service.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _siteCtrl = TextEditingController();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  XFile? _imgCtrl;
  final PasswordService _passwordService = PasswordService();
  late ScaffoldMessengerState messenger;

  Future<void> _addPassword() async {
    if (await _passwordService.addPassword(
      _siteCtrl.text,
      _userCtrl.text,
      _passCtrl.text,
      _imgCtrl,
    )) {
      _siteCtrl.clear();
      _userCtrl.clear();
      _passCtrl.clear();
      setState(() {
        _imgCtrl = null;
      });

      messenger.showSnackBar(
        SnackBar(content: Text('Senha criada com sucesso!')),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Não foi possivel criar a senha. Tente novamente mais tarde.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    messenger = ScaffoldMessenger.of(context);

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EscolherImagemWidget(
                image: _imgCtrl,
                onChanged: (value) {
                  setState(() {
                    _imgCtrl = value;
                  });
                },
              ),

              const SizedBox(height: 16), // Spacing

              AppTextField(label: 'Nome', controller: _siteCtrl),

              const SizedBox(height: 16), // Spacing

              AppTextField(label: 'Usuário', controller: _userCtrl),

              const SizedBox(height: 16), // Spacing

              AppTextField(label: 'Senha', controller: _passCtrl),

              const SizedBox(height: 32), // Spacing

              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: _addPassword,
                  child: const Text(
                    'Adicionar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
