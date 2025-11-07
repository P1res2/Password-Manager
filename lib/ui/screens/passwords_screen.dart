import 'package:flutter/material.dart';
import 'package:flutter_password_manager/ui/widgets/password_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../app/models/password_model.dart';

class PasswordsScreen extends StatefulWidget {
  const PasswordsScreen({super.key});

  @override
  State<PasswordsScreen> createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  late Box<PasswordModel> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<PasswordModel>('senhas');
  }

  final TextEditingController _siteController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void _editPassword(int index) {
    final passwordToEdit = box.getAt(index);
    if (passwordToEdit != null) {
      passwordToEdit.site = _siteController.text;
      passwordToEdit.usuario = _usuarioController.text;
      passwordToEdit.senha = _senhaController.text;
      box.putAt(index, passwordToEdit); // salva a atualização no Hive
      setState(() {}); // força rebuild para atualizar a UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<PasswordModel> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('Nenhuma senha salva ainda.'));
          }
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.45,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 13),
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final passwordInfos = box.getAt(index)!;
                  return PasswordWidget(
                    site: passwordInfos.site,
                    user: passwordInfos.usuario,
                    password: passwordInfos.senha,
                    showEditDialog: () => _showEditDialog(index),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showEditDialog(int index) {
  final passwordInfos = box.getAt(index)!;
  _siteController.text = passwordInfos.site;
  _usuarioController.text = passwordInfos.usuario;
  _senhaController.text = passwordInfos.senha;

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Editar', style: TextStyle(fontWeight: FontWeight.bold),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: _siteController, decoration: const InputDecoration(labelText: 'Site')),
          TextField(controller: _usuarioController, decoration: const InputDecoration(labelText: 'Usuário')),
          TextField(controller: _senhaController, decoration: const InputDecoration(labelText: 'Senha')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            _editPassword(index);
            Navigator.pop(context);
          },
          child: const Text('Salvar'),
        ),
      ],
    ),
  );
}
}
