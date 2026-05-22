import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';

class SpellController extends GetxController {
  var isLoading = true.obs;
  var spellList = [].obs;
  var favoriteSpells = [].obs;
  final box = Hive.box('favorite_spells');

  @override
  void onInit() {
    fetchSpells();
    loadFavorites();
    super.onInit();
  }

  void fetchSpells() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('https://potterapi-fedeperin.vercel.app/en/spells'),
      );
      if (response.statusCode == 200) {
        spellList.value = json.decode(response.body);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void loadFavorites() {
    favoriteSpells.value = box.values.toList();
  }

  void toggleFavorite(dynamic spell) {
    String spellName = spell['spell'];
    if (box.containsKey(spellName)) {
      box.delete(spellName);
      Get.snackbar(
        'Removed',
        '$spellName dihapus dari favorit',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      box.put(spellName, spell);
      Get.snackbar(
        'Added',
        '$spellName ditambahkan ke favorit',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
    loadFavorites();
  }

  bool isFavorite(String spellName) {
    return box.containsKey(spellName);
  }

  void removeFavoriteWithNotification(dynamic spell) async {
    String spellName = spell['spell'];
    box.delete(spellName);
    loadFavorites();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'delete_channel_id',
          'Delete Notification',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Delete Notification',
      'You removed $spellName from your favorite',
      platformChannelSpecifics,
    );
  }
}
