import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_tom/providers/password_visible_provider.dart';
import 'package:shopping_cart_tom/screens/login/utils/snackbar.dart';

import '../../services/auth_service.dart';
import '../main_screen.dart';

class LoginScreen extends StatefulWidget with ChangeNotifier {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 20.0,
                          left: 25.0,
                          right: 25.0,
                        ),
                        child: TextField(
                          focusNode: focusNodeEmail,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            fontFamily: 'WorkSansSemiBold',
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: 'Email Address',
                            hintStyle: TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 17.0,
                              color: Colors.black,
                            ),
                          ),
                          onSubmitted: (_) {
                            focusNodePassword.requestFocus();
                          },
                          onChanged: (value) {
                            context.read<PasswordVisibleProvider>().updateUsername(value.isNotEmpty);
                          },
                        ),

                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 20.0,
                          left: 25.0,
                          right: 25.0,
                        ),
                        child: TextField(
                          focusNode: focusNodePassword,
                          controller: loginPasswordController,
                          obscureText: context.watch<PasswordVisibleProvider>().passwordVisible,

                          style: const TextStyle(
                            fontFamily: 'WorkSansSemiBold',
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              Icons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                context.watch<PasswordVisibleProvider>().passwordVisible ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                context.read<PasswordVisibleProvider>().togglePasswordVisibility();
                              },
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 17.0,
                              color: Colors.black,
                            ),
                          ),
                          onSubmitted: (_) {
                            _toggleSignInButton();
                          },
                          onChanged: (value) {
                            context.read<PasswordVisibleProvider>().updatePasswordVisible(value.isNotEmpty);
                          },
                          textInputAction: TextInputAction.go,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 170.0),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.of(context).colorScheme.secondary,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: <Color>[Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
                    begin: FractionalOffset(0.2, 0.2),
                    end: FractionalOffset(1.0, 1.0),
                    stops: <double>[0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: Theme.of(context).colorScheme.primary,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontFamily: 'WorkSansBold',
                      ),
                    ),
                  ),
                  onPressed: () => _toggleSignInButton(),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.white10,
                        Colors.white,
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 1.0),
                      stops: <double>[0.0, 1.0],
                    ),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSignInButton() {
    if (loginEmailController.text.isNotEmpty) {
      Provider.of<AuthenticationService>(context, listen: false)
          .logIntoAccount(
        loginEmailController.text,
        loginPasswordController.text,
      )
          .whenComplete(() {
        loginEmailController.clear();
        loginPasswordController.clear();
        if (AuthenticationService.successLogin == true) {
          CustomSnackBar(
            context,
            Row(
              children: const [
                Text('Logging into account'),
                CircularProgressIndicator(),
              ],
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );        }
        else {
          warningText(context, "Incorrect Email or Password! Try Again");
        }
      });
    } else {
      warningText(context, "Fill all fields!");
    }
  }


  warningText(BuildContext context, String warning) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              warning,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
