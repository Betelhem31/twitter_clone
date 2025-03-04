import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/pages/create_tweet.dart';
import 'package:twitter_clone/pages/settings.dart';
import 'package:twitter_clone/provider/tweet_provider.dart';
import 'package:twitter_clone/provider/user_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalUser currentUser = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage:
                    AssetImage(ref.watch(userProvider).user.profilePicture),
              ),
            ),
          );
        }),
      ),
      body: ref.watch(feedProvider).when(
          data: (List<Tweet> tweets) {
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                itemCount: tweets.length,
                itemBuilder: (context, count) {
                  return ListTile(
                    leading: CircleAvatar(
                      foregroundImage: AssetImage(tweets[count].profilePic),
                    ),
                    title: Text(tweets[count].name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      tweets[count].tweet,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  );
                });
          },
          error: (error, stackTrace) => Text("Error"),
          loading: () {
            return CircularProgressIndicator();
          }),
      drawer: Drawer(
        child: Column(
          children: [
            Image.asset(currentUser.user.profilePicture),
            ListTile(
              title: Text(
                "Hello, ${currentUser.user.name}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            ListTile(
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
            ListTile(
              title: Text("Sign Out"),
              onTap: () {
                FirebaseAuth.instance.signOut();
                ref.read(userProvider.notifier).logout();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateTweet()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
