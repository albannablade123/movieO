import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_programming_project/widgets/Settings-page.dart';

class DrawerClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Movie Companion App',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                color: Colors.black54,
                                blurRadius: 1.5,
                                offset: Offset.fromDirection(-2.0))
                          ]),

                    ),
                    Container(height: 4,),
                    Text('Your Companion to the Media World ', style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              color: Colors.black54,
                              blurRadius: 1.5,
                              offset: Offset.fromDirection(-2.0))
                        ]),)
                  ],
                ),),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black54, blurRadius: 2.0),
                ],
                gradient: LinearGradient(
                    colors: <Color>[Colors.red,Colors.deepOrange, Colors.orange])),
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: (){
              Navigator.pushNamed(context,SettingsPage.routeName);
            },
          ),
          ListTile(
            title: Text('My Movies'),
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: Text('My Favourite Genres '),
            leading: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
