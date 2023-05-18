import 'package:chat_app_admin/post/add_post.dart';
import 'package:chat_app_admin/screens/auth/login.dart';
import 'package:chat_app_admin/utils/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widget/round_button.dart';

class HomePage extends StatefulWidget {
  final String? title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  final ref = FirebaseDatabase.instance.ref('Post');
  final _auth = FirebaseAuth.instance;
  final _filter = TextEditingController();
  final _edited = TextEditingController();
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Home'),
        actions: [
          IconButton(
              onPressed: () async {
                // GoogleSignIn().signOut();
                // FirebaseAuth.instance.signOut();

                _auth.signOut().then(
                      (value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogINPage(),
                        ),
                      ),
                    );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPostScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const Center(
            child: Text("Home Page"),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: _filter,
              decoration: const InputDecoration(hintText: "search"),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Text("data"),
                itemBuilder: (context, snapshot, animation, index) {
                  //
                  final title = snapshot.child("title").value.toString();
                  if (_filter.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child("title").value.toString()),
                      subtitle: Text(snapshot.child("id").value.toString()),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  showMyDialog(title,
                                      snapshot.child("id").value.toString());
                                },
                                title: Text('Editing'),
                                leading: Icon(Icons.edit),
                              )),
                          PopupMenuItem(
                              onTap: () {
                                ref
                                    .child(
                                        snapshot.child('id').value.toString())
                                    .remove();
                              },
                              value: 1,
                              child: const ListTile(
                                title: Text('Delete'),
                                leading: Icon(Icons.delete),
                              )),
                        ],
                      ),
                    );
                  } else if (_filter.text
                      .toLowerCase()
                      .contains(title.toLowerCase().toString())) {
                    return ListTile(
                      title: Text(snapshot.child("title").value.toString()),
                      subtitle: Text(snapshot.child("id").value.toString()),
                    );
                  } else {
                    return Container();
                  }
                  //
                }),
          ),
          const SizedBox(height: 20),
          const Text("Stream"),
          const SizedBox(height: 20),
          // Expanded(
          //     child: StreamBuilder(
          //   stream: ref.onValue,
          //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //     if (!snapshot.hasData) {
          //       return const Center(child: CircularProgressIndicator());
          //     } else {
          //       Map<dynamic, dynamic> map =
          //           snapshot.data!.snapshot.value as dynamic;
          //       List<dynamic> list = [];
          //       list.clear();
          //       list = map.values.toList();
          //       return ListView.builder(
          //           itemCount: snapshot.data!.snapshot.children.length,
          //           itemBuilder: (context, intex) {
          //             return ListTile(
          //               title: Text(list[intex]['title']),
          //               subtitle: Text(list[intex]['id']),
          //             );
          //           });
          //     }
          //   },
          // ))
        ],
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    _edited.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Update"),
            content: Container(
                child: TextField(
              controller: _edited,
              decoration: const InputDecoration(hintText: "Edit here"),
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(id).update(
                        {'title': _edited.text.toLowerCase()}).then((value) {
                      Utils().snackBar("Update", context);
                    }).onError((error, stackTrace) {
                      Utils().snackBar(error.toString(), context);
                    });
                  },
                  child: const Text("Update")),
            ],
          );
        });
  }
}
