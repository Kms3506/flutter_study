import 'package:flutter/material.dart';
import '../main.dart';

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (bool value) {
                MyApp.of(context)?.toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
