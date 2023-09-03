import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vbaseproject/features/home/provider/home_provider.dart';
import 'package:vbaseproject/product/model/constant/project_general_constant.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final StateNotifierProvider<HomeProvider, HomeState> homeProvider;

  @override
  void initState() {
    super.initState();
    homeProvider = StateNotifierProvider((ref) => HomeProvider());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(homeProvider.notifier).updateName();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(ref.watch(homeProvider).title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _pullToRefresh,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: [
                  Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Antakya_-_2011-04-10.jpg/1200px-Antakya_-_2011-04-10.jpg',
                  ),
                  const ListTile(
                    title: Text('Title'),
                    subtitle: Text('Subtitle'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _pullToRefresh() async {
    // Fetch All Data
    ref.read(homeProvider.notifier).updateName();
    setState(() {});
    return Future<void>.delayed(ProjectGeneralConstant.durationHigh);
  }
}
