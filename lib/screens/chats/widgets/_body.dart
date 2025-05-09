part of '../chats.dart';

class _Body extends StatelessWidget {
  _Body();
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.sizeOf(context).height;
    _deviceWidth = MediaQuery.sizeOf(context).width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chats',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: Color.fromRGBO(0, 82, 218, 1.0),
            onPressed: () async {
              _auth.logout();
            },
          ),
        ],
      ),
      body: const Center(child: Text('Chats')),
    );
  }
}
