import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const CircleAvatar(radius: 50),
              const Text('Erjan'),
              ElevatedButton(
                onPressed: () {},
                child: const Text('data'),
              ),
            ],
          ),
        ),
      );
}
