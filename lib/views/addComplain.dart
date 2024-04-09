import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dosra_ghar/models/user.dart';
import 'package:dosra_ghar/providers/user_provider.dart';
import 'package:dosra_ghar/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddComplain extends StatefulWidget {
  const AddComplain({super.key});

  @override
  State<AddComplain> createState() => _AddComplainState();
}

List<String> issueTypes = [
  'Mess Food',
  'Water Cooler',
  'House Keeping',
  'Carpenter',
  'Plumbing',
      'Electrical',
  'Mosquito Fogging',
  'Hostel gardening',
  'AC',
      'Wifi-Issues',
  'Others',
];

class _AddComplainState extends State<AddComplain> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  bool loading = false;

  String selectedIssueType = issueTypes[0];
  @override
  Widget build(BuildContext context) {
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);
    UserModel? currentUser = user.user;
    titleController.text = selectedIssueType;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            "Create issue",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white
              ),
                alignment: Alignment.center,
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 25,),
                        SizedBox(
                          width: 300,
                          child: DropdownButtonFormField<String>(
                            borderRadius: BorderRadius.circular(18),
                            value: selectedIssueType,
                            items: issueTypes
                                .map((issueType) => DropdownMenuItem<String>(
                                      value: issueType,
                                      child: Text(
                                        issueType,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight
                                                .bold), // Set text color to white
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) => setState(() {
                              selectedIssueType = value!;
                              titleController.text = selectedIssueType;
                            }),
                            decoration: const InputDecoration(
                              labelText: 'Issue Type',
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                  color: Colors
                                      .black), // Set label color to white with some opacity
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(80, 8, 80, 8),
                          child: TextFormField(
                              
                              decoration: InputDecoration(
                                  hintText: "Room no.",
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: const Icon(Icons.home_outlined, 
                                  size: 35,
                                  color: Colors.black,)),
                              controller: roomController,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter your room number';
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                          child: TextFormField(           
                              decoration: InputDecoration(
                                  hintText: "Description",
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: const Icon(Icons.description,
                                  size: 30,
                                   color: Colors.black,)),
                              controller: desController,
                              keyboardType: TextInputType.text,
                              obscureText: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter description';
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(height: 25,)
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 20,
                fixedSize: const Size(160, 50),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  foregroundColor: Colors.black,
                  side: const BorderSide(
                    width: 4,
                      color: Color.fromARGB(255, 174, 125, 222))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  createComplain(currentUser!.hostelBlock);
                }
              },
              child: Text("Add complain",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void createComplain(String? hostelBlock) {
    final title = titleController.text.toString();
    final description = desController.text.toString();
    final room = roomController.text.toString();
    DateTime currentDate = DateTime.now();
    setState(() {
      loading = true;
    });

    FirebaseFirestore.instance
        .collection('complaints')
        .doc(currentDate.toString())
        .set({
      'room': room,
      'title': title,
      'hostel-block': hostelBlock,
      'description': description,
      'date': currentDate.toString(),
      'status': "Pending"
    }).then((value) {
      Utils.snackBar('Complain added successfully', context);
      setState(() {
        loading = false;
      });
      _formKey.currentState!.reset();
      titleController.clear();
      desController.clear();
      //  Navigator.pop(context);
      // Navigator.pushNamed(context, RoutesName.post, arguments: 2);
    }).catchError((error) {
      setState(() {
        loading = false;
      });
      Utils.snackBar('Failed to add complain: $error', context);
    });
  }
}
