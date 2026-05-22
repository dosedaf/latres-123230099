import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/spell_controller.dart';
import '../controllers/auth_controller.dart';
import 'character_view.dart';
import 'favorite_spells_view.dart';

class SpellsView extends StatelessWidget {
  const SpellsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SpellController spellController = Get.put(SpellController());
    final AuthController authController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter Spells Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () => Get.to(() => const FavoriteSpellsView()),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Obx(() {
        if (spellController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: spellController.spellList.length,
          itemBuilder: (context, index) {
            var spell = spellController.spellList[index];
            String spellName = spell['spell'] ?? '';
            bool isFav = spellController.isFavorite(spellName);

            return ListTile(
              title: Text(spellName),
              subtitle: Text(spell['use'] ?? ''),
              trailing: IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : null,
                ),
                onPressed: () => spellController.toggleFavorite(spell),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Characters',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Spells'),
        ],
        onTap: (index) {
          if (index == 0) Get.off(() => const CharacterView());
        },
      ),
    );
  }
}
