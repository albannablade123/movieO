import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = 'settings-page';
  bool _darkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrange,
        leading: Icon(Icons.arrow_back,color: Colors.white,),
        title: Text("Settings", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                  color: Colors.black54,
                  blurRadius: 1.5,
                  offset: Offset.fromDirection(-2.0))
            ]),),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SwitchListTile(
              title: Text("Dark Theme", style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  ),),
              value: _darkTheme,
              onChanged: (bool value) {
                print("dark theme on");
              },

            ),
          ),

        ],),

    );
  }
}
