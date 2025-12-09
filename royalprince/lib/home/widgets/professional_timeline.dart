import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart'; // Import Library BARU
import 'package:flutter_animate/flutter_animate.dart';
import '../models/experience_model.dart'; // Import Model Anda

class ProfessionalTimeline extends StatelessWidget {
  final List<ExperienceModel> data;

  const ProfessionalTimeline({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // FixedTimeline.tileBuilder adalah cara paling efisien membuat list timeline
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0, // 0 artinya garis ada di paling kiri
        color: Colors.grey.shade300, // Warna default garis
        indicatorTheme: const IndicatorThemeData(
          position: 0, 
          size: 20.0,
        ),
        connectorTheme: const ConnectorThemeData(
          thickness: 2.5, // Ketebalan garis
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: data.length,
        
        // 1. BAGIAN GARIS PENGHUBUNG (CONNECTOR)
        connectorBuilder: (_, index, ___) {
          return SolidLineConnector(
            color: data[index].color.withOpacity(0.3), // Warna garis transparan
          );
        },
        
        // 2. BAGIAN TITIK BULAT (INDICATOR)
        indicatorBuilder: (_, index) {
          return DotIndicator(
            color: data[index].color,
            child: Icon(
              Icons.check, // Bisa diganti icon lain
              color: Colors.white,
              size: 12.0,
            ),
          );
        },
        
        // 3. BAGIAN ISI KONTEN (CARD)
        contentsBuilder: (context, index) {
          final item = data[index];
          // Delay animasi bertingkat (Waterfall effect)
          final delay = Duration(milliseconds: 200 * index);

          return Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 24.0),
            child: _buildCard(item).animate(delay: delay)
                .fadeIn(duration: 600.ms)
                .slideX(begin: 0.2, end: 0, curve: Curves.easeOut),
          );
        },
      ),
    );
  }

  // Desain Kartu Profesional
  Widget _buildCard(ExperienceModel item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(left: BorderSide(color: item.color, width: 4)), // Aksen warna di kiri
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris Atas: Tanggal & Perusahaan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.date,
                style: TextStyle(
                  color: item.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item.company,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Judul
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          
          // Deskripsi
          Text(
            item.description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}