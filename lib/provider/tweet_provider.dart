import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/provider/user_provider.dart';
//so whenever twwets added it gets automatically display on our screen
final feedProvider = StreamProvider.autoDispose<List<Tweet>>((ref) {
  return FirebaseFirestore.instance
      .collection("tweets")
      .orderBy('postTime', descending: true)
      .snapshots()
      .map((event) {
    List<Tweet> tweets = [];
    //data manipulation
    for (int i = 0; i < event.docs.length; i++) {
      tweets.add(Tweet.fromMap(event.docs[i].data()));
    }
    return tweets;
  });
});

final tweetProvider = Provider<TwitterApi>((ref) {
  return TwitterApi(ref);
});

//it provides some function to the rest of our applications
class TwitterApi {
  TwitterApi(this.ref);
  final Ref ref;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postTweet(String tweet) async {
    LocalUser currentUser = ref.read(userProvider);
    await _firestore.collection("tweets").add(Tweet(
          uid: currentUser.id,
          profilePic: currentUser.user.profilePicture,
          name: currentUser.user.name,
          tweet: tweet,
          postTime: Timestamp.now(),
        ).toMap());
  }
}
//tweet here is ajob and firestore takes maps??????? that where we add toMap at the end
