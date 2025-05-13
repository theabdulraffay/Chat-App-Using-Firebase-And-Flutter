part of '../chat.dart';

//Packages

class _Body extends StatefulWidget {
  final Chat chat;

  const _Body({required this.chat});

  @override
  State<StatefulWidget> createState() {
    return _ChatPageState();
  }
}

class _ChatPageState extends State<_Body> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late ChatPageProvider _pageProvider;

  late GlobalKey<FormState> _messageFormState;
  late ScrollController _messagesListViewController;

  @override
  void initState() {
    super.initState();
    _messageFormState = GlobalKey<FormState>();
    _messagesListViewController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatPageProvider>(
          create:
              (_) => ChatPageProvider(
                widget.chat.uid,
                _auth,
                _messagesListViewController,
              ),
        ),
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (BuildContext context) {
        _pageProvider = context.watch<ChatPageProvider>();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.chat.title(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Color.fromRGBO(0, 82, 218, 1.0),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                color: Color.fromRGBO(0, 82, 218, 1.0),
                onPressed: () async {
                  _auth.logout();
                },
              ),

              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Color.fromRGBO(0, 82, 218, 1.0),
                ),
                onPressed: () {
                  _pageProvider.deleteChat();
                },
              ),

              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color.fromRGBO(0, 82, 218, 1.0),
                ),
                onPressed: () {
                  _pageProvider.goBack();
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _deviceWidth * 0.03,
                vertical: _deviceHeight * 0.02,
              ),
              // height: _deviceHeight,
              width: _deviceWidth * 0.97,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [_messagesListView(), _sendMessageForm()],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _messagesListView() {
    if (_pageProvider.messages != null) {
      if (_pageProvider.messages!.isNotEmpty) {
        return SizedBox(
          height: _deviceHeight * 0.74,
          child: ListView.builder(
            controller: _messagesListViewController,
            itemCount: _pageProvider.messages!.length,
            itemBuilder: (BuildContext context, int index) {
              ChatMessage message = _pageProvider.messages![index];
              bool isOwnMessage = message.senderID == _auth.chatUser.uid;
              return CustomChatListViewTile(
                deviceHeight: _deviceHeight,
                width: _deviceWidth * 0.80,
                message: message,
                isOwnMessage: isOwnMessage,
                sender:
                    widget.chat.members
                        .where((m) => m.uid == message.senderID)
                        .first,
              );
            },
          ),
        );
      } else {
        return Align(
          alignment: Alignment.center,
          child: Text(
            "Be the first to say Hi!",
            style: TextStyle(color: Colors.white),
          ),
        );
      }
    } else {
      return Center(child: CircularProgressIndicator(color: Colors.white));
    }
  }

  Widget _sendMessageForm() {
    return Container(
      height: _deviceHeight * 0.06,
      decoration: BoxDecoration(
        color: Color.fromRGBO(30, 29, 37, 1.0),
        borderRadius: BorderRadius.circular(100),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: _deviceWidth * 0.04,
        vertical: _deviceHeight * 0.03,
      ),
      child: Form(
        key: _messageFormState,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _messageTextField(),
            _sendMessageButton(),
            _imageMessageButton(),
          ],
        ),
      ),
    );
  }

  Widget _messageTextField() {
    return SizedBox(
      width: _deviceWidth * 0.65,
      child: CustomInputFields(
        onSaved: (value) {
          _pageProvider.message = value ?? '';
        },
        regEx: r"^(?!\s*$).+",
        hintText: "Type a message",
        obscureText: false,
      ),
    );
  }

  Widget _sendMessageButton() {
    double size = _deviceHeight * 0.04;
    return SizedBox(
      height: size,
      width: size,
      child: IconButton(
        icon: Icon(Icons.send, color: Colors.white),
        onPressed: () {
          if (_messageFormState.currentState!.validate()) {
            _messageFormState.currentState!.save();
            _pageProvider.sendTextMessage();
            _messageFormState.currentState!.reset();
          }
        },
      ),
    );
  }

  Widget _imageMessageButton() {
    double size = _deviceHeight * 0.04;
    return SizedBox(
      height: size,
      width: size,
      child: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 82, 218, 1.0),
        onPressed: () {
          _pageProvider.sendImageMessage();
        },
        child: Icon(Icons.camera_enhance),
      ),
    );
  }
}
