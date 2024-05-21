import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/user_profile_edit_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_vm.dart';
import 'package:tiktok_clone/features/users/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_account.dart';
import 'package:tiktok_clone/utils.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  void _onEditPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserProfileEditScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  physics: const BouncingScrollPhysics(),
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(data.name),
                        centerTitle: true,
                        actions: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: _onEditPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                ),
                              ),
                              IconButton(
                                onPressed: _onGearPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.gear,
                                  size: Sizes.size20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Gaps.v20,
                            if (MediaQuery.of(context).size.width <
                                Breakpoints.lg) ...[
                              Avatar(
                                name: data.name,
                                hasAvatar: data.hasAvatar,
                                uid: data.uid,
                              ),
                              Gaps.v20,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "@${data.name}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: Sizes.size18,
                                    ),
                                  ),
                                  Gaps.h5,
                                  const FaIcon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    size: Sizes.size16,
                                    color: Colors.lightBlue,
                                  ),
                                ],
                              ),
                              Gaps.v24,
                              SizedBox(
                                height: Sizes.size48,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const UserAccount(
                                      category: "Following",
                                      numbers: "97",
                                    ),
                                    VerticalDivider(
                                      thickness: Sizes.size1, // 구분선의 굵기
                                      width: Sizes.size32, // 사이 공간의 크기
                                      indent: Sizes.size14,
                                      endIndent: Sizes.size14,
                                      color: Colors.grey.shade300,
                                    ),
                                    const UserAccount(
                                      category: "Followers",
                                      numbers: "10.2M",
                                    ),
                                    VerticalDivider(
                                      thickness: Sizes.size1,
                                      width: Sizes.size32,
                                      indent: Sizes.size14,
                                      endIndent: Sizes.size14,
                                      color: Colors.grey.shade300,
                                    ),
                                    const UserAccount(
                                      category: "Likes",
                                      numbers: "158.7M",
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.v14,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: FractionallySizedBox(
                                      widthFactor: 1,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: Sizes.size12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            Sizes.size2,
                                          ),
                                        ),
                                        child: const Text(
                                          "Follow",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gaps.h3,
                                  Flexible(
                                    child: FractionallySizedBox(
                                      widthFactor: 0.3,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: Sizes.size12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isDarkMode(context)
                                              ? Colors.grey.shade600
                                              : Colors.white,
                                          border: Border.all(
                                            width: Sizes.size1,
                                            color: isDarkMode(context)
                                                ? Colors.grey.shade400
                                                : Colors.grey.shade300,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            Sizes.size2,
                                          ),
                                        ),
                                        child: const FaIcon(
                                          FontAwesomeIcons.youtube,
                                          size: Sizes.size18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gaps.h3,
                                  Flexible(
                                    child: FractionallySizedBox(
                                      widthFactor: 0.3,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: Sizes.size14,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isDarkMode(context)
                                              ? Colors.grey.shade600
                                              : Colors.white,
                                          border: Border.all(
                                            width: Sizes.size1,
                                            color: isDarkMode(context)
                                                ? Colors.grey.shade400
                                                : Colors.grey.shade300,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            Sizes.size2,
                                          ),
                                        ),
                                        child: const FaIcon(
                                          FontAwesomeIcons.chevronDown,
                                          size: Sizes.size14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gaps.v14,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size32,
                                ),
                                child:
                                    Text(textAlign: TextAlign.center, data.bio),
                              ),
                              Gaps.v14,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.link,
                                    size: Sizes.size12,
                                  ),
                                  Gaps.h4,
                                  Text(
                                    data.link,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Gaps.v20,
                            ],
                            if (MediaQuery.of(context).size.width >=
                                Breakpoints.lg) ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 70,
                                        foregroundImage: AssetImage(
                                            "assets/images/gnarprofile.jpg"),
                                        child: Text("GNAR"),
                                      ),
                                      Gaps.v16,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "@gnarthecat",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: Sizes.size18,
                                            ),
                                          ),
                                          Gaps.h5,
                                          FaIcon(
                                            FontAwesomeIcons.solidCircleCheck,
                                            size: Sizes.size16,
                                            color: Colors.lightBlue,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Gaps.h40,
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Gaps.v20,
                                      SizedBox(
                                        height: Sizes.size48,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const UserAccount(
                                              category: "Following",
                                              numbers: "97",
                                            ),
                                            VerticalDivider(
                                              thickness: Sizes.size1, // 구분선의 굵기
                                              width: Sizes.size32, // 사이 공간의 크기
                                              indent: Sizes.size14,
                                              endIndent: Sizes.size14,
                                              color: Colors.grey.shade300,
                                            ),
                                            const UserAccount(
                                              category: "Followers",
                                              numbers: "10.2M",
                                            ),
                                            VerticalDivider(
                                              thickness: Sizes.size1,
                                              width: Sizes.size32,
                                              indent: Sizes.size14,
                                              endIndent: Sizes.size14,
                                              color: Colors.grey.shade300,
                                            ),
                                            const UserAccount(
                                              category: "Likes",
                                              numbers: "158.7M",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Gaps.v32,
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: Breakpoints.md,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: FractionallySizedBox(
                                        widthFactor: 1,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: Sizes.size12,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(
                                              Sizes.size2,
                                            ),
                                          ),
                                          child: const Text(
                                            "Follow",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gaps.h3,
                                    Flexible(
                                      child: FractionallySizedBox(
                                        widthFactor: 0.3,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: Sizes.size10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: Sizes.size1,
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              Sizes.size2,
                                            ),
                                          ),
                                          child: const FaIcon(
                                            FontAwesomeIcons.youtube,
                                            size: Sizes.size18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gaps.h3,
                                    Flexible(
                                      child: FractionallySizedBox(
                                        widthFactor: 0.3,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: Sizes.size12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              width: Sizes.size1,
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              Sizes.size2,
                                            ),
                                          ),
                                          child: const FaIcon(
                                            FontAwesomeIcons.chevronDown,
                                            size: Sizes.size14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gaps.v24,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size32,
                                ),
                                child:
                                    Text(textAlign: TextAlign.center, data.bio),
                              ),
                              Gaps.v14,
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.link,
                                    size: Sizes.size12,
                                  ),
                                  Gaps.h4,
                                  Text(
                                    "https://www.instagram.com/gnar.zip",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Gaps.v28,
                            ]
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: PersistentTabBar(),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.zero,
                        itemCount: 20,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width < Breakpoints.lg
                                  ? 3
                                  : 5,
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size2,
                          childAspectRatio: 9 / 14,
                        ),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 9 / 14,
                                  child: FadeInImage.assetNetwork(
                                      fit: BoxFit.cover,
                                      placeholderFit: BoxFit.cover,
                                      placeholder:
                                          "assets/images/discover_1.jpg",
                                      image:
                                          "https://images.pexels.com/photos/20825371/pexels-photo-20825371.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                                ),
                                const Positioned(
                                    left: Sizes.size4,
                                    bottom: Sizes.size2,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.play,
                                          color: Colors.white,
                                          size: Sizes.size12,
                                        ),
                                        Gaps.h4,
                                        Text(
                                          "4.1M",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Sizes.size12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text("page two"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
