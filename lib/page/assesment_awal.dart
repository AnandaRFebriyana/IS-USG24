import 'package:flutter/material.dart';
import 'package:mobileapp/page/detail_assesment.dart';

class Assesment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Assesment Awal',
          style: TextStyle(
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
            // List of assessments
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Example count of items
                itemBuilder: (context, index) {
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
                            'assets/domba.png', // Add your sheep icon here
                            width: 30,
                            height: 30,
                          ),
                        ),
                        title: Text(
                          'ID Assesment RD00118052024',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('ID Domba D00118052024'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          // Navigate to DetailAssesmentAwal page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailAssesmentAwal(),
                            ),
                          );
                        },
                      ),
                    ),
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