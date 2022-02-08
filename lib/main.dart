// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
      home :Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _numberController = TextEditingController();
  TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whatsapp link generator'),
        centerTitle: true,
        elevation: 0,
        actions: const <Widget>[
          PopUpMenuOption(),
        ],
        backgroundColor: Color(0xFF075E54),
      ),
      body:
      Container(
        padding: EdgeInsets.all(10),
        color: Color(0xFF075E54),
        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _numberController,
                enableSuggestions: true,
                decoration: InputDecoration(
                  labelText: 'Number',
                  hintText: '06 12 34 56 78',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  helperText: 'Input',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _numberController.clear();
                      _linkController.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: _linkController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Link',
                  labelStyle: TextStyle(
                    color: Colors.white70,
                  ),
                  helperText: 'Output',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.copy),
                    color: Colors.white70,
                    onPressed: () {
                    Clipboard.setData(ClipboardData(text: _linkController.text));
                    showToastMessage('Link copied');
                  },
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                ),
              ),
              ElevatedButton(
                child: Text("Generate link"),
                onPressed: (){
                  setState(() {
                    if (_numberController.text != '') {
                      _linkController.text = 'https://wa.me/' + (_numberController.text).toString();
                    }
                    else{
                      showToastMessage('Enter number first');
                    }
                    });
                },
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF075E54),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
  void showToastMessage(String message){
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_SHORT, //duration for message to show
        gravity: ToastGravity.TOP, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        backgroundColor: Colors.grey, //background Color for message
        textColor: Colors.white, //message text color
        fontSize: 16.0 //message font size
    );
  }
}
enum MenuOption {Share, Rate_US,More_Apps,Privacy_Policy}
class PopUpMenuOption extends StatelessWidget {
  const PopUpMenuOption({Key? key}) : super(key: key);

  _launchURLBrowser(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOption>(
        itemBuilder: (BuildContext context){
          return <PopupMenuEntry<MenuOption>>[
            PopupMenuItem(
              child: Text('Share'),
              value: MenuOption.Share,
            ),
            PopupMenuItem(
              child: Text('Rate Us'),
              value: MenuOption.Rate_US,
            ),
            PopupMenuItem(
              child: Text('More Apps'),
              value: MenuOption.More_Apps,
            ),
            PopupMenuItem(
              child: Text('Privacy Policy'),
              value: MenuOption.Privacy_Policy,
            ),
          ];

        },
      onSelected: (value){
          if (value == MenuOption.Share){
            _launchURLBrowser('https://www.google.com/');
          }
          else if (value == MenuOption.Rate_US){
            _launchURLBrowser('https://www.google.com/');
          }
          else if (value == MenuOption.More_Apps){
            _launchURLBrowser('https://play.google.com/store/apps');
          }
          else if (value == MenuOption.Privacy_Policy){
            _launchURLBrowser('https://www.google.com/');
          }
      },
    );
  }
}
