import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:reference_photo_app/class/chatMessage.dart';
import 'package:reference_photo_app/utils/viewModel/viewModelPropertyWidgetBuilder.dart';
import 'package:reference_photo_app/views/pages/chatPageViewModel.dart';

class MessageChatView extends StatelessWidget {
  final _scrollController = ScrollController();
  var vm;

  @override
  Widget build(BuildContext context) {
    vm = ChatPageViewModelProvider.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Server Statue: ",
              style: Theme.of(context).textTheme.subhead,
            ),
            ViewModelPropertyWidgetBuilder<bool>(
                viewModel: vm,
                propertyName: ChatPageViewModel.connectionIsOpenPropName,
                builder: (context, snapshot) {
                  return Text(
                    vm.connectionIsOpen ? "Connected" : "Disconnected",
                    style: TextStyle(
                        color: vm.connectionIsOpen ? Colors.green : Colors.red),
                  );
                }),
          ],
        ),
        Expanded(
            child: ViewModelPropertyWidgetBuilder<ChatMessage>(
          viewModel: vm,
          propertyName: ChatPageViewModel.chatMessagesPropName,
          builder: (context, snapshot) {
            return ListView.builder(
                padding: EdgeInsets.all(10.0),
                controller: _scrollController,
                itemCount: vm.chatMessages.length,
                itemBuilder: (BuildContext ctx, int index) =>
                    _createMessageItemView(vm.chatMessages[index]));
          },
        )),
      ],
    );
  }

  Widget _createMessageItemView(ChatMessage message) {
    Timer(
        Duration(milliseconds: 300),
        () => _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut));
    var isUserCurrentUser = message.senderName == vm.userName;
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
          crossAxisAlignment: isUserCurrentUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Text("${message.senderName}"),
            Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  color: isUserCurrentUser ? Colors.green : Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.all(10.0),
              child: message.message.startsWith('image::')
                  ? Container(
                      height: 200,
                      width: 150,
                      child: TransitionToImage(
                        image: AdvancedNetworkImage(
                          message.message.substring(7),
                          timeoutDuration: Duration(minutes: 1),
                        ),
                        placeholder: CircularProgressIndicator(),

                      ),
                    )
                  : Text(message.message),
            ),
          ]),
    );
  }
}
