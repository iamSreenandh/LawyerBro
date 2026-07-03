import 'package:flutter/material.dart';
import 'package:lawyer_bro/styles/app_colors.dart';
import 'package:lawyer_bro/styles/app_text_styles.dart';
import 'package:lawyer_bro/features/home/screens/image_preview_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildSearchBar(),
          const SizedBox(height: 24),
          _buildCategories(),
          const SizedBox(height: 32),
          _buildTopLawyers(),
          const SizedBox(height: 32),
          _buildRecentAchievements(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find your',
            style: AppTextStyles.bodyLarge.withColor(AppColors.textSecondary),
          ),
          Text(
            'Perfect Lawyer ⚖️',
            style: AppTextStyles.displayMedium.withColor(AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search lawyers, categories, cases...',
            hintStyle: AppTextStyles.bodyMedium.withColor(AppColors.textHint),
            prefixIcon: const Icon(Icons.search, color: AppColors.textHint),
            suffixIcon: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tune, color: AppColors.textOnPrimary, size: 20),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = ['All', 'Criminal', 'Corporate', 'Family', 'Property', 'Civil'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Categories',
            style: AppTextStyles.headingMedium.withColor(AppColors.textPrimary),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final isSelected = index == 0;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected ? null : Border.all(color: AppColors.border),
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    style: AppTextStyles.labelLarge.withColor(
                      isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopLawyers() {
    final lawyers = [
      {'name': 'Harvey Specter', 'type': 'Corporate', 'rating': '4.9', 'cases': '124'},
      {'name': 'Saul Goodman', 'type': 'Criminal', 'rating': '4.8', 'cases': '89'},
      {'name': 'Alicia Florrick', 'type': 'Family', 'rating': '4.9', 'cases': '102'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Rated Lawyers',
                style: AppTextStyles.headingMedium.withColor(AppColors.textPrimary),
              ),
              Text(
                'See all',
                style: AppTextStyles.labelLarge.withColor(AppColors.primaryDark),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            scrollDirection: Axis.horizontal,
            itemCount: lawyers.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final lawyer = lawyers[index];
              return Container(
                width: 160,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primarySurface,
                      child: Text(
                        lawyer['name']![0],
                        style: AppTextStyles.headingLarge.withColor(AppColors.primaryDark),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      lawyer['name']!,
                      style: AppTextStyles.labelLarge.withColor(AppColors.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lawyer['type']!,
                      style: AppTextStyles.bodySmall.withColor(AppColors.textSecondary),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: AppColors.warning, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          lawyer['rating']!,
                          style: AppTextStyles.labelMedium.withColor(AppColors.textPrimary),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${lawyer['cases']} cases)',
                          style: AppTextStyles.labelSmall.withColor(AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentAchievements() {
    final achievements = [
      {
        'lawyer': 'Harvey Specter',
        'title': 'Won \$10M Corporate Settlement',
        'desc': 'Successfully negotiated a complex merger dispute for a top 500 company.',
        'time': '2 hrs ago',
        'likes': '24',
        'images': [
          'https://images.unsplash.com/photo-1505664177922-241511c5d336?q=80&w=2070&auto=format&fit=crop',
          'https://images.unsplash.com/photo-1589829085413-56de8ae18c73?q=80&w=2112&auto=format&fit=crop',
          'https://images.unsplash.com/photo-1589391886645-d51941baf7fb?q=80&w=2070&auto=format&fit=crop',
        ],
      },
      {
        'lawyer': 'Saul Goodman',
        'title': 'Secured Bail in High-Profile Case',
        'desc': 'Client released on minimum bail terms despite heavy initial charges.',
        'time': '5 hrs ago',
        'likes': '18',
        'images': [
          'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?q=80&w=2070&auto=format&fit=crop',
        ],
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Achievements',
            style: AppTextStyles.headingMedium.withColor(AppColors.textPrimary),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: achievements.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = achievements[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.primarySurface,
                          child: Text(
                            (item['lawyer'] as String)[0],
                            style: AppTextStyles.labelLarge.withColor(AppColors.primaryDark),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['lawyer'] as String,
                                style: AppTextStyles.labelLarge.withColor(AppColors.textPrimary),
                              ),
                              Text(
                                item['time'] as String,
                                style: AppTextStyles.bodySmall.withColor(AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.more_vert, color: AppColors.textHint),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      item['title'] as String,
                      style: AppTextStyles.headingSmall.withColor(AppColors.textPrimary),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['desc'] as String,
                      style: AppTextStyles.bodyMedium.withColor(AppColors.textSecondary),
                    ),
                    const SizedBox(height: 16),
                    if (item['images'] != null && (item['images'] as List).isNotEmpty) ...[
                      _AchievementImageGallery(images: item['images'] as List<String>),
                    ],
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primarySurface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.thumb_up_alt_outlined, size: 16, color: AppColors.primaryDark),
                              const SizedBox(width: 6),
                              Text(
                                item['likes'] as String,
                                style: AppTextStyles.labelMedium.withColor(AppColors.primaryDark),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Congratulate',
                          style: AppTextStyles.labelMedium.withColor(AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AchievementImageGallery extends StatefulWidget {
  final List<String> images;

  const _AchievementImageGallery({required this.images});

  @override
  State<_AchievementImageGallery> createState() => _AchievementImageGalleryState();
}

class _AchievementImageGalleryState extends State<_AchievementImageGallery> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 200,
          child: Stack(
            children: [
              PageView.builder(
                itemCount: widget.images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ImagePreviewScreen(
                            images: widget.images,
                            initialIndex: index,
                          ),
                        ),
                      );
                    },
                    child: Image.network(
                      widget.images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.surface,
                          child: const Center(
                            child: Icon(Icons.error_outline, color: AppColors.textHint, size: 48),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              if (widget.images.length > 1)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_currentIndex + 1} / ${widget.images.length}',
                      style: AppTextStyles.labelMedium.withColor(Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}