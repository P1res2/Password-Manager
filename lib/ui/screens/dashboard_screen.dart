import 'package:flutter/material.dart';
import 'package:flutter_password_manager/ui/themes/app_colors.dart';
import 'create_password_screen.dart';
import 'passwords_screen.dart';

class Dashboard extends StatefulWidget {
  final VoidCallback onTrocarTema;

  const Dashboard({super.key, required this.onTrocarTema});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  int _selectedIndex = 0;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = 0;
  final List<Widget> _screens = <Widget>[
    PasswordsScreen(),
    CreatePasswordScreen(),
  ];

  void updateIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            NavigationRail(
              selectedIndex: _selectedIndex,
              groupAlignment: groupAlignment,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: labelType,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Badge(child: Icon(Icons.list_outlined)),
                  selectedIcon: Icon(Icons.list),
                  label: Text('Senhas'),
                ),

                NavigationRailDestination(
                  icon: Icon(Icons.add_box_outlined),
                  selectedIcon: Icon(Icons.add_box_rounded),
                  label: Text('Criar'),
                ),

                NavigationRailDestination(
                  icon: Badge(
                    label: Text('12'),
                    child: Icon(Icons.star_border),
                  ),
                  selectedIcon: Badge(
                    label: Text('12'),
                    child: Icon(Icons.star),
                  ),
                  label: Text('Fav'),
                  disabled: true,
                ),
              ],
              leading: IconButton(
                onPressed: widget.onTrocarTema,
                icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: AppColors.white),
              ),
              leadingAtTop: true,
            ),

            const VerticalDivider(thickness: 1, width: 1),

            // This is the main content.
            Expanded(child: _screens.elementAt(_selectedIndex)),
          ],
        ),
      ),
    );
  }
}
