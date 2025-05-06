part of '../login.dart';

class _Body extends StatelessWidget {
  _Body();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is Login Screen'),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                final currentContext = context;

                try {
                  FirebaseUsersServices().loginUser(
                    emailController.text,
                    passwordController.text,
                  );
                  emailController.clear();
                  passwordController.clear();
                  AppRoutes.home.pushReplace(currentContext);
                } catch (e) {
                  ScaffoldMessenger.of(
                    currentContext,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
