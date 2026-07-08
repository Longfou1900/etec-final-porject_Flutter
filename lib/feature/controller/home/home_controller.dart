import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/feature/model/home_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static const _watchApiUrl =
      'https://seangleangsim006-cmd.github.io/fake-json/';

  // create variable
  var _counter = 0.obs;
  int get getCounter => _counter.value;
  // ignore: strict_top_level_inference
  void setCounter(value) => _counter.value = value;
  void increment() => _counter++;
  void decrement() => _counter.value <= 0 ? 0 : _counter--;

  List<HomeModel> homeModelList = [];

  var lodaing = true.obs;
  HomeModel homeModel = HomeModel();
  var selectedIndex = 0.obs;

  /// 0 = light, 1 = dark
  final RxBool isDarkMode = true.obs;

  Future<void> loadingData() async {
    lodaing.value = true;
    try {
      final response = await GetConnect().get(_watchApiUrl);

      if (response.isOk) {
        homeModel = HomeModel.fromApi(response.body);
      } else {
        homeModel = HomeModel(data: Data(popular: [], lates: []));
      }
    } catch (_) {
      homeModel = HomeModel(data: Data(popular: [], lates: []));
    } finally {
      lodaing.value = false;
    }
  }

  void setIndex(int index) {
    selectedIndex.value = index;
  }

  void toggleTheme() {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  void onInit() async {
    super.onInit();
    await loadingData();
  }
}
