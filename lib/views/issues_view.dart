import 'package:dosra_ghar/models/user.dart';
import 'package:dosra_ghar/providers/issue_provider.dart';
import 'package:dosra_ghar/providers/user_provider.dart';
import 'package:dosra_ghar/views/addComplain.dart';
import 'package:dosra_ghar/widgets/issue_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

class IssueListScreen extends StatefulWidget {
  const IssueListScreen({super.key});

  @override
  State<IssueListScreen> createState() => _IssueListScreenState();
}

class _IssueListScreenState extends State<IssueListScreen> {
  @override
  void initState() {
    super.initState();
    final issueProvider = Provider.of<IssueProvider>(context, listen: false);
    issueProvider.fetchDataOnInitialization(context);
  }

  @override
  Widget build(BuildContext context) {
    final issueProvider = Provider.of<IssueProvider>(context);
    final UserProvider user = Provider.of<UserProvider>(context, listen: true);
    UserModel? currentUser = user.user;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (currentUser!.accountType == "student") {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AddComplain()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("This option is only valid for a student!")));
              }
            },
            icon: const Icon(Icons.domain_add,
                size: 28, color: Colors.white), // White icon for visibility
          ),
        ],
        title: Text(
          'My Issues',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.white, // White text for visibility
          ),
        ),
        backgroundColor: Colors.black, // Black background
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: issueProvider.loading
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 3, // Adjust for number of loading cards
                itemBuilder: (context, index) => const ShimmerLoadingCard(),
              ),
            )
          : issueProvider.issues.isEmpty
              ? const Center(
                  child: Text(
                    'No issues found.',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white), // White text for visibility
                  ),
                )
              : ListView.builder(
                  itemCount: issueProvider.issues.length,
                  itemBuilder: (context, index) {
                    final issue = issueProvider.issues[index];
                    return IssueCard(issue: issue);
                  },
                ),
    );
  }
}

class ShimmerLoadingCard extends StatelessWidget {
  const ShimmerLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        color: Colors.grey[900], // Darker color for card background
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!
              .withOpacity(0.5), // Lighter base color with reduced opacity
          highlightColor: Colors.grey[400]!
              .withOpacity(0.5), // Lighter highlight color with reduced opacity
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title placeholder
                Container(
                  height: 24.0,
                  color: Colors.grey[600]!
                      .withOpacity(0.5), // Darker grey with reduced opacity
                  width: double.infinity,
                ),
                const SizedBox(height: 20),
                // Row with placeholders for room and status
                Row(
                  children: [
                    Container(
                      height: 16.0,
                      width: 100.0,
                      color: Colors.grey[600]!
                          .withOpacity(0.5), // Darker grey with reduced opacity
                    ),
                    const Spacer(),
                    Container(
                      height: 16.0,
                      width: 80.0,
                      color: Colors.grey[600]!
                          .withOpacity(0.5), // Darker grey with reduced opacity
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                // Row with placeholders for date and time labels
                Row(
                  children: [
                    Container(
                      height: 16.0,
                      width: 50.0, // Adjust width as needed
                      color: Colors.grey[600]!
                          .withOpacity(0.5), // Darker grey with reduced opacity
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      height: 16.0,
                      width: 80.0, // Adjust width as needed
                      color: Colors.grey[600]!
                          .withOpacity(0.5), // Darker grey with reduced opacity
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                // Placeholder for additional content section (adjust height as needed)
                Container(
                  height: 16.0,
                  color: Colors.grey[600]!
                      .withOpacity(0.5), // Darker grey with reduced opacity
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
