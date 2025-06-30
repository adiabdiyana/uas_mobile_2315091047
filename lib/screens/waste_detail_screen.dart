import 'package:flutter/material.dart';
import 'package:uas_mobile_2315091047/screens/search_waste_screen.dart';

class WasteDetailScreen extends StatelessWidget {
  final WasteItem wasteItem;

  const WasteDetailScreen({super.key, required this.wasteItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(wasteItem.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: _getCategoryColor(wasteItem.category).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  wasteItem.imagePath,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.recycling,
                    size: 60,
                    color: _getCategoryColor(wasteItem.category),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Chip(
                  label: Text(wasteItem.category),
                  backgroundColor: _getCategoryColor(wasteItem.category).withOpacity(0.2),
                  labelStyle: TextStyle(
                    color: _getCategoryColor(wasteItem.category),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              wasteItem.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Panduan Memilah:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              wasteItem.sortingGuide.replaceAll('\n', '\n• '),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Tempat Pembuangan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              wasteItem.disposalLocation,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Fakta Menarik:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _getFunFact(wasteItem.category),
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Plastik':
        return Colors.blue;
      case 'Kertas':
        return Colors.orange;
      case 'Logam':
        return Colors.grey;
      case 'Organik':
        return Colors.brown;
      case 'Kaca':
        return Colors.green;
      case 'B3':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getFunFact(String category) {
    switch (category) {
      case 'Plastik':
        return 'Botol PET bisa didaur ulang menjadi serat kain polyester untuk pakaian.';
      case 'Kertas':
        return '1 ton kertas daur ulang menyelamatkan 17 pohon dewasa.';
      case 'Logam':
        return 'Aluminium bisa didaur ulang tanpa batas tanpa kehilangan kualitas.';
      case 'Organik':
        return 'Kompos dari sampah organik bisa menyuburkan tanah secara alami.';
      case 'Kaca':
        return 'Kaca daur ulang meleleh pada suhu lebih rendah daripada bahan baku baru.';
      case 'B3':
        return '1 baterai AA bisa mencemari 1 m³ tanah selama 50 tahun.';
      default:
        return 'Daur ulang membantu mengurangi emisi karbon dioksida.';
    }
  }
}