// import 'package:get/get.dart';
// import 'package:mobileapp/models/sheep_models.dart';
// import '../services/sheep_service.dart';

// class SheepController extends GetxController {
//   var sheepList = <Sheep>[].obs;
//   var filteredList = <Sheep>[].obs;
//   var isLoading = true.obs;
//   var hasError = false.obs;
//   var errorMessage = ''.obs;
//   final SheepService sheepService = SheepService();

//   @override
//   void onInit() {
//     fetchSheep();
//     super.onInit();
//   }

//   void fetchSheep() async {
//     try {
//       isLoading(true);
//       hasError(false);
//       errorMessage('');
//       var sheep = await sheepService.fetchSheep();
//       sheepList.assignAll(sheep);
//       filteredList.assignAll(sheep);
//     } catch (e) {
//       hasError(true);
//       errorMessage(e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }

//   void filterSheep(String query) {
//     if (query.isNotEmpty) {
//       var filtered = sheepList.where((sheep) => sheep.idDomba.toLowerCase().contains(query.toLowerCase())).toList();
//       filteredList.assignAll(filtered);
//     } else {
//       filteredList.assignAll(sheepList);
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:mobileapp/models/sheep_models.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/services/sheep_service.dart';

class SheepController extends GetxController {
  var sheepList = <Sheep>[].obs;
  var filteredList = <Sheep>[].obs;

  @override
  void onInit() {
    fetchSheep();
    super.onInit();
  }

  // Fetching data domba (dummy)
  Future<void> fetchSheep() async {
    var sheepData = await SheepService().fetchSheep();
    sheepList.assignAll(sheepData);
    filteredList.assignAll(sheepData);
  }

  // Menambahkan domba baru
  void addSheep(String idDomba, String namaDomba, String tanggalLahir, String umur, String jenisDomba) {
    var newSheep = Sheep(
      idDomba: idDomba,
      namaDomba: namaDomba,
      tanggalLahir: tanggalLahir,
      jenisDomba: jenisDomba,
      image: 'assets/images/default_sheep.png', // default image
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
        sheepList.where((sheep) => sheep.idDomba.toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }
}
