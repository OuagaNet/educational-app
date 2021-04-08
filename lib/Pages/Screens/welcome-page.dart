import 'package:educational_app/Pages/Widgets/waiting-indicator.dart';
import 'package:educational_app/Utils/ui-color.dart';
import 'package:educational_app/Utils/ui-scaling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class WelcomePage extends StatefulWidget {
  static const String routeName = '/WelcomeScreen';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextEditingController _phoneController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final FocusNode _phoneSignInFocus = FocusNode();
  final FocusNode _buttonSignInFocus = FocusNode();

  String phoneNumber;
  bool isInit = false;
  bool init = false;
  bool callingCognito = false;
  bool isOtpSent = false;

  @override
  void initState() {
    ///LISTNER TO AUTO EXECUTE LOGIN HANDLER ON RECEIVING PHONE NUMBER
    // _phoneController.addListener(() {
    //   if (phoneNumber != _phoneController.text) {
    //     phoneNumber = _phoneController.text;

    //     ///IF THE DATA IS SLELECTED FROM THE AUTO FIELD DATA
    //     if (_phoneController.text.length == 13) {
    //       Provider.of<EntryProvider>(context).phoneNumberEntry(
    //         _phoneController.text.substring(3),
    //       );
    //       _signUpCognitoHandler();
    //     } else if (_phoneController.text.length == 10) {
    //       Provider.of<EntryProvider>(context).phoneNumberEntry(
    //         _phoneController.text,
    //       );
    //       _signUpCognitoHandler();
    //     }
    //   }
    // });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isInit) {
      FocusScope.of(context).requestFocus(_phoneSignInFocus);
      isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: UiColor.lighShades,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: SizeConfig.blockSizeVertical * 10,
                backgroundImage: AssetImage('assets/Images/logo_ouaganet.jpg',),
              ),
              //Image.asset('assets/images/company-logo.jpeg'),
              SizedBox(height: 25),
              _signInOptionWidget(),
              SignInButton(
                Buttons.GoogleDark,
                text: "Sign up with Google",
                onPressed: () {},
              ),
              SignInButton(
                Buttons.Facebook,
                mini: false,
                text: "Sign up with Google",
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInOptionWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.safeBlockHorizontal * 7,
          right: SizeConfig.safeBlockHorizontal * 7,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _phoneNumberField(),
            SizedBox(height: SizeConfig.safeBlockVertical * 2.5),
            _signInButton(),
            SizedBox(height: SizeConfig.safeBlockVertical * 2.5),
          ],
        ),
      ),
    );
  }

  Widget _phoneNumberField() {
    return Container(
      height: SizeConfig.safeBlockVertical * 9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: TextField(
          controller: _phoneController,
          style: TextStyle(
            fontSize: 20,
            color: UiColor.darkShades,
          ),
          keyboardType: TextInputType.phone,
          enableSuggestions: true,
          cursorRadius: Radius.circular(10),
          cursorColor: Colors.blue[800],
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(
              SizeConfig.safeBlockHorizontal * 2.5,
              SizeConfig.safeBlockVertical * 2,
              SizeConfig.safeBlockHorizontal * 2.5,
              SizeConfig.safeBlockVertical * 2,
            ),
            labelText: 'Phone Number',
            labelStyle: TextStyle(color: UiColor.darkShades.withOpacity(0.75)),
            counterText: '',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: UiColor.lightAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
    );
  }

  Widget _signInButton() {
    return Container(
      height: SizeConfig.safeBlockVertical * 7,
      decoration: BoxDecoration(
        color: UiColor.darkShades,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      child: callingCognito
          ? Center(
              child: WaitingIndicator(height: 20),
            )
          : FlatButton(
              focusNode: _buttonSignInFocus,
              color: UiColor.darkShades,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                  color: UiColor.lighShades,
                ),
              ),
              onPressed: () => _signUpCognitoHandler(),
            ),
    );
  }

  Future<void> _signUpCognitoHandler() async {
    // String message = '';

    // setState(() {
    //   callingCognito = true;
    // });

    // try {
      
    //   await Provider.of<AuthProvider>(context).signUp(
    //     phoneNumber: Provider.of<EntryProvider>(context).getEmployeePhoneNumber,
    //   );

    // } on CognitoClientException catch (e) {
    //   if (e.code == 'UsernameExistsException') {
    //     message = 'Phone Number already exist.';
    //     await _loginHandler();
    //   } else if (e.code == 'InvalidParameterException' ||
    //       e.code == 'CodeMismatchException' ||
    //       e.code == 'ResourceNotFoundException') {
    //     message = 'Validation Error Found';
    //     showSnackBarWithAction(message, 'Report', () {
    //       reportError(context, e.toString());
    //     });
    //   } else if (e.code == 'UserLambdaValidationException') {
    //     message = e.message;
    //     showSnackBarWithAction(message, 'Retry', () {
    //       reportError(context, e.toString());
    //     });
    //   } else {
    //     message = 'Unknown error occurred';
    //     showSnackBarWithAction(e.message, 'Report', () {
    //       reportError(context, e.toString());
    //     });
    //   }
    // } catch (e) {
    //   message = 'Unknown error occurred';
    //   showSnackBarWithAction(message, 'Report', () {
    //     reportError(context, e.toString());
    //   });
    // }

    // if (message == '') {
    //   await _loginHandler();
    // }

    // setState(() {
    //   callingCognito = false;
    // });
  }

  Future<void> _loginHandler() async {
    // String message = '';
    // SmsAutoFill().listenForCode;

    // try {
    //   await Provider.of<AuthProvider>(context).login(
    //     Provider.of<EntryProvider>(context).getEmployeePhoneNumber,
    //   );
    // } on CognitoUserCustomChallengeException catch (e) {} on CognitoClientException catch (e) {
    //   if (e.code == 'InvalidParameterException' ||
    //       e.code == 'CodeMismatchException' ||
    //       e.code == 'ResourceNotFoundException') {
    //     message = 'Error occured, Please try again';
    //     showSnackBarWithAction(message, 'Report', () {
    //       reportError(context, e.toString());
    //     });
    //   } else if (e.code == 'UserLambdaValidationException') {
    //     message = 'Error during validation, Please try again';
    //     showSnackBarWithAction(e.message, 'Report', () {
    //       reportError(context, e.toString());
    //     });
    //   } else {
    //     message = 'Unknown error occurred try again';
    //     showSnackBarWithAction(e.message, 'Report', () {
    //       reportError(context, e.toString());
    //     });
    //   }
    // } catch (e) {
    //   message = 'Unknown error occurred try again';
    //   showSnackBarWithAction(e.message, 'Report', () {
    //     reportError(context, e.toString());
    //   });
    // }

    // if (message == '') {
    //   FocusScope.of(context).unfocus();
    //   Future.delayed(Duration(milliseconds: 100), () {
    //     Navigator.of(context).push(
    //       PageTransition.show(OTPVerificationPage(), Offset(1.0, 0.0)),
    //     );
    //   });
    // }
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  void showSnackBarWithAction(
      String message, String label, Function onPressed) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 10),
      behavior: SnackBarBehavior.fixed,
      action: SnackBarAction(label: label, onPressed: onPressed),
    );

    _scaffoldkey.currentState.showSnackBar(snackBar);
  }
}