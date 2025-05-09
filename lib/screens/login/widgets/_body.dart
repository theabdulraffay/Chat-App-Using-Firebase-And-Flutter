part of '../login.dart';

class _Body extends StatelessWidget {
  _Body();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  late double _deviceHeight;
  late double _deviceWidth;
  final _loginFormKey = GlobalKey<FormState>();
  late AuthenticationProvider _auth;

  String? _email;
  String? _password;
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.sizeOf(context).width;
    _deviceHeight = MediaQuery.sizeOf(context).height;
    _auth = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pageTitle(),
            SizedBox(height: _deviceHeight * 0.04),
            _loginForm(),
            SizedBox(height: _deviceHeight * 0.05),
            _loginButton(context),
            SizedBox(height: _deviceHeight * 0.02),
            _registerAccountLink(context),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(context) {
    return RoundedButton(
      name: "Login",
      height: _deviceHeight * 0.065,
      width: _deviceWidth * 0.65,
      onPressed: () async {
        if (_loginFormKey.currentState!.validate()) {
          _loginFormKey.currentState!.save();
          _auth.loginUsingEmailAndPassword(_email!, _password!).then((_) {
            log("User logged in successfully", name: "Login");
            AppRoutes.home.pushReplace(context);
          });
        }
      },
    );
  }

  Widget _registerAccountLink(context) {
    return GestureDetector(
      onTap: () => AppRoutes.signup.push(context),
      child: Text(
        'Don\'t have an account?',
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      height: _deviceHeight * 0.18,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomInputFields(
              onSaved: (val) {
                _email = val;
              },
              regEx:
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              hintText: 'Email',
            ),
            CustomInputFields(
              onSaved: (val) {
                _password = val;
              },
              regEx: r".{8,}",
              hintText: 'Password',
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return SizedBox(
      // padding: const EdgeInsets.only(bottom: 20),
      height: _deviceHeight * 0.1,
      child: Text(
        'Chatify',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
