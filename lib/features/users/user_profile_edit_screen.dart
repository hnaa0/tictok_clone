import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/view_models/users_vm.dart';

class UserProfileEditScreen extends ConsumerStatefulWidget {
  const UserProfileEditScreen({super.key});

  @override
  ConsumerState<UserProfileEditScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<UserProfileEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(userProvider.notifier).onProfileEdit(
            _formData["name"]!, _formData["bio"]!, _formData["link"]!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.read(userProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
            onPressed: _onSubmitTap,
            icon: const FaIcon(FontAwesomeIcons.floppyDisk),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size6,
          horizontal: Sizes.size16,
        ),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidUser,
                        size: Sizes.size16,
                      ),
                      Gaps.h6,
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: userProfile!.name,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        _formData["name"] = newValue;
                      }
                    },
                  ),
                  Gaps.v40,
                  const Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.pen,
                        size: Sizes.size16,
                      ),
                      Gaps.h6,
                      Text(
                        "Bio",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: userProfile.bio,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        _formData["bio"] = newValue;
                      }
                    },
                  ),
                  Gaps.v40,
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.link,
                        size: Sizes.size16,
                      ),
                      Gaps.h6,
                      Text(
                        "Link",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: userProfile.link,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        _formData["link"] = newValue;
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
