part of '../chats.dart';

class _Body extends StatelessWidget {
  _Body();
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late ChatsPageProvider _chatsPageProvider;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.sizeOf(context).height;
    _deviceWidth = MediaQuery.sizeOf(context).width;
    _auth = Provider.of<AuthenticationProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatsPageProvider>(
          create: (_) => ChatsPageProvider(_auth),
        ),
      ],
      child: Scaffold(
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
        body: Builder(
          builder: (context) {
            _chatsPageProvider = context.watch<ChatsPageProvider>();
            return _chatList();
          },
        ),
      ),
    );
  }

  Widget _chatList() {
    List<Chat>? chats = _chatsPageProvider.chats;
    return (() {
      if (chats.isNotEmpty) {
        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return _chatTile(chats[index]);
          },
        );
      } else {
        return const Center(child: Text('No Chats Found'));
      }
    })();
  }

  Widget _chatTile(Chat _chat) {
    List<ChatUser> _recepients = _chat.recepients();
    bool _isActive = _recepients.any((_d) => _d.wasRecentlyActive());
    String _subtitleText = "";
    if (_chat.messages.isNotEmpty) {
      _subtitleText =
          _chat.messages.first.type != MessageType.text
              ? "Media Attachment"
              : _chat.messages.first.content;
    }
    return CustomListViewTileWithActivity(
      height: _deviceHeight * 0.10,
      title: _chat.title(),
      subtitle: _subtitleText,
      imagePath: _chat.imageURL(),
      isActive: _isActive,
      isActivity: _chat.activity,
      onTap: () {
        // _navigation.navigateToPage(ChatPage(chat: _chat));
      },
    );
  }
}
