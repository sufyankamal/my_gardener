import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'loginscreen.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

String urlReset = "http://expectojr.com/mygardener/php/reset_password.php";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ForgotPage(),
    );
  }
}

class ForgotPage extends StatefulWidget {
  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final TextEditingController _emcontroller = TextEditingController();
  String _email = "";
  

  @override
  void initState() {
    loadpref();
    print('Init: $_email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
              top: 10, left: 16.0, right: 16.0, bottom: 10.0),
          child: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 70),
                padding:
                    const EdgeInsets.only(top: 80.0, left: 16.0, right: 16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Get Password",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                          "We will send a password"),
                      const SizedBox(height: 20.0),
                      TextField(
                        controller: _emcontroller,
                        decoration: InputDecoration(hintText: "Email Account"),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.green,
                            textColor: Colors.black,
                            child: Text("get password".toUpperCase()),
                            onPressed: _onLogin,
                          )),
                      const SizedBox(height: 20.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Divider(
                            color: Colors.grey.shade600,
                          )),
                          const SizedBox(width: 10.0),
                          const SizedBox(width: 10.0),
                          Expanded(
                              child: Divider(
                            color: Colors.grey.shade600,
                          )),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: _onBack,
                        child: Text(
                          "login page".toUpperCase(),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                alignment: Alignment.center,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBack() {
    print('Back to login page');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void _onLogin() {
    _email = _emcontroller.text;

    if (_isEmailValid(_email)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Please Wait");
      pr.show();
      http.post(urlReset, body: {
        "email": _email,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        if (res.body == "success") {
          pr.dismiss();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        } else {
          pr.dismiss();
        }
      }).catchError((err) {
        pr.dismiss();
        print(err);
      });
    } else {}
  }

  void loadpref() async {
    print('Inside loadpref()');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email'));
    print(_email);
    if (_email.length > 1) {
      _emcontroller.text = _email;
      setState(() {
        
      });
    } else {
      print('No pref');
      setState(() {
        
      });
    }
  }

  Future<bool> _onBackPressAppBar() async {
    SystemNavigator.pop();
    print('Backpress');
    return Future.value(false);
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
