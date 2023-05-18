import 'package:chat_app_admin/widget/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final databaseRef = FirebaseDatabase.instance.ref("Post");
  final _add = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text("Add Post"),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _add,
              decoration: const InputDecoration(hintText: "Add"),
            ),
          ),
          const SizedBox(height: 20),
          RoundedButton(
              loading: false,
              title: "Add",
              onTap: () {
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                databaseRef.child(id).set({
                  'title': _add.text,
                  'id': id,
                });
              }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
