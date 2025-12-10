// lib/models/medicine_model.dart
import 'package:flutter/material.dart';
class MedicineCategory {
  final String id;
  final String title;
  final Color color;
  final IconData icon;
  final String description;
  final List<String> examples;

  MedicineCategory({
    required this.id,
    required this.title,
    required this.color,
    required this.icon,
    required this.description,
    required this.examples,
  });
}

class MedicineTip {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  MedicineTip({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class MedicineFilter {
  final String id;
  final String label;
  final IconData? icon;

  MedicineFilter({
    required this.id,
    required this.label,
    this.icon,
  });
}

// Data dummy untuk inisialisasi
final List<MedicineCategory> medicineCategories = [
  MedicineCategory(
    id: 'obat_bebas',
    title: 'Obat Bebas',
    color: Colors.green,
    icon: Icons.check_circle_outline,
    description: 'Dapat dibeli tanpa resep dokter',
    examples: ['Paracetamol', 'Vitamin C', 'Obat Pusing'],
  ),
  MedicineCategory(
    id: 'obat_bebas_terbatas',
    title: 'Obat Bebas Terbatas',
    color: Colors.blue,
    icon: Icons.info_outline,
    description: 'Dengan tanda peringatan khusus',
    examples: ['CTM', 'Antasida', 'Dexametason'],
  ),
  MedicineCategory(
    id: 'obat_keras',
    title: 'Obat Keras',
    color: Colors.red,
    icon: Icons.warning_amber_outlined,
    description: 'Hanya dengan resep dokter',
    examples: ['Antibiotik', 'Insulin', 'Obat Hipertensi'],
  ),
  MedicineCategory(
    id: 'narkotika',
    title: 'Narkotika',
    color: Colors.purple,
    icon: Icons.health_and_safety_outlined,
    description: 'Penggunaan sangat terbatas dan diawasi',
    examples: ['Morfin', 'Kodein', 'Petidin'],
  ),
];

final List<MedicineTip> medicineTips = [
  MedicineTip(
    id: 'tip_1',
    title: 'Baca Petunjuk',
    description: 'Selalu baca label dan petunjuk penggunaan sebelum minum obat',
    icon: Icons.menu_book_outlined,
  ),
  MedicineTip(
    id: 'tip_2',
    title: 'Periksa Expired',
    description: 'Cek tanggal kedaluwarsa untuk keamanan pengobatan',
    icon: Icons.calendar_today_outlined,
  ),
  MedicineTip(
    id: 'tip_3',
    title: 'Dosis Tepat',
    description: 'Ikuti dosis yang dianjurkan dokter atau pada kemasan',
    icon: Icons.medication_outlined,
  ),
  MedicineTip(
    id: 'tip_4',
    title: 'Simpan dengan Benar',
    description: 'Simpan obat di tempat kering, sejuk, dan jauh dari sinar matahari',
    icon: Icons.inventory_2_outlined,
  ),
  MedicineTip(
    id: 'tip_5',
    title: 'Konsultasi Dokter',
    description: 'Konsultasikan dengan dokter untuk kondisi kronis atau hamil/menyusui',
    icon: Icons.medical_services_outlined,
  ),
  MedicineTip(
    id: 'tip_6',
    title: 'BPOM Terdaftar',
    description: 'Pastikan obat memiliki izin edar dari BPOM',
    icon: Icons.verified_outlined,
  ),
];

final List<MedicineFilter> medicineFilters = [
  MedicineFilter(id: 'filter_1', label: 'Demam & Flu', icon: Icons.thermostat_outlined),
  MedicineFilter(id: 'filter_2', label: 'Pencernaan', icon: Icons.emoji_food_beverage_outlined),
  MedicineFilter(id: 'filter_3', label: 'Vitamin', icon: Icons.health_and_safety_outlined),
  MedicineFilter(id: 'filter_4', label: 'Kulit', icon: Icons.healing_outlined),
  MedicineFilter(id: 'filter_5', label: 'Mata', icon: Icons.remove_red_eye_outlined),
  MedicineFilter(id: 'filter_6', label: 'Jantung', icon: Icons.favorite_border_outlined),
];