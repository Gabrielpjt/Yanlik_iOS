import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class InformasiDetailHeader extends StatelessWidget {
  final Map<String, dynamic> article;

  const InformasiDetailHeader({
    super.key,
    required this.article,
  });

  String get _title => _safeString(article['title'], fallback: '-');
  String get _publishedDate =>
      _safeString(article['publishedDate'], fallback: '-');
  String get _author => _safeString(article['author'], fallback: '-');
  String get _imageUrl => _safeString(article['imageUrl']);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _title,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 23,
              fontWeight: FontWeight.w800,
              height: 1.18,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _MetaInfo(
                  label: 'Diterbitkan Pada',
                  value: _publishedDate,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _MetaInfo(
                  label: 'Penulis',
                  value: _author,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: _imageUrl.isNotEmpty
                  ? Image.network(
                _imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const _ImagePlaceholder();
                },
              )
                  : const _ImagePlaceholder(),
            ),
          ),
        ),
      ],
    );
  }

  static String _safeString(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;
    final text = value.toString().trim();
    return text.isEmpty ? fallback : text;
  }
}

class _MetaInfo extends StatelessWidget {
  final String label;
  final String value;

  const _MetaInfo({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundSecondary,
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          color: AppColors.contentSecondary,
          size: 48,
        ),
      ),
    );
  }
}