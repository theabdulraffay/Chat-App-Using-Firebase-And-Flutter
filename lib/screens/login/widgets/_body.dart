part of '../login.dart';

class _Body extends StatelessWidget {
  _Body();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  late double _deviceHeight;
  late double _deviceWidth;
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
          children: [_pageTitle()],
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
