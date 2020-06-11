import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reference_photo_app/utils/consts.dart';
import 'package:reference_photo_app/utils/viewModel/viewModelPropertyWidgetBuilder.dart';
import 'package:reference_photo_app/views/pages/chatPageViewModel.dart';
import 'package:reference_photo_app/views/pages/messageChatView.dart';
import 'package:reference_photo_app/views/pages/messageController.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Consts _consts = new Consts();
  final TextEditingController _userNameController = TextEditingController();
  final vm = new ChatPageViewModel();

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("serverat: " + _consts.ServerURL);
    return ChatPageViewModelProvider(
        viewModel: vm,
        childBuilder: (ctx) {
          return Scaffold(
              appBar: AppBar(
                title: Text("User Name: ${vm.userName}"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: _handleUpdateUserName,
                  )
                ],
              ),
              resizeToAvoidBottomPadding: false,
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: MessageChatView(),
                    ),
                    Divider(),
                    MessageController(),
                  ],
                ),
              ));
        });
  }

  void _handleUpdateUserName() async {
    await showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _userNameController,
                    autofocus: true,
                    decoration: InputDecoration(
                        labelText: 'Your Name', hintText: 'eg. John Smith'),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              FlatButton(
                  child: const Text('OK'),
                  onPressed: () {
                    vm.userName = _userNameController.text;
                    Navigator.pop(context);
                  })
            ],
          );
        });
    setState(() {});
  }
}
