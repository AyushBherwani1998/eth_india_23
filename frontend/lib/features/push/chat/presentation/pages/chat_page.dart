import 'dart:convert';
import 'dart:typed_data';

import 'package:blockies/blockies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/push/chat/domain/data/account_provider.dart';
import 'package:frontend/features/push/chat/domain/data/chat_room_provider.dart';
import 'package:intl/intl.dart';
import 'package:push_restapi_dart/push_restapi_dart.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, required this.room});

  final Feeds? room;

  @override
  ConsumerState<ChatPage> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatPage> {
  late Feeds room;
  Message? selectedMessage;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    ref.read(accountProvider).connectWallet(
        "glory science timber unknown happy doctor walnut grain question float coffee trip");
    room = Feeds(
      chatId:
          "ec77fde404d882c75e3202444a85c72b9f686b2932e01faab0d9b637cfccdc43",
      about: null,
      did: null,
      intent: "eip155:0xD3FD4422210E69Fe8cD790a546Cbb5d7DCe904Ce",
      intentSentBy: "eip155:0xD3FD4422210E69Fe8cD790a546Cbb5d7DCe904Ce",
      intentTimestamp: "2023-12-08T20:15:35.000Z",
      publicKey: null,
      profilePicture: null,
      threadhash: "bafyreidl2wdm5sufn7trhqqod3ucoskdej5oclblqxbyhtivlo6layz76m",
      wallets: null,
      combinedDID: "eip155:0xD3FD4422210E69Fe8cD790a546Cbb5d7DCe904Ce",
      name: null,
    );

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatRoomProvider).setCurrentChat(room);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myAddress = ref.read(accountProvider).pushWallet?.address;
    final roomVm = ref.watch(chatRoomProvider);
    final messageList = roomVm.messageList;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          if (selectedMessage != null)
            InkWell(
              child: IconButton(
                  onPressed: () {
                    roomVm.setReplyMessage(selectedMessage);
                    setState(() {
                      selectedMessage = null;
                    });
                  },
                  icon: const Icon(Icons.reply)),
            ),
          if (room.groupInformation != null)
            InkWell(
              onTap: () {
                // _scaffoldKey.currentState!
                //     .showBottomSheet((context) => GroupMembersDialog());
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
              ),
            )
        ],
        title: Text('${room.groupInformation?.groupName ?? room.intentSentBy}'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                    child: roomVm.isLoading && messageList.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : messageList.isEmpty
                            ? const Center(
                                child: Text('No messages found '),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 4),
                                itemCount: messageList.length,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  final item = messageList[index];
                                  bool isSender =
                                      'eip155:$myAddress' == item.fromDID;

                                  return GestureDetector(
                                    onHorizontalDragEnd: (details) {},
                                    onDoubleTap: () {
                                      if (selectedMessage?.timestamp ==
                                          item.timestamp) {
                                        selectedMessage = null;
                                      } else {
                                        selectedMessage = item;
                                      }
                                      setState(() {});
                                    },
                                    child: DecoratedBox(
                                      decoration: selectedMessage != null &&
                                              (selectedMessage?.timestamp ==
                                                  item.timestamp)
                                          ? BoxDecoration(
                                              color:
                                                  Colors.pink.withOpacity(.5))
                                          : BoxDecoration(),
                                      child: PushChatBubble(
                                          isSender: isSender, item: item),
                                    ),
                                  );
                                },
                              )),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: roomVm.selectedFile != null
                          ? Stack(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.file(
                                        roomVm.selectedFile!,
                                        width: 78,
                                        height: 78,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        '${roomVm.selectedFile?.uri.pathSegments.last}',
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                    right: 8,
                                    top: 8,
                                    child: InkWell(
                                      onTap: roomVm.clearSelectedFile,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ))
                              ],
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  Consumer(builder: (context, ref, child) {
                                    final replyTo =
                                        ref.watch(chatRoomProvider).replyTo;

                                    if (replyTo == null) {
                                      return SizedBox.shrink();
                                    }
                                    bool isSender =
                                        'eip155:$myAddress' == replyTo.fromDID;
                                    return Container(
                                      margin: EdgeInsets.all(4),
                                      padding: EdgeInsets.only(left: 8),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                              color: Colors.pink, width: 3),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 4.0),
                                                  child: Text(
                                                    isSender
                                                        ? 'You'
                                                        : pCAIP10ToWallet(
                                                            '${replyTo.fromDID}'),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                ),
                                                Builder(builder: (context) {
                                                  if (replyTo.messageType ==
                                                      MessageType.IMAGE) {
                                                    final content = jsonDecode(
                                                        replyTo.messageContent);

                                                    return _ChatImage(
                                                      imageUrl:
                                                          content['content'],
                                                    );
                                                  } else {
                                                    return Text(
                                                      '${replyTo.displayText}',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      maxLines: 2,
                                                    );
                                                  }
                                                }),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              roomVm.setReplyMessage(null);
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: TextField(
                                      controller: roomVm.controller,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 5,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixIcon: InkWell(
                                          onTap: roomVm.onSelectFile,
                                          child: Icon(
                                            Icons.attachment,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (!roomVm.isSending) {
                            roomVm.onSendMessage();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.deepPurple,
                          ),
                          child: roomVm.isSending
                              ? CupertinoActivityIndicator(color: Colors.white)
                              : Center(
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PushChatBubble extends StatelessWidget {
  const PushChatBubble({
    super.key,
    required this.isSender,
    required this.item,
  });

  final bool isSender;
  final Message item;

  @override
  Widget build(BuildContext context) {
    final replyTo = item.replyTo;
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isSender)
          SizedBox(
            height: 32,
            width: 32,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Blockies(seed: pCAIP10ToWallet('${item.fromDID}')),
            ),
          ),
        ChatBubble(
          clipper: ChatBubbleClipper1(
              type:
                  isSender ? BubbleType.sendBubble : BubbleType.receiverBubble),
          alignment: isSender ? Alignment.topRight : Alignment.topLeft,
          backGroundColor: Colors.pink,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (replyTo != null)
                  Container(
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      border: isSender
                          ? Border(
                              right: BorderSide(color: Colors.white, width: 3),
                            )
                          : Border(
                              left: BorderSide(color: Colors.white, width: 3),
                            ),
                    ),
                    child: Column(
                      crossAxisAlignment: isSender
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            pCAIP10ToWallet('${replyTo.fromDID}'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                          ),
                        ),
                        Builder(builder: (context) {
                          if (replyTo.messageType == MessageType.IMAGE) {
                            final content = jsonDecode(replyTo.messageContent);

                            return _ChatImage(
                              imageUrl: content['content'],
                            );
                          } else {
                            return Text(
                              replyTo.displayText,
                              style: const TextStyle(color: Colors.white),
                              maxLines: 2,
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                if (!isSender)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      pCAIP10ToWallet('${item.fromDID}'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Builder(builder: (context) {
                      if (item.messageType == MessageType.IMAGE) {
                        final content = jsonDecode(item.messageContent);
                        final imgUrl = content['content'];
                        print(imgUrl);
                        return _ChatImage(
                          imageUrl: content['content'],
                        );
                      } else {
                        return Text(
                          item.displayText,
                          style: TextStyle(color: Colors.white),
                        );
                      }
                    }),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        formatDateTime(
                          DateTime.fromMillisecondsSinceEpoch(item.timestamp!),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String formatDateTime(DateTime date, [String? format]) {
  final DateFormat dateFormat = DateFormat(format ?? 'dd MMM @ hh:mm');

  return dateFormat.format(date);
}

class _ChatImage extends StatelessWidget {
  const _ChatImage({
    required this.imageUrl,
  });
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Builder(builder: (context) {
        try {
          if (imageUrl!.startsWith('https://')) {
            return Image.network(imageUrl!);
          }

          return Image.memory(
            dataFromBase64String(imageUrl!),
            fit: BoxFit.fill,
          );
        } catch (e) {
          return FlutterLogo();
        }
      }),
    );
  }
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}
