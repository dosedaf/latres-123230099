import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/character_controller.dart';
import '../controllers/auth_controller.dart';
import 'detail_character_view.dart';
import 'spells_view.dart';

class CharacterView extends StatelessWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    final CharacterController charController = Get.put(CharacterController());
    final AuthController authController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter Characters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Obx(() {
        if (charController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: charController.characterList.length,
          itemBuilder: (context, index) {
            var character = charController.characterList[index];
            return ListTile(
              leading: character['image'] != null && character['image'] != ""
                  ? Image.network(
                      character['image'],
                      width: 50,
                      errorBuilder: (c, o, s) => const Icon(Icons.person),
                    )
                  : const Icon(Icons.person),
              title: Text(character['fullName'] ?? 'Unknown'),
              subtitle: Text(character['hogwartsHouse'] ?? 'No House'),
              onTap: () =>
                  Get.to(() => DetailCharacterView(character: character)),
            );
          },
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Characters',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Spells'),
        ],
        onTap: (index) {
          if (index == 1) Get.off(() => const SpellsView());
        },
      ),
    );
  }
}
