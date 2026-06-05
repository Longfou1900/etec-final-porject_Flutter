import 'package:flutter_projects_getx/core/data/data.dart';
import 'package:flutter_projects_getx/modules/model/home_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
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

  Future<void> loadingData() async {
    lodaing.value = true;
    await Future.delayed(const Duration(seconds: 2));
    homeModel = HomeModel.fromJson(Datas.data);
    print(homeModel.data?.popular?[0].name);
    lodaing.value = false;
  }

  void setIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() async {
    super.onInit();
    await loadingData();
  }
}
