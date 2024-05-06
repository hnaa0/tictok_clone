import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _editingController = TextEditingController();

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  bool _isWriting = false;

  void _onWritingChat(String value) {
    setState(() {
      value.isNotEmpty ? _isWriting = true : _isWriting = false;
    });
  }

  void _onSubmitChat() {
    if (_isWriting) {
      setState(() {
        _editingController.clear();
        _isWriting = false;
      });
      _onScaffoldTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: Sizes.size8,
            leading: Stack(
              children: [
                const CircleAvatar(
                  radius: 24,
                  foregroundImage: NetworkImage(
                      "https://images.pexels.com/photos/1573324/pexels-photo-1573324.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                  child: Text("blue"),
                ),
                Positioned(
                  right: -3.5,
                  bottom: -3.5,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.white,
                        width: 3.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: const Text(
              "blue",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text("Active now"),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.flag,
                  color: Colors.black,
                  size: Sizes.size20,
                ),
                Gaps.h32,
                FaIcon(
                  FontAwesomeIcons.ellipsis,
                  color: Colors.black,
                  size: Sizes.size20,
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
                horizontal: Sizes.size14,
              ),
              itemBuilder: (context, index) {
                final isMine = index % 2 == 0;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Sizes.size14),
                      decoration: BoxDecoration(
                        color: isMine
                            ? Colors.lime
                            : Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(Sizes.size20),
                          topRight: const Radius.circular(Sizes.size20),
                          bottomLeft: Radius.circular(
                              isMine ? Sizes.size20 : Sizes.size5),
                          bottomRight: Radius.circular(
                              !isMine ? Sizes.size20 : Sizes.size5),
                        ),
                      ),
                      child: const Text(
                        "this is a message!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 10,
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                elevation: 0,
                color: Colors.grey.shade50,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: Sizes.size12,
                    bottom: Sizes.size20,
                    left: Sizes.size14,
                    right: Sizes.size14,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: Sizes.size40,
                          child: TextField(
                            controller: _editingController,
                            onChanged: _onWritingChat,
                            cursorColor: Theme.of(context).primaryColor,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size14,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Send a message...",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              suffixIcon: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.size14,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.faceLaugh,
                                      color: Colors.black,
                                      size: Sizes.size20 + Sizes.size2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gaps.h14,
                      GestureDetector(
                        onTap: _onSubmitChat,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          alignment: Alignment.center,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _isWriting
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.paperPlane,
                            color: Colors.white,
                            size: Sizes.size24,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
