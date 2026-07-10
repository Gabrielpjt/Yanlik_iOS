import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../shared/widgets/app_pagination.dart';
import '../../domain/entities/informasi_layanan_ulasan_entity.dart';

class InformasiReviewsSection extends StatefulWidget {
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final List<InformasiLayananUlasanEntity> reviews;
  final int? totalReviews;
  final double? averageRating;
  final bool isLoading;
  final String errorMessage;

  const InformasiReviewsSection({
    super.key,
    required this.currentPage,
    required this.onPageChanged,
    required this.reviews,
    this.totalReviews,
    this.averageRating,
    this.isLoading = false,
    this.errorMessage = '',
  });

  @override
  State<InformasiReviewsSection> createState() => _InformasiReviewsSectionState();
}

class _InformasiReviewsSectionState extends State<InformasiReviewsSection> {
  static const int _itemsPerPage = 5;

  final TextEditingController _searchController = TextEditingController();

  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<InformasiLayananUlasanEntity> get _filteredReviews {
    final query = _query.trim().toLowerCase();

    if (query.isEmpty) {
      return widget.reviews;
    }

    return widget.reviews.where((review) {
      final text = review.ulasan.toLowerCase();
      final name = (review.dibuatOlehNama ?? '').toLowerCase();

      return text.contains(query) || name.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredReviews = _filteredReviews;
    final totalFromApi = widget.totalReviews ?? widget.reviews.length;
    final averageRating = widget.averageRating ?? 0;

    final totalPages = filteredReviews.isEmpty
        ? 1
        : ((filteredReviews.length + _itemsPerPage - 1) ~/ _itemsPerPage);

    final safeCurrentPage = widget.currentPage > totalPages
        ? totalPages
        : widget.currentPage;

    final visibleReviews = filteredReviews
        .skip((safeCurrentPage - 1) * _itemsPerPage)
        .take(_itemsPerPage)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$totalFromApi Ulasan',
          style: const TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          averageRating > 0
              ? 'Rata-rata rating ${averageRating.toStringAsFixed(1)}'
              : 'Rata-rata rating -',
          style: const TextStyle(
            color: AppColors.contentSecondary,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 42,
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _query = value;
                    });
                    widget.onPageChanged(1);
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari ulasan',
                    hintStyle: const TextStyle(
                      color: AppColors.contentSecondary,
                      fontSize: 12,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                      color: AppColors.contentSecondary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(
                        color: AppColors.strokePrimary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: const BorderSide(
                        color: AppColors.strokePrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (widget.isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: CircularProgressIndicator(),
            ),
          )
        else if (widget.errorMessage.isNotEmpty)
          _ReviewMessage(
            message: widget.errorMessage,
            isError: true,
          )
        else if (visibleReviews.isEmpty)
            const _ReviewMessage(
              message: 'Belum ada ulasan.',
            )
          else ...[
              ...visibleReviews.map((review) {
                return _ReviewItem(review: review);
              }),
              if (totalPages > 1)
                Center(
                  child: AppPagination(
                    currentPage: safeCurrentPage,
                    totalPages: totalPages,
                    onPageChanged: widget.onPageChanged,
                  ),
                ),
            ],
      ],
    );
  }
}

class _ReviewMessage extends StatelessWidget {
  final String message;
  final bool isError;

  const _ReviewMessage({
    required this.message,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isError ? Colors.red.shade50 : AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isError ? Colors.red.shade200 : AppColors.strokePrimary,
        ),
      ),
      child: Text(
        message.isNotEmpty ? message : '-',
        style: TextStyle(
          color: isError ? Colors.red.shade700 : AppColors.contentSecondary,
          fontSize: 13,
          height: 1.4,
        ),
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final InformasiLayananUlasanEntity review;

  const _ReviewItem({
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    final rating = review.rating;
    final name = _safeString(review.dibuatOlehNama, fallback: '-');
    final date = _formatDate(review.dibuatPada);
    final text = _safeString(review.ulasan, fallback: '-');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 18),
      margin: const EdgeInsets.only(bottom: 18),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.strokePrimary),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.backgroundSecondary,
            child: Icon(
              Icons.person_outline,
              color: AppColors.contentSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.contentPrimary,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  final starValue = index + 1;
                  final isActive = rating >= starValue;

                  return Icon(
                    Icons.star_rounded,
                    size: 20,
                    color: isActive
                        ? const Color(0xFFFFC107)
                        : const Color(0xFFE5E7EB),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.contentPrimary,
              fontSize: 13.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            date,
            style: const TextStyle(
              color: AppColors.contentSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  static String _safeString(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;
    final text = value.toString().trim();
    return text.isEmpty ? fallback : text;
  }

  static String _formatDate(DateTime? value) {
    if (value == null) return '-';

    try {
      return DateFormat('EEEE, dd MMM yyyy', 'id_ID').format(value);
    } catch (_) {
      return DateFormat('dd MMM yyyy').format(value);
    }
  }
}

class InformasiRelatedSection extends StatelessWidget {
  final List<Map<String, dynamic>> articles;
  final ValueChanged<Map<String, dynamic>> onArticleTap;

  const InformasiRelatedSection({
    super.key,
    required this.articles,
    required this.onArticleTap,
  });

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Terkait',
          style: TextStyle(
            color: AppColors.contentPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 16),
        ...articles.take(3).map((article) {
          return _RelatedInfoItem(
            article: article,
            onTap: () => onArticleTap(article),
          );
        }),
      ],
    );
  }
}

class _RelatedInfoItem extends StatelessWidget {
  final Map<String, dynamic> article;
  final VoidCallback onTap;

  const _RelatedInfoItem({
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = _safeString(article['imageUrl']);
    final category = _safeString(article['category'], fallback: '-');
    final publishedDate = _safeString(article['publishedDate'], fallback: '-');
    final title = _safeString(article['title'], fallback: '-');
    final likes = _safeString(article['likes'], fallback: '-');
    final comments = _safeString(article['comments'], fallback: '-');

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                width: 96,
                height: 96,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const _RelatedImagePlaceholder();
                },
              )
                  : const _RelatedImagePlaceholder(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          '|',
                          style: TextStyle(
                            color: AppColors.strokePrimary,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Diterbitkan $publishedDate',
                          style: const TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.brandPrimary,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          size: 13,
                          color: AppColors.contentSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          likes,
                          style: const TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 11,
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 14,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          color: AppColors.strokePrimary,
                        ),
                        const Icon(
                          Icons.mode_comment_outlined,
                          size: 13,
                          color: AppColors.contentSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          comments,
                          style: const TextStyle(
                            color: AppColors.contentSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _safeString(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;
    final text = value.toString().trim();
    return text.isEmpty ? fallback : text;
  }
}

class _RelatedImagePlaceholder extends StatelessWidget {
  const _RelatedImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      color: AppColors.backgroundSecondary,
      child: const Icon(
        Icons.image_outlined,
        color: AppColors.contentSecondary,
      ),
    );
  }
}