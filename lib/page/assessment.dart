import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/models/assesment_models.dart';
import 'package:mobileapp/services/assesment_service.dart';

class Assesment extends StatefulWidget {
  @override
  _AssesmentState createState() => _AssesmentState();
}

class _AssesmentState extends State<Assesment> {
  late Future<List<Assessment>> _futureAssessments;

  @override
  void initState() {
    super.initState();
    // Memulai pengambilan data assessment
    _futureAssessments = AssessmentService().getAssessments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Pemeriksaan Awal',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Assessment>>(
                future: _futureAssessments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No assessments available.'));
                  }
                  final assessments = snapshot.data!;
                  return ListView.builder(
                    itemCount: assessments.length,
                    itemBuilder: (context, index) {
                      final assessment = assessments[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.orange[100],
                              child: Image.asset(
                                'assets/domba.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            title: Text(
                              'ID Assesment ${assessment.id}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('ID Domba ${assessment.sheepId}'),
                            trailing: Icon(Icons.chevron_right),
                            onTap: () {
                              Get.toNamed('/detail-ass',
                                    arguments: assessment);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
