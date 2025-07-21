part of '../history_view.dart';

@immutable
final class _HistoryInfoDialog extends StatelessWidget {
  const _HistoryInfoDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          const Icon(
            Icons.photo_library_outlined,
            color: Colors.blue,
            size: 28,
          ),
          const SizedBox(width: 12),
          Text(
            'Hatıralar Sayfasına Hoş Geldiniz!', // LocaleKeys.historyPage_welcomeTitle.tr(),
            style: context.general.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dummy image placeholder
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.collections_outlined,
                  size: 50,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 8),
                Text(
                  'Dummy Image',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '(Sonra güncellenecek)',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Bu sayfada güzel anılarınızı paylaşabilir ve diğer kullanıcıların hatıralarını görüntüleyebilirsiniz. Instagram benzeri bir deneyim sunar.', // LocaleKeys.historyPage_welcomeDescription.tr(),
            style: context.general.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.blue[200]!,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.add_a_photo_outlined,
                  color: Colors.blue[600],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Sağ alttaki + butonuna tıklayarak yeni hatıra ekleyebilirsiniz.', // LocaleKeys.historyPage_addPhotoInfo.tr(),
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Anladım', // LocaleKeys.button_understood.tr(),
            style: TextStyle(
              color: Colors.blue[600],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
