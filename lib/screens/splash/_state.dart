part of 'splash.dart';

class SplashScreenStateProvider extends ChangeNotifier {
  static SplashScreenStateProvider s(BuildContext context, [listen = false]) =>
      Provider.of<SplashScreenStateProvider>(context, listen: listen);

  bool isLoading = true;
  int _currentIndex = 0;
  int get index => _currentIndex;
  set index(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
