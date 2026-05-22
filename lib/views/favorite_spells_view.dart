import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/spell_controller.dart';

class FavoriteSpellsView extends StatelessWidget {
  const FavoriteSpellsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SpellController spellController = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Spells')),
      body: Obx(() {
        if (spellController.favoriteSpells.isEmpty) {
          return const Center(child: Text('Belum ada spell favorit.'));
        }
        return ListView.builder(
          itemCount: spellController.favoriteSpells.length,
          itemBuilder: (context, index) {
            var spell = spellController.favoriteSpells[index];
            return ListTile(
              title: Text(spell['spell'] ?? ''),
              subtitle: Text(spell['use'] ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  spellController.removeFavoriteWithNotification(spell);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
