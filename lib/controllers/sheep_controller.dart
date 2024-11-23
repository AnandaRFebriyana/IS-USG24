import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/models/sheep_models.dart';
import 'package:mobileapp/services/constans.dart';

class SheepController extends GetxController {
  var sheepList = <Sheep>[].obs;
  var filteredList = <Sheep>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSheepList();
  }

  // Menambahkan domba baru
  Future<void> addSheep(String id, String sheepName, String sheepBirth, String sheepGender) async {
  // Ambil token dari shared preferences
  final token = await Constant.getToken();
  
  var newSheep = Sheep(
    id: id,
    sheepName: sheepName,
    sheepBirth: sheepBirth,
    sheepGender: sheepGender,
    sheepPhoto: 'assets/images/default_sheep.png',  // Ganti sesuai foto default yang ada
  );

  // Kirim data ke API untuk disimpan ke database
  final response = await http.post(
    Uri.parse(Constant.POST_SHEEP),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',  // Menambahkan header token
    },
    body: jsonEncode({
      'id': id,
      'sheep_name': sheepName,
      'sheep_birth': sheepBirth,
      'sheep_gender': sheepGender,
      // Jika ada field lain, pastikan ditambahkan di sini
    }),
  );

  // Cek response dari API
  if (response.statusCode == 200) {
  // Jika berhasil, periksa apakah API mengembalikan data atau status yang sesuai
  var responseBody = jsonDecode(response.body);
  if (responseBody['status'] == 'success') {
    sheepList.add(newSheep);
    filteredList.assignAll(sheepList);
  } else {
    print('Error from API: ${responseBody['message']}');
  }
} else {
  print('Failed to add sheep: ${response.body}');
}
}

  // Fetch daftar domba dari API
  Future<void> fetchSheepList() async {
    final response = await http.get(Uri.parse(Constant.GET_SHEEP));
    
    if (response.statusCode == 200) {
      // Parse response JSON dan perbarui list domba
      var data = jsonDecode(response.body);
      sheepList.assignAll(data.map<Sheep>((json) => Sheep.fromJson(json)).toList());
      filteredList.assignAll(sheepList);
    } else {
      print('Failed to fetch sheep list: ${response.body}');
    }
  }

   // Fetch ID domba otomatis dari API
  Future<String> getSheepIdFromApi() async {
    final response = await http.get(Uri.parse(Constant.GET_SHEEPBYID));
     // Sesuaikan URL endpoint
    
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['id']; // Pastikan format respons JSON dari API sesuai
    } else {
      print('Failed to fetch sheep ID: ${response.body}');
      return ''; // Jika gagal, kembalikan string kosong atau bisa tangani dengan error handling lain
    }
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