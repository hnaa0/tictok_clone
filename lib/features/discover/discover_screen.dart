import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  bool _isWriting = false;

  // void _onSearhChanged(String value) {
  //   print("Searching from $value");
  // }

  // void _onSubmitted(String value) {
  //   print("Submitted $value");
  // }

  void _onTabChanged(int index) {
    FocusScope.of(context).unfocus();
  }

  void _onWritingTextField(String value) {
    setState(() {
      value.isNotEmpty ? _isWriting = true : _isWriting = false;
    });
  }

  void _onClearTextFieldTap() {
    _textEditingController.clear();
    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          // title: CupertinoSearchTextField(
          //   controller: _textEditinController,
          //   onChanged: _onSearhChanged,
          //   onSubmitted: _onSubmitted,
          // ),
          title: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.sm,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: Sizes.size36,
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: _onWritingTextField,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size8,
                            vertical: Sizes.size6,
                          ),
                          filled: true,
                          fillColor: isDarkMode(context)
                              ? Colors.grey.shade700
                              : Colors.grey.shade200,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size14,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Gaps.h12,
                                FaIcon(
                                  FontAwesomeIcons.magnifyingGlass,
                                  color: isDarkMode(context)
                                      ? Colors.grey.shade300
                                      : Colors.black,
                                  size: Sizes.size20,
                                ),
                              ],
                            ),
                          ),
                          suffixIcon: _isWriting
                              ? GestureDetector(
                                  onTap: _onClearTextFieldTap,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Sizes.size14,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.circleXmark,
                                          color: isDarkMode(context)
                                              ? Colors.grey.shade300
                                              : Colors.grey.shade700,
                                          size: Sizes.size20,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.size16,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.filter,
                      size: Sizes.size20 + Sizes.size2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // PreferredSizeWidget: 특정 사이즈를 가지려고 하지만 자식 위젯 사이즈를 제한하진 않음
          bottom: TabBar(
              onTap: _onTabChanged,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              splashFactory: NoSplash.splashFactory,
              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              tabs: [
                for (var tab in tabs)
                  Tab(
                    text: tab,
                  )
              ]),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(
                Sizes.size6,
              ),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size12,
                childAspectRatio: 9 / 20,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size4),
                      ),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholderFit: BoxFit.cover,
                            placeholder: "assets/images/discover_1.jpg",
                            image:
                                "https://images.pexels.com/photos/23221815/pexels-photo-23221815.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                      ),
                    ),
                    Gaps.v10,
                    const Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      "This is very long long caption flutter so good amazing wowwow",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.size16,
                        height: 1.1,
                      ),
                    ),
                    Gaps.v5,
                    if (constraints.maxWidth < 200 ||
                        constraints.maxWidth > 250)
                      DefaultTextStyle(
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.grey.shade300
                              : Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 13,
                              backgroundImage: NetworkImage(
                                  "https://images.pexels.com/photos/1573324/pexels-photo-1573324.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                            ),
                            Gaps.h6,
                            const Expanded(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                "coolsexyfansyrussianblue",
                              ),
                            ),
                            Gaps.h6,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size14,
                              color: Colors.grey.shade600,
                            ),
                            Gaps.h2,
                            const Text(
                              "2.5M",
                              style: TextStyle(
                                fontSize: Sizes.size12,
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
