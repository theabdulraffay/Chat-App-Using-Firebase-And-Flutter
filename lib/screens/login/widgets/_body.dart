part of '../login.dart';

class _Body extends StatelessWidget {
  _Body();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  late double _deviceHeight;
  late double _deviceWidth;
  final _loginFormKEy = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.sizeOf(context).width;
    _deviceHeight = MediaQuery.sizeOf(context).height;
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
            _loginButton(),
            SizedBox(height: _deviceHeight * 0.02),
            _registerAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return RoundedButton(
      name: "Login",
      height: _deviceHeight * 0.065,
      width: _deviceWidth * 0.65,
      onPressed: () {
        // if (_loginFormKey.currentState!.validate()) {
        //   _loginFormKey.currentState!.save();
        //   _auth.loginUsingEmailAndPassword(_email!, _password!);
        // }
      },
    );
  }

  Widget _registerAccountLink() {
    return GestureDetector(
      // onTap: () => _navigation.navigateToRoute('/register'),
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
        key: _loginFormKEy,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomInputFields(
              onSaved: (val) {},
              regEx:
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              hintText: 'Email',
            ),
            CustomInputFields(
              onSaved: (val) {},
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
