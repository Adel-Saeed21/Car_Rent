import 'package:carrent/core/helpers/spacing.dart';
import 'package:carrent/core/utils/app_colors.dart';
import 'package:carrent/feature/home/UI/widgets/home_custom_app_bar.dart';

import 'package:carrent/feature/home/UI/widgets/normal_content.dart';
import 'package:carrent/feature/home/UI/widgets/search_content.dart';

import 'package:carrent/feature/home/UI/widgets/search_text_field.dart';
import 'package:carrent/feature/home/data/car_model.dart';
import 'package:carrent/feature/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController();
  Timer? debounceTimer;

  bool isSearchMode = false;
  bool isSearchLoading = false;
  List<CarModel> searchResults = [];
  String _lastSearchQuery = '';

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = searchController.text.trim();

    if (query.isEmpty) {
      setState(() {
        isSearchMode = false;
        isSearchLoading = false;
        searchResults.clear();
        _lastSearchQuery = '';
      });
      return;
    }
    debounceTimer?.cancel();

    if (query != _lastSearchQuery) {
      setState(() {
        isSearchMode = true;
        isSearchLoading = true;
      });
    }

    debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  void _performSearch(String query) async {
    if (!mounted) return;

    _lastSearchQuery = query;

    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    final results = <CarModel>[];

    for (String brand in carsData.keys) {
      final brandCars = getCarsByBrand(brand);
      final filteredCars = brandCars
          .where(
            (car) =>
                car.name.toLowerCase().contains(query.toLowerCase()) ||
                car.brand.toLowerCase().contains(query.toLowerCase()) ||
                car.features.any(
                  (feature) =>
                      feature.toLowerCase().contains(query.toLowerCase()),
                ),
          )
          .toList();
      results.addAll(filteredCars);
    }

    if (mounted && query == _lastSearchQuery) {
      setState(() {
        isSearchLoading = false;
        searchResults = results;
      });
    }
  }

  void _clearSearch() {
    searchController.clear();
    setState(() {
      isSearchMode = false;
      isSearchLoading = false;
      searchResults.clear();
      _lastSearchQuery = '';
    });
  }

  void _onSuggestionTap(String suggestion) {
    searchController.text = suggestion;
    _onSearchChanged();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return BlocProvider(
      create: (context) => HomeCategoryCubit(),
      child: Scaffold(
        backgroundColor: AppColors.lightBlack,
        body: SafeArea(
          child: Column(
            children: [
              const HomeCustomAppBar(),
              verticalSpace(22.h),
              SearchField(
                controller: searchController,
                isSmallScreen: isSmallScreen,
                isSearchMode: isSearchMode,
                isSearchLoading: isSearchLoading,
                onClear: _clearSearch,
              ),

              verticalSpace(22.h),

              Expanded(
                child: isSearchMode
                    ? SearchContent(
                        isSearchLoading: isSearchLoading,
                        searchResults: searchResults,
                        searchQuery: searchController.text,
                        screenWidth: screenWidth,
                        onClearSearch: _clearSearch,
                        onSuggestionTap: _onSuggestionTap,
                      )
                    : NormalContent(
                        screenWidth: screenWidth,
                        isSmallScreen: isSmallScreen,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
