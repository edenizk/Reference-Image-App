
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:reference_photo_app/class/chatMessage.dart';
import 'package:reference_photo_app/utils/consts.dart';
import 'package:reference_photo_app/utils/viewModel/viewModel.dart';
import 'package:reference_photo_app/utils/viewModel/viewModelProvider.dart';
import 'package:signalr_client/signalr_client.dart';

typedef HubConnectionProvider = Future<HubConnection> Function();

class ChatPageViewModel extends ViewModel {
// Properties
  // var kChatServerUrl = "https://chatappweb20200611194907.azurewebsites.net/";
  Consts _consts = new Consts();
  String _serverUrl;
  HubConnection _hubConnection;

  List<ChatMessage> _chatMessages;
  static const String chatMessagesPropName = "chatMessages";
  List<ChatMessage> get chatMessages => _chatMessages;

  bool _connectionIsOpen;
  static const String connectionIsOpenPropName = "connectionIsOpen";
  bool get connectionIsOpen => _connectionIsOpen;
  set connectionIsOpen(bool value) {
    updateValue(connectionIsOpenPropName, _connectionIsOpen, value, (v) => _connectionIsOpen = v);
  }

  String _userName;
  static const String userNamePropName = "userName";
  String get userName => _userName;
  set userName(String value) {
    updateValue(userNamePropName, _userName, value, (v) => _userName = v);
  }

// Methods

  ChatPageViewModel() {
    _serverUrl = _consts.ServerURL + "/chatHub";
    _chatMessages = List<ChatMessage>();
    _connectionIsOpen = false;
    _userName = "No Name";

    openChatConnection();
  }

  Future<void> openChatConnection() async {
    print('open chat connection');
    print(_hubConnection);
    if (_hubConnection == null) {
          print('this is not null');

      _hubConnection = HubConnectionBuilder().withUrl(_serverUrl).build();
      _hubConnection.onclose((error) => connectionIsOpen = false);
      _hubConnection.on("ReceiveMessage", _handleIncommingChatMessage);
    }

    if (_hubConnection.state != HubConnectionState.Connected) {
      await _hubConnection.start();
      connectionIsOpen = true;
    }
  }

  Future<void> sendChatMessage(String message) async {
    if( message == null ||message.length == 0){
      return;
    }
    await openChatConnection();
    _hubConnection.invoke("SendMessage", args: <Object>[userName, message] );
  }

  void _handleIncommingChatMessage(var args){
    final String senderName = args[0][0].toString();
    final String message = args[0][1].toString();
    _chatMessages.add( ChatMessage(senderName, message));
    notifyPropertyChanged(chatMessagesPropName);
  }
}

class ChatPageViewModelProvider extends ViewModelProvider<ChatPageViewModel> {
  // Properties

  // Methods
  ChatPageViewModelProvider({Key key, viewModel: ChatPageViewModel, WidgetBuilder childBuilder}) : super(key: key, viewModel: viewModel, childBuilder: childBuilder);

  static ChatPageViewModel of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ChatPageViewModelProvider) as ChatPageViewModelProvider).viewModel;
  }
}
