import 'package:carrent/core/theming/font_weight_helper.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/core/utils/app_text_style.dart';
import 'package:carrent/feature/favourite_items/logic/favourite_cubit.dart';
import 'package:carrent/feature/favourite_items/logic/favourite_state.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Load favourites when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavouriteCubit>().loadFavouriteCars();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.lightBlack,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                _buildSearchBar(),
                Expanded(
                  child: _buildBody(state),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
      decoration: BoxDecoration(color: AppColors.lightBlack),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Favourite Items",
            style: AppTextStyle.font24LightBlueBold.copyWith(
              fontSize: 21.sp,
              fontWeight: FontWeightHelper.medium,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: _toggleSearch,
                icon: Icon(
                  _isSearching ? Icons.close : Icons.search_outlined,
                  size: 35,
                  color: AppColors.lightBlue,
                ),
              ),
              BlocBuilder<FavouriteCubit, FavouriteState>(
                builder: (context, state) {
                  final cubit = context.read<FavouriteCubit>();
                  bool hasFavourites = false;

                  if (state is FavouriteLoaded) {
                    hasFavourites = state.favouriteCars.isNotEmpty;
                  } else if (state is FavouriteSearchResults) {
                    hasFavourites = state.originalFavourites.isNotEmpty;
                  } else if (state is FavouriteCarToggled) {
                    hasFavourites = state.updatedFavourites.isNotEmpty;
                  }

                  if (hasFavourites) {
                    return IconButton(
                      onPressed: () => _showClearAllDialog(context),
                      icon: Icon(
                        Icons.delete_outline,
                        size: 30,
                        color: AppColors.lightBlue,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    if (!_isSearching) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lightBlue.withOpacity(0.3)),
      ),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        style: AppTextStyle.font16LightBlueRegular,
        decoration: InputDecoration(
          hintText: 'Search favourite cars...',
          hintStyle: AppTextStyle.font16LightBlueRegular.copyWith(
            color: AppColors.lightBlue.withOpacity(0.6),
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.lightBlue),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
        onChanged: (query) {
          context.read<FavouriteCubit>().searchFavouriteCars(query);
        },
      ),
    );
  }

  Widget _buildBody(FavouriteState state) {
    if (state is FavouriteLoading) {
      return _buildLoadingWidget();
    } else if (state is FavouriteError) {
      return _buildErrorWidget(state);
    } else if (state is FavouriteLoaded) {
      return _buildFavouriteList(state.favouriteCars);
    } else if (state is FavouriteSearchResults) {
      return _buildSearchResults(state);
    } else if (state is FavouriteCarToggled) {
      // After toggling, reload the current view
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_isSearching && _searchController.text.isNotEmpty) {
          context.read<FavouriteCubit>().searchFavouriteCars(
            _searchController.text,
          );
        } else {
          context.read<FavouriteCubit>().loadFavouriteCars();
        }
      });
      return _buildFavouriteList(state.updatedFavourites);
    }

    return _buildEmptyWidget();
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.lightBlue),
          SizedBox(height: 16.h),
          Text(
            'Loading favourite cars...',
            style: AppTextStyle.font16LightBlueRegular,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(FavouriteError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
          SizedBox(height: 16.h),
          Text(
            'Error loading favourites',
            style: AppTextStyle.font24LightBlueBold.copyWith(fontSize: 18.sp),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              state.errorMessage,
              style: AppTextStyle.font16LightBlueRegular.copyWith(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              context.read<FavouriteCubit>().loadFavouriteCars();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightBlue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_outline,
            size: 80.sp,
            color: AppColors.lightBlue.withOpacity(0.5),
          ),
          SizedBox(height: 24.h),
          Text(
            'No Favourite Cars Yet',
            style: AppTextStyle.font24LightBlueBold,
          ),
          SizedBox(height: 8.h),
          Text(
            'Start adding cars to your favourites\nto see them here',
            style: AppTextStyle.font16LightBlueRegular.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFavouriteList(List<CarModel> cars) {
    if (cars.isEmpty) {
      return _buildEmptyWidget();
    }

    return RefreshIndicator(
      onRefresh: () async {
        try {
          await context.read<FavouriteCubit>().refresh();
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to refresh: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      color: AppColors.lightBlue,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return _buildCarCard(car);
        },
      ),
    );
  }

  Widget _buildSearchResults(FavouriteSearchResults state) {
    if (state.searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64.sp,
              color: AppColors.lightBlue.withOpacity(0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              'No results found',
              style: AppTextStyle.font24LightBlueBold.copyWith(fontSize: 18.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              'Try searching with different keywords',
              style: AppTextStyle.font16LightBlueRegular.copyWith(
                color: AppColors.lightBlue,
                fontSize: 14.sp, // Fixed: was 18, should be smaller
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: state.searchResults.length,
      itemBuilder: (context, index) {
        final car = state.searchResults[index];
        return _buildCarCard(car);
      },
    );
  }

  Widget _buildCarCard(CarModel car) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.lightBlue.withOpacity(0.2)),
      ),
      child: Dismissible(
        key: Key('car_${car.id}'), // More specific key
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(16.r),
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.w),
          child: Icon(Icons.delete, color: Colors.white, size: 30.sp),
        ),
        confirmDismiss: (direction) => _showRemoveConfirmDialog(car),
        onDismissed: (direction) {
          try {
            context.read<FavouriteCubit>().removeCarFromFavourites(car.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${car.name} removed from favourites'),
                backgroundColor: AppColors.lightBlue,
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    context.read<FavouriteCubit>().toggleCarFavourite(car.id);
                  },
                ),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to remove car: ${e.toString()}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // Car Image
              Container(
                width: 80.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: AssetImage(car.imageAsset),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      // Handle image loading errors
                      debugPrint('Failed to load image: ${car.imageAsset}');
                    },
                  ),
                ),
                child: car.imageAsset.isEmpty
                    ? Icon(
                        Icons.car_rental,
                        size: 30.sp,
                        color: AppColors.lightBlue,
                      )
                    : null,
              ),
              SizedBox(width: 16.w),

              // Car Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.name,
                      style: AppTextStyle.font24LightBlueBold.copyWith(
                        fontSize: 18.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      car.brand,
                      style: AppTextStyle.font16LightBlueRegular.copyWith(
                        fontSize: 14.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.speed,
                          size: 16.sp,
                          color: AppColors.lightBlue,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${car.maxSpeed} km/h',
                          style: AppTextStyle.font16LightBlueRegular.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Icon(
                          Icons.airline_seat_recline_normal,
                          size: 16.sp,
                          color: AppColors.lightBlue,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${car.seats} seats',
                          style: AppTextStyle.font16LightBlueRegular.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Price and Favourite Button
              Column(
                children: [
                  Text(
                    '\$${car.pricePerDay}',
                    style: AppTextStyle.font24LightBlueBold.copyWith(
                      color: AppColors.lightBlue,
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    'per day',
                    style: AppTextStyle.font16LightBlueRegular.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  IconButton(
                    onPressed: () {
                      try {
                        context.read<FavouriteCubit>().toggleCarFavourite(
                          car.id,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Failed to toggle favourite: ${e.toString()}',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      car.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: car.isFavorite ? Colors.red : AppColors.lightBlue,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        // Reset to show all favourites
        context.read<FavouriteCubit>().loadFavouriteCars();
      }
    });
  }

  Future<bool?> _showRemoveConfirmDialog(CarModel car) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.lightBlack,
        title: Text(
          'Remove from Favourites',
          style: AppTextStyle.font24LightBlueBold.copyWith(
            color: AppColors.lightBlue,
            fontSize: 18.sp,
          ),
        ),
        content: Text(
          'Are you sure you want to remove ${car.name} from your favourites?',
          style: AppTextStyle.font16LightBlueRegular.copyWith(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _showClearAllDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.lightBlack,
        title: Text(
          'Clear All Favourites',
          style: AppTextStyle.font24LightBlueBold.copyWith(
            color: AppColors.lightBlue,
            fontSize: 18.sp,
          ),
        ),
        content: Text(
          'Are you sure you want to remove all cars from your favourites? This action cannot be undone.',
          style: AppTextStyle.font16LightBlueRegular.copyWith(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              try {
                context.read<FavouriteCubit>().clearAllFavourites();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Failed to clear favourites: ${e.toString()}',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Clear All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
