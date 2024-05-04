import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  final ScrollController _scrollController = ScrollController();

  bool _isWriting = false;

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.70,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size12),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text("22777 comments"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                    bottom: Sizes.size96,
                    left: Sizes.size16,
                    right: Sizes.size16,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue.shade200,
                        radius: 18,
                        child: const Text(
                          "hazettu",
                          style: TextStyle(
                            fontSize: Sizes.size14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "hazettu",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.v3,
                            const Text("gnar so cute boy ❤❤❤❤❤❤❤❤❤❤❤❤❤❤"),
                          ],
                        ),
                      ),
                      Gaps.h12,
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size20,
                            color: Colors.grey.shade500,
                          ),
                          Gaps.v2,
                          Text(
                            "52.2K",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: Sizes.size12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  separatorBuilder: (context, index) => Gaps.v20,
                ),
              ),
              Positioned(
                width: size.width,
                bottom: 0,
                child: BottomAppBar(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size16,
                      vertical: Sizes.size10,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              "https://images.pexels.com/photos/16603124/pexels-photo-16603124.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                          foregroundColor: Colors.white,
                        ),
                        Gaps.h10,
                        Expanded(
                          child: SizedBox(
                            height: Sizes.size44,
                            child: TextField(
                              onTap: _onStartWriting,
                              minLines: null,
                              maxLines: null,
                              expands: true,
                              textInputAction: TextInputAction.newline,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                hintText: "Write a comment...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size12,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size10,
                                  vertical: Sizes.size12,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    right: Sizes.size14,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Gaps.h12,
                                      FaIcon(
                                        FontAwesomeIcons.at,
                                        color: Colors.grey.shade800,
                                        size: Sizes.size20 + Sizes.size2,
                                      ),
                                      Gaps.h12,
                                      FaIcon(
                                        FontAwesomeIcons.gift,
                                        color: Colors.grey.shade800,
                                        size: Sizes.size20 + Sizes.size2,
                                      ),
                                      Gaps.h12,
                                      FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        color: Colors.grey.shade800,
                                        size: Sizes.size20 + Sizes.size2,
                                      ),
                                      Gaps.h12,
                                      if (_isWriting)
                                        GestureDetector(
                                          onTap: _stopWriting,
                                          child: FaIcon(
                                            FontAwesomeIcons.arrowUp,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: Sizes.size20 + Sizes.size2,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
