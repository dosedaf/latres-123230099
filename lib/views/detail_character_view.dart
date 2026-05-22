import 'package:flutter/material.dart';

class DetailCharacterView extends StatelessWidget {
  final dynamic character;
  const DetailCharacterView({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character['fullName'] ?? 'Detail')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (character['image'] != null && character['image'] != "")
                Center(child: Image.network(character['image'], height: 250)),
              const SizedBox(height: 20),

              Text(
                "Nama: ${character['fullName'] ?? '-'}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Nickname: ${character['nickname'] ?? '-'}"),
              Text("House: ${character['hogwartsHouse'] ?? '-'}"),
              Text("Aktor: ${character['interpretedBy'] ?? '-'}"),
              Text("Tanggal Lahir: ${character['birthdate'] ?? '-'}"),

              const SizedBox(height: 10),
              const Text(
                "Anak:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              if (character['children'] != null &&
                  character['children'].isNotEmpty)
                ...List<Widget>.from(
                  character['children'].map((child) => Text("- $child")),
                )
              else
                const Text("- Tidak ada data anak"),
            ],
          ),
        ),
      ),
    );
  }
}
