import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/views/announce.dart';
import 'package:dosra_ghar/widgets/annoucement_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LostScreen extends StatefulWidget {
  const LostScreen({super.key});

  @override
  _LostScreenState createState() => _LostScreenState();
}

class _LostScreenState extends State<LostScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Lost Items", style: GoogleFonts.poppins(),),
        actions: [
          IconButton(onPressed: (){

          }, 
          icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: h / 50),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  
                 
                  SizedBox(
                      height: h / 1.36,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('lostitems')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }

                                  if (!snapshot.hasData) {
                                    return Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        child: Center(
                                            child: SpinKitFadingCube(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                size: 100.0)));
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
