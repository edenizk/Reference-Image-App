import 'dart:convert';
import 'dart:io';

import 'package:azblob/azblob.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reference_photo_app/helpers/azure_config.dart';
import 'package:reference_photo_app/utils/consts.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:reference_photo_app/views/pages/chat_page_view_model.dart';

class MessageController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageControllerState();
}

class _MessageControllerState extends State<MessageController> {
  final TextEditingController _messageTextController = TextEditingController();
  final picker = ImagePicker();
  File _image;
  var vm;
  AzureConfig azureConfig = new AzureConfig();

  @override
  void dispose() {
    _messageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    vm = ChatPageViewModelProvider.of(context);
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.image),
                onPressed: () => sendImage(),
              ),
              Flexible(
                child: TextField(
                  controller: _messageTextController,
                  decoration: InputDecoration(
                      labelText: 'Your message:', hintText: 'eg. Hi there!'),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => {
                        vm.sendChatMessage(_messageTextController.text),
                        _messageTextController.text = "",
                      })
            ],
          )
        ],
      ),
    );
  }

  Future sendImage() async {
    var storage = AzureStorage.parse(azureConfig.ConnectionString);
    final containerName = "chat";
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final bytes = File(pickedFile.path).readAsBytesSync();
    final fileName = basename(pickedFile.path);
    final extensionName = extension(pickedFile.path).substring(1);
    print("image::${storage.uri()}/$containerName/$fileName");
    try {
      await storage.putBlob('/chat/$fileName',
          contentType: 'image/$extensionName', bodyBytes: bytes).whenComplete(
            vm.sendChatMessage("image::${storage.uri()}$containerName/$fileName")
          );
    } catch (e) {
      print("ERROR:" + e);
    }
  }
}
