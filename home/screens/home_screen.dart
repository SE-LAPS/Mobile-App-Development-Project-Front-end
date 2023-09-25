import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/controller/common_get_category_controller.dart';

import '../../../core/common/widgets/search.dart';
import '../../../model/category_model.dart';

import '../controller/home_controller.dart';
import '../widgets/carouselFutureBuilder.dart';
import '../widgets/productFutureBuilder.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenConsumerState();
}

class _HomeScreenConsumerState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  //for category part
  List<CategoryModel> _categoryList = [];

  final List<Widget> _pageList = [
    const ProductFutureBuilder(),
  ];

  void refreshCategoryList() async {
    final isOver = await ref
        .read(homeControllerProvider.notifier)
        .getCategoryData(context);

    if (isOver) {
      _categoryList = await ref.read(categoryProvider)!;

      _pageList.addAll(_categoryList
          .map((e) => ProductFutureBuilder(
                category: e.name,
              ))
          .toList());
      setState(() {
        _pageList;
      });
    }
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshCategoryList();
    });
    //TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Search(searchController: _searchController),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              const CarouselFutureBuilder(),
              const SizedBox(
                height: 10,
              ),
              _pageList.length > 0
                  ? Column(children: _pageList)
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
