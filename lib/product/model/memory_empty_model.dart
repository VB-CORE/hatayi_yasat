import 'package:life_shared/life_shared.dart';

final class MemoryEmptyModel {
  const MemoryEmptyModel._();

  static MemoryModel empty = const MemoryModel(documentId: '');

  static List<MemoryModel> mockMemories = [
    MemoryModel(
      documentId: 'memory_1',
      title: 'Güzel Bir Günbatımı',
      description: 'Deniz kenarında çektiğimiz bu muhteşem günbatımı anısı.',
      imageUrls: const ['https://picsum.photos/400/400?random=1'],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    MemoryModel(
      documentId: 'memory_2',
      title: 'Arkadaşlarla Piknik',
      description: 'Harika geçen piknik gününden kareler.',
      imageUrls: const ['https://picsum.photos/400/400?random=2'],
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    MemoryModel(
      documentId: 'memory_3',
      title: 'Şehir Manzarası',
      description: 'Gece şehrin ışıltılı manzarası.',
      imageUrls: const ['https://picsum.photos/400/400?random=3'],
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    MemoryModel(
      documentId: 'memory_4',
      title: 'Lezzetli Yemek',
      description: 'Bugün yaptığımız nefis pasta.',
      imageUrls: const ['https://picsum.photos/400/400?random=4'],
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      updatedAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    MemoryModel(
      documentId: 'memory_5',
      title: 'Doğa Yürüyüşü',
      description: 'Ormandaki muhteşem doğa yürüyüşümüz.',
      imageUrls: const ['https://picsum.photos/400/400?random=5'],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    MemoryModel(
      documentId: 'memory_6',
      title: 'Kedi Dostumuz',
      description: 'Sokak kedisi dostumuzla güzel anlar.',
      imageUrls: const ['https://picsum.photos/400/400?random=6'],
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      updatedAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    MemoryModel(
      documentId: 'memory_7',
      title: 'Kahve Molası',
      description: 'Sabah kahvesi ile güne başlangıç.',
      imageUrls: const ['https://picsum.photos/400/400?random=7'],
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    MemoryModel(
      documentId: 'memory_8',
      title: 'Kitap Okuma Zamanı',
      description: 'Huzurlu bir kitap okuma seansı.',
      imageUrls: const ['https://picsum.photos/400/400?random=8'],
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      updatedAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    MemoryModel(
      documentId: 'memory_9',
      title: 'Müzik Keyfi',
      description: 'Gitar çalarken çektiğimiz bu anı.',
      imageUrls: const ['https://picsum.photos/400/400?random=9'],
      createdAt: DateTime.now().subtract(const Duration(days: 9)),
      updatedAt: DateTime.now().subtract(const Duration(days: 9)),
    ),
  ];
}
