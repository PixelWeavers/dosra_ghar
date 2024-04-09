import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/views/announce.dart';
import 'package:dosra_ghar/widgets/annoucement_card.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Announcement> {
  /* final user = FirebaseAuth.instance.currentUser;

  String? name = "";

  Future<String?> _fetchName() async {
    try {
      var userModel = await _userServices.getUserById(user!.uid);
      return userModel?.name;
    } catch (e) {
      // Handle the error here, e.g., log it or return a default value
      print('Error fetching name: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchName().then((data) {
      setState(() {
        name = data;
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Announcements",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: const Icon(
                color: Colors.white,
                Icons.add,
                size: 30,
              ),
              onPressed: () {
                // Perform search operation
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const CreateAnnouncementScreen()));
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: h / 100),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  SizedBox(
                      height: h / 1.36,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('announcements')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }

                                  if (!snapshot.hasData) {
                                    return Shimmer.fromColors(
                                        baseColor: const Color.fromARGB(
                                            255, 53, 53, 53),
                                        highlightColor: const Color.fromARGB(
                                            255, 114, 114, 114),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: h * 0.5,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                            )
                                          ],
                                        ));
                                  }

                                  // Data is available
                                  final announcementDocs = snapshot.data!.docs;

                                  if (announcementDocs.isEmpty) {
                                    return Center(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 70,
                                          ),
                                          Image.asset(
                                            'assets/images/aano.png',
                                            width: 270,
                                            height: 370,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    itemCount: announcementDocs.length,
                                    reverse: false,
                                    itemBuilder: (context, index) {
                                      final announcement =
                                          announcementDocs[index].data()
                                              as Map<String, dynamic>?;
                                      final title =
                                          announcement?['title'] as String? ??
                                              "";
                                      final description =
                                          announcement?['description']
                                                  as String? ??
                                              "";
                                      final timestamp = announcement?['date'];
                                      final time = DateTime.parse(timestamp);

                                      return AnnouncementContainer(
                                        title: title,
                                        description: description,
                                        timestamp: time,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                          ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
