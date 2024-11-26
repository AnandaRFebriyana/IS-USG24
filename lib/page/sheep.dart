import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/controllers/sheep_controller.dart';
import 'package:mobileapp/models/sheep_models.dart';
import 'package:mobileapp/services/sheep_service.dart';

class SheepPage extends StatefulWidget {
  @override
  _SheepPageState createState() => _SheepPageState();
}

class _SheepPageState extends State<SheepPage> {
  final SheepController sheepController = Get.put(SheepController());
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Data Domba',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () => Get.toNamed('/sheep-form'),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                // sheepController.filterSheep(value);
              },
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search by domba ID",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Sheep>>(
              future: SheepService.getSheep(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<Sheep> sheepList = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      itemCount: sheepList.length,
                      itemBuilder: (context, index) {
                        Sheep sheep = sheepList[index];
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
                                sheep.id,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(sheep.sheepName),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                Get.toNamed('/detail-sheep', arguments: sheep);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: Text('Tidak ada data domba.'));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
