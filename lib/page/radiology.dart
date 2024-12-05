import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/services/radiologi_service.dart';
import 'package:mobileapp/models/radiologi_models.dart';

class Radiology extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Radiologi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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
              child: FutureBuilder<List<Radiologi>>(
                future: RadiologiService.getRadiologi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<Radiologi> radiologiList = snapshot.data!;
                    return ListView.builder(
                      itemCount: radiologiList.length,
                      itemBuilder: (context, index) {
                        Radiologi radiologi = radiologiList[index];
                        String formattesDate =
                            DateFormat('d MMMM yyyy, HH:mm:ss')
                                .format(DateTime.parse(radiologi.sheepCreated));
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: Icon(Icons.medical_services,
                                  color: Colors.blue),
                              title: Text(
                                '${radiologi.assesmentId} - ${radiologi.sheepName}', // assessment_id dan Nama Domba
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status: ${radiologi.pregnancyStatus}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: radiologi.pregnancyStatus
                                                  .toLowerCase() ==
                                              'Bun'
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  Text(
                                    '$formattesDate',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Get.toNamed('/detailradiology',
                                    arguments: radiologi);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('Tidak ada data radiologi.'));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
