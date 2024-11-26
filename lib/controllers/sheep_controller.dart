import 'package:get/get.dart';
import 'package:mobileapp/models/sheep_models.dart';

class SheepController extends GetxController {
  var sheepList = <Sheep>[].obs;
  var filteredList = <Sheep>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  // Menambahkan domba baru
  void addSheep(String id, String sheepName, String sheepBirth, String sheepGender) {
    var newSheep = Sheep(
      id: id,
      sheepName: sheepName,
      sheepBirth: sheepBirth,
      sheepGender: sheepGender,
      sheepPhoto: 'assets/images/default_sheep.png',
    );

    sheepList.add(newSheep);
    filteredList.assignAll(sheepList);
  }

  // Filtering data domba berdasarkan ID
  void filterSheep(String query) {
    if (query.isEmpty) {
      filteredList.assignAll(sheepList);
    } else {
      filteredList.assignAll(
        sheepList.where((sheep) => sheep.id.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }
}