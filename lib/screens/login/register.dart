import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_tom/screens/login/utils/snackbar.dart';

import '../../providers/password_visible_provider.dart';
import '../../services/auth_service.dart';
import '../main_screen.dart';

class RegisterScreen extends StatefulWidget with ChangeNotifier {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode focusNodeFirstName = FocusNode();
  final FocusNode focusNodeLastName = FocusNode();
  final FocusNode focusNodeUserName = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  TextEditingController signupFirstNameController = TextEditingController();
  TextEditingController signupLastNameController = TextEditingController();
  TextEditingController signupUserNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();

  @override
  void dispose() {
    focusNodeFirstName.dispose();
    focusNodeLastName.dispose();
    focusNodeUserName.dispose();
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                    height: 360.0,
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
                            focusNode: focusNodeFirstName,
                            controller: signupFirstNameController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            autocorrect: false,
                            style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              hintText: 'First Name',
                              hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold',
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            onSubmitted: (_) {
                              focusNodeLastName.requestFocus();
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
                            focusNode: focusNodeLastName,
                            controller: signupLastNameController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            autocorrect: false,
                            style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              hintText: 'Last Name',
                              hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold',
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            onSubmitted: (_) {
                              focusNodeEmail.requestFocus();
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
                            focusNode: focusNodeEmail,
                            controller: signupEmailController,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
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
                              ),
                              hintText: 'Email Address',
                              hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold',
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            onSubmitted: (_) {
                              focusNodePassword.requestFocus();
                            },
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                              bottom: 20.0,
                              left: 25.0,
                              right: 25.0,
                            ),
                            child: TextField(
                              focusNode: focusNodePassword,
                              controller: signupPasswordController,
                              obscureText: context.watch<PasswordVisibleProvider>().passwordVisible,
                              autocorrect: false,
                              style: const TextStyle(
                                fontFamily: 'WorkSansSemiBold',
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                  fontFamily: 'WorkSansSemiBold',
                                  fontSize: 16.0,
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
                              ),
                              onChanged: (value) {
                                context.read<PasswordVisibleProvider>().updatePasswordVisible(value.isNotEmpty);
                              },
                              onSubmitted: (_) {
                                _toggleSignUpButton();
                              },
                            ),
                          ),

                        ),

                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 340.0),
                  decoration: BoxDecoration(
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
                      colors: <Color>[
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: <double>[0.0, 1.0],
                    ),
                  ),
                  child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.of(context).colorScheme.primary,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 42.0,
                      ),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'WorkSansBold',
                        ),
                      ),
                    ),
                    onPressed: () => _toggleSignUpButton(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toggleSignUpButton() {
    CustomSnackBar(
      context,
      Row(
        children: const [
          Text('You are taken to the confirmation screen'),
          CircularProgressIndicator(),
        ],
      ),
    );
    if (signupPasswordController.text.length < 6) {
      warningText(context, "Password cannot be less than 6 characters!");
    } else if (signupEmailController.text.isEmpty ||
        signupUserNameController.text.isEmpty ||
        signupLastNameController.text.isEmpty ||
        signupFirstNameController.text.isEmpty) {
      warningText(context, "Fill all fields!");
    } else if (signupEmailController.text.isNotEmpty) {
      Provider.of<AuthenticationService>(context, listen: false)
          .createAccount(
        signupFirstNameController.text,
        signupLastNameController.text,
        // signupUserNameController.text,
        signupFirstNameController.text + signupLastNameController.text,
        signupEmailController.text,
        signupPasswordController.text,
      )
          .whenComplete(() async {
        if (kDebugMode) {
          print("Creating account");
        }
      }).whenComplete(() {
        signupFirstNameController.clear();
        signupLastNameController.clear();
        // signupUserNameController.clear();
        signupPasswordController.clear();
        signupEmailController.clear();
        if (AuthenticationService.successSignup == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        }
        else {
          warningText(context, "SignUp Unsuccessful. Check details again.");
        }
      });
    }
  }

  warningText(BuildContext context, String warning) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15.0),
          ),
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              warning,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
