import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _fingerprintOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
//        child: RaisedButton(
//          onPressed: () {
//            // Navigate back to first route when tapped.
//            Navigator.pop(context);
//          },
//          child: Text('Go back!'),
//        ),
        child:SettingsList(
          sections: [
            SettingsSection(
              title: 'Section',
              tiles: [
                SettingsTile(
                  title: 'Language',
                  subtitle: 'English',
                  leading: Icon(Icons.language),
                  onTap: () {

                  },
                ),
                SettingsTile.switchTile(
                  title: 'Use fingerprint',
                  leading: Icon(Icons.fingerprint),
                  switchValue: _fingerprintOpen,
                  onToggle: (bool value) {
                    setState(() {
                      _fingerprintOpen = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}