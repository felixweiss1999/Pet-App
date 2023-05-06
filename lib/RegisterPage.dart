import 'package:flutter/material.dart';
import 'package:pet_app/UserData.dart';
import 'CustomButton.dart';
import 'EditProfilePage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  bool hidePassword = true;
  TextEditingController _textControllerUsername = TextEditingController();
  TextEditingController _textControllerP1 = TextEditingController();
  TextEditingController _textControllerP2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNodePw1 = FocusNode();
  final FocusNode _focusNodePw2 = FocusNode();

  void _submit() {
    if (_formKey.currentState?.validate() == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditProfilePage(
                  user: UserData(
                      username: _textControllerUsername.text,
                      password: _textControllerP1.text))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              '注冊',
            ),
            titleTextStyle: TextStyle(
              fontSize: 40,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      autofocus: true,
                      controller: _textControllerUsername,
                      cursorColor: Colors.black,
                      maxLength: 20,
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return '不能為空';
                        }
                      },
                      onEditingComplete: () {
                        if (_formKey.currentState?.validate() == true) {
                          FocusScope.of(context).requestFocus(_focusNodePw1);
                        }
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.account_circle),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.red),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.red),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: "用戶名",
                        labelText: '用戶名',
                        suffixIcon: Icon(
                          Icons.check_circle,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      focusNode: _focusNodePw1,
                      controller: _textControllerP1,
                      cursorColor: Colors.black,
                      maxLength: 20,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_focusNodePw2);
                      },
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: "密碼",
                        labelText: '密碼',
                        helperText: '請設定英文加數字至少6位數',
                        suffixIcon: IconButton(
                          icon: hidePassword
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      focusNode: _focusNodePw2,
                      controller: _textControllerP2,
                      cursorColor: Colors.black,
                      maxLength: 20,
                      obscureText: hidePassword,
                      validator: (value) {
                        if (_textControllerP1.text != value) {
                          return '密碼必須相符!';
                        }
                      },
                      onEditingComplete: _submit,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.red),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Colors.red),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: "重複輸入密碼",
                        labelText: '重複輸入密碼',
                        suffixIcon: IconButton(
                          icon: hidePassword
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )),
              Container(
                constraints: BoxConstraints(maxWidth: 250),
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        label: '確認',
                        onPressed: _submit,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
