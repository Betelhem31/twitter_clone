// ignore_for_file: public_member_api_docs, sort_constructors_first
//we use statenotifier to add functions to the states like signin and to give the state whenever it is needed
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/user.dart';

final userProvider = StateNotifierProvider<UserNotifier, LocalUser>((ref) {
  return UserNotifier();
});

//data type
class LocalUser {
  final String id;
  final FirebaseUser user;

  LocalUser({
    required this.id,
    required this.user,
  });

  LocalUser copyWith({
    String? id,
    FirebaseUser? user,
  }) {
    return LocalUser(
      id: id ?? this.id,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
    };
  }

  factory LocalUser.fromMap(Map<String, dynamic> map) {
    return LocalUser(
      id: map['id'] as String,
      user: FirebaseUser.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalUser.fromJson(String source) =>
      LocalUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LocalUser(id: $id, user: $user)';

  @override
  bool operator ==(covariant LocalUser other) {
    if (identical(this, other)) return true;

    return other.id == id && other.user == user;
  }

  @override
  int get hashCode => id.hashCode ^ user.hashCode;
}

class UserNotifier extends StateNotifier<LocalUser> {
  UserNotifier()
      : super(LocalUser(
            id: "error",
            user: FirebaseUser(
                email: 'error',
                name: 'error',
                profilePicture: 'assets/twitter.png'))) {}

  //so when ever user creats an account we get authentication and te database added so for that we need to acess firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  //so ow we start to implement all the futures
  Future<void> signUP(String email) async {
    //add function returns DocumentRefernce type
    DocumentReference response = await _firestore.collection("users").add(
        FirebaseUser(
                email: email,
                name: 'No Name',
                profilePicture: 'assets/twitter.png')
            .toMap()

        //we need a data class to make sure we pas the right data
        );
    DocumentSnapshot snapshot = await response.get();

    //now we set our state

    state = LocalUser(
        id: response.id,
        user: FirebaseUser.fromMap(snapshot.data() as Map<String, dynamic>));
  }

  //here login should be named retriveuserinformation instade of login because we are not doing any login here cuz autentication is takingcare of that here we just get that information also sinup -- adduserto the data
  Future<void> login(String email) async {
    //add function returns DocumentRefernce type
    QuerySnapshot response = await _firestore
        .collection("users")
        .where('email', isEqualTo: email)
        .get();
    if (response.docs.isEmpty) {
      print("No firestore user associated to autenticated email $email");
      return;
    }
    if (response.docs.length != 1) {
      print("No firestore user associated with email $email");
      return;
    }

    state = LocalUser(
        id: response.docs[0].id,
        user: FirebaseUser.fromMap(
            response.docs[0].data() as Map<String, dynamic>));
  }

  Future<void> updateName(String name) async {
    await _firestore.collection("users").doc(state.id).update({'name': name});
    state = state.copyWith(user: state.user.copyWith(name: name));
  }

  Future<void> updateImage(File image) async {
    Reference ref = _storage.ref().child("users").child(state.id);
    TaskSnapshot snapshot = await ref.putFile(image);
    String profilePicUrl = await snapshot.ref.getDownloadURL();
    await _firestore
        .collection("users")
        .doc(state.id)
        .update({'profilePicture': profilePicUrl});
    state = state.copyWith(user: state.user.copyWith(profilePicture: profilePicUrl));
  }

  void logout() {
    state = LocalUser(
        id: "error",
        user: FirebaseUser(
            email: 'error',
            name: 'error',
            profilePicture: 'assets/twitter.png'));
  }
}
