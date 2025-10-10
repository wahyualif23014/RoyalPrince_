
class PortfolioItems {
  final String imageUrl;
  final String title;
  final String description;

  PortfolioItems({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final List<PortfolioItems> dummyPortfolioItems = [
  PortfolioItems(
    imageUrl: 'https://picsum.photos/id/10/500/800',
    title: 'Proyek Aplikasi Mobile',
    description: 'Pengembangan aplikasi cross-platform dengan Flutter.',
  ),
  PortfolioItems(
    imageUrl: 'https://picsum.photos/id/1005/500/800',
    title: 'Desain UI/UX',
    description: 'Merancang antarmuka yang intuitif dan modern.',
  ),
  PortfolioItems(
    imageUrl: 'https://picsum.photos/id/1011/500/800',
    title: 'Website Portofolio',
    description: 'Pembuatan website responsif menggunakan teknologi web terbaru.',
  ),
  PortfolioItems(
    imageUrl: 'https://picsum.photos/id/1025/500/800',
    title: 'Integrasi API',
    description: 'Menghubungkan aplikasi dengan layanan pihak ketiga.',
  ),
];