import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/view_models/messages_vm.dart';
import 'package:tiktok_clone/utils.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";

  final String chatId;

  const ChatDetailScreen({super.key, required this.chatId});

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
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
      // setState(() {
      //   _chats.add({"mine": true, "text": _editingController.text});
      //   _editingController.clear();
      //   _isWriting = false;
      // });
      // _onScaffoldTap();

      final text = _editingController.text;
      ref.read(messagesProvider.notifier).sendMessage(text);
      _editingController.clear();
    }
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messagesProvider).isLoading;
    final isDark = isDarkMode(context);
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        backgroundColor: isDark ? null : Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: isDark ? null : Colors.grey.shade50,
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
            title: Text(
              "blue (${widget.chatId})",
              style: const TextStyle(fontWeight: FontWeight.w600),
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
            ref.watch(chatProvider).when(
                  data: (data) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size20,
                        horizontal: Sizes.size14,
                      ),
                      itemBuilder: (context, index) {
                        final chat = data[index];
                        final isMine =
                            chat.userId == ref.watch(authRepo).user!.uid;

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: isMine
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
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
                              child: Text(
                                chat.text,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Gaps.v10,
                      itemCount: data.length,
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: Text(error.toString()),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
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
                        onTap: isLoading ? null : _onSubmitChat,
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
                          child: FaIcon(
                            isLoading
                                ? FontAwesomeIcons.hourglass
                                : FontAwesomeIcons.paperPlane,
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
