import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobileapp/page/addSheep.dart';
import '../controllers/sheep_controller.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
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
            onPressed: () {
              Get.to(() => AddSheepForm());
            },
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
                sheepController.filterSheep(value);
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
            child: Obx(() {
              if (sheepController.sheepList.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else {
                return RefreshIndicator(
                  onRefresh: sheepController.fetchSheep,
                  child: ListView.builder(
                    itemCount: sheepController.filteredList.length,
                    itemBuilder: (context, index) {
                      var sheep = sheepController.filteredList[index];
                      return Card(
                        elevation: 1,
                        color: Color.fromARGB(255, 252, 254, 255),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(sheep.image),
                          ),
                          title: Text(sheep.namaDomba),
                          subtitle: Text('ID: ${sheep.idDomba}\nJenis: ${sheep.jenisDomba}'),
                          onTap: () {
                            // Navigasi ke halaman detail domba
                            Get.toNamed('/detaildomba', arguments: {
                              'idDomba': sheep.idDomba,
                              'namaDomba': sheep.namaDomba,
                              'tanggalLahir': sheep.tanggalLahir,
                              'jenisDomba': sheep.jenisDomba,
                              'image': sheep.image,
                            });
                          },
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
