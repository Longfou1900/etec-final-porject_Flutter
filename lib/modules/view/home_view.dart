import 'package:flutter/material.dart';
import 'package:flutter_projects_getx/modules/controller/home_controller.dart';
import 'package:flutter_projects_getx/modules/item/item_detial.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(length: 3, child: _buildBodyNested),
      ),
    );
  }

  NestedScrollView get _buildBodyNested {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [_buildAppBar];
      },
      body: Obx(
        () => controller.lodaing.value
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildList,
                  Center(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Text('Tab2'),
                    ),
                  ),
                  Center(child: Text('Tab3')),
                ],
              ),
      ),
    );
  }

  // CustomScrollView get _buildBody {
  //   return CustomScrollView(slivers: [_buildAppBar, _buildList]);
  // }

  SliverAppBar get _buildAppBar => SliverAppBar(
    backgroundColor: Colors.white,
    title: Text(
      'App',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {},
      icon: Icon(Icons.menu, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.notifications,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ],
    expandedHeight: 178,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: EdgeInsets.only(left: 18, right: 18, bottom: 65),
      expandedTitleScale: 1,
      title: SizedBox( 
        height: 50,
        child: SearchBar(
          leading: Icon(Icons.search, color: Colors.grey),
          hintText: 'Search',
        ),
      ),
      background: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://i.pinimg.com/1200x/c1/25/c8/c125c8ad376ba1afedee7888f4baea81.jpg',
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: TabBar(
        indicatorWeight: 4,
        indicatorColor: Colors.white,
        tabs: List.generate(
          3,
          (index) => Tab(
            child: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  );
  ListView get _buildList {
    List<String> title = ['Popular', 'Latest'];
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: title.length,
      itemBuilder: (context, index) {
        var popularData = controller.homeModel.data?.popular;
        var latesData = controller.homeModel.data?.lates;
        return Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title[index],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              index == 0
                  ? SingleChildScrollView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          popularData?.length ?? 0,
                          (index) => GestureDetector(
                            onTap: () {
                              Get.to(ItemDetail(id: 0, index: index));
                              // print(index);
                            },
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  height: 200,
                                  width: 150,
                                  margin: EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        popularData?[index].images ?? '',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.5),
                                  ),
                                  child: Text(popularData?[index].name ?? ''),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: List.generate(
                        latesData?.length ?? 0,
                        (index) => GestureDetector(
                          onTap: () {
                            Get.to(ItemDetail(id: 0, index: index));
                          },
                          child: Container(
                            height: 180,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  '${latesData?[index].images}',
                                ),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
