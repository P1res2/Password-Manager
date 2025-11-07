import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../app/models/password_model.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _siteCtrl = TextEditingController();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  late Box<PasswordModel> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<PasswordModel>('senhas');
  }

  void _addSenha() {
    if (_siteCtrl.text.isEmpty || _passCtrl.text.isEmpty) return;

    final nova = PasswordModel(
      site: _siteCtrl.text,
      usuario: _userCtrl.text,
      senha: _passCtrl.text,
    );
    box.add(nova);

    _siteCtrl.clear();
    _userCtrl.clear();
    _passCtrl.clear();
  }

  void _deleteSenha(int index) {
    box.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
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
              TextField(
                controller: _siteCtrl,
                decoration: const InputDecoration(labelText: 'Site'),
              ),
              TextField(
                controller: _userCtrl,
                decoration: const InputDecoration(labelText: 'Usuário'),
              ),
              TextField(
                controller: _passCtrl,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              ElevatedButton(
                onPressed: () {
                  _addSenha();
                },
                child: const Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
