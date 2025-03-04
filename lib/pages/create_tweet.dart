import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/provider/tweet_provider.dart';

class CreateTweet extends ConsumerWidget {
  const CreateTweet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController tweetController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Post a Tweet"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 4,
                maxLength: 200,
                decoration: InputDecoration(border: OutlineInputBorder()),
                controller: tweetController,
              ),
            ),
            TextButton(
                onPressed: () {
                  ref.read(tweetProvider).postTweet(tweetController.text);
                  Navigator.pop(context);
                },
                child: Text("Post Tweet"))
          ],
        ),
      ),
    );
  }
}
