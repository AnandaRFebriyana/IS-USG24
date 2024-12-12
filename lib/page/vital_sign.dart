import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/models/chart_models.dart';
import 'package:mobileapp/services/vital_sign_service.dart';
import 'package:mobileapp/models/vital_sign_models.dart';

class VitalSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Vital Sign',
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
              child: FutureBuilder<List<VitalSigns>>(
                future: VitalSignsService.getVitalSigns(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<VitalSigns> vitalSignsList = snapshot.data!;
                    return ListView.builder(
                      itemCount: vitalSignsList.length,
                      itemBuilder: (context, index) {
                        VitalSigns vitalSign = vitalSignsList[index];
                        String formattedDate =
                            DateFormat('d MMMM yyyy, HH:mm:ss')
                                .format(vitalSign.createdAt);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading:
                                  Icon(Icons.monitor_heart, color: Colors.red),
                              title: Text(
                                '${vitalSign.sheepId} - ${vitalSign.sheepName}', // Nama Domba
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status: ${vitalSign.statusCondition}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: vitalSign.statusCondition .toLowerCase() == 'sehat'
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.show_chart,
                                  color: Colors.deepOrange,
                                ),
                                onPressed: () {
                                  List<ChartData> chartData = vitalSignsList.map((vitalSign) {
                                    return ChartData(
                                      createdAt: vitalSign.createdAt,
                                      temperature: vitalSign.temperature,
                                      heartRate: vitalSign.heartRate,
                                      respiratoryRate: vitalSign.respiratoryRate,
                                      weight: vitalSign.weight,
                                    );
                                  }).toList();
                                  print('Tombol grafik ditekan');
                                  Get.toNamed('/grafik-vitalsign',
                                      arguments: chartData);
                                },
                              ),
                              onTap: () {
                                Get.toNamed('/detail-vitalsign', arguments: vitalSign);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('Tidak ada data vital signs.'));
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