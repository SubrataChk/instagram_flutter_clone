import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter_clone/src/utils/color.dart';

OutlineInputBorder borderSide = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.black));

class SearchSection extends StatefulWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  TextEditingController searchController = TextEditingController();
  bool isshowUser = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Padding(
          padding: EdgeInsets.all(3),
          child: TextFormField(
            controller: searchController,
            onFieldSubmitted: (String _) {
              setState(() {
                isshowUser = true;
              });
            },
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
                hintText: "Search",
                contentPadding: EdgeInsets.all(15),
                border: borderSide,
                focusedBorder: borderSide,
                enabledBorder: borderSide),
          ),
        ),
      ),
      body: isshowUser
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("users")
                  .where("username",
                      isGreaterThanOrEqualTo: searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ["photoUrl"]),
                        ),
                        title: Text((snapshot.data! as dynamic).docs[index]
                            ["username"]),
                      );
                    });
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection("posts").get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GridView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return Image.network(
                        (snapshot.data! as dynamic).docs[index]["postUrl"],
                        fit: BoxFit.cover,
                      );
                    });
              }),
    );
  }
}
