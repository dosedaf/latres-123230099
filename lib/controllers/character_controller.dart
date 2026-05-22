import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CharacterController extends GetxController {
  var isLoading = true.obs;
  var characterList = [].obs;

  @override
  void onInit() {
    fetchCharacters();
    super.onInit();
  }

  void fetchCharacters() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('https://potterapi-fedeperin.vercel.app/en/characters'),
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        characterList.value = jsonData;
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data: $e');
    } finally {
      isLoading(false);
    }
  }
}
