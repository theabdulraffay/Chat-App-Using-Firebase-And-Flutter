part of '../splash.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      SplashScreenService(context: context).getCurrentuser,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Splash Screen ')));
  }
}
