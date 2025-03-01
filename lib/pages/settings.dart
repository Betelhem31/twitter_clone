import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/provider/user_provider.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    LocalUser currentUser = ref.watch(userProvider);
    _nameController.text = currentUser.user.name;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? pickedImage = await picker.pickImage(
                    source: ImageSource.gallery, requestFullMetadata: false);
                if (pickedImage != null) {
                  ref
                      .read(userProvider.notifier)
                      .updateImage(File(pickedImage.path));
                }
              },
              child: CircleAvatar(
                radius: 100,
                foregroundImage: AssetImage(currentUser.user.profilePicture),
              ),
            ),
            SizedBox(height: 10),
            Center(child: Text("Tap the image to change")),
            TextFormField(
              decoration: InputDecoration(labelText: "Your name"),
              controller: _nameController,
            ),
            TextButton(
                onPressed: () {
                  ref
                      .read(userProvider.notifier)
                      .updateName(_nameController.text);
                },
                child: Text("Update"))
          ],
        ),
      ),
    );
  }
}
