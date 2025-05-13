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
            return _chatList(context);
          },
        ),
      ),
    );
  }

  Widget _chatList(BuildContext context) {
    List<Chat>? chats = _chatsPageProvider.chats;
    return (() {
      if (chats.isNotEmpty) {
        return ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return _chatTile(chats[index], context);
          },
        );
      } else {
        return const Center(child: Text('No Chats Found'));
      }
    })();
  }

  Widget _chatTile(Chat chat, BuildContext context) {
    List<ChatUser> recepients = chat.recepients();
    bool isActive = recepients.any((d) => d.wasRecentlyActive());
    String subtitleText = "";
    if (chat.messages.isNotEmpty) {
      subtitleText =
          chat.messages.first.type != MessageType.text
              ? "Media Attachment"
              : chat.messages.first.content;
    }
    return CustomListViewTileWithActivity(
      height: _deviceHeight * 0.10,
      title: chat.title(),
      subtitle: subtitleText,
      imagePath: chat.imageURL(),
      isActive: isActive,
      isActivity: chat.activity,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen(chat: chat)),
        );
      },
    );
  }
}
