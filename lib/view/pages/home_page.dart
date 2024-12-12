part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel homeViewModel = HomeViewModel();

  initState() {
    homeViewModel.getProvinceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Province Data"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => homeViewModel,
          child: Consumer<HomeViewModel>(builder: (context, value, _) {
            switch (value.provinceList.status) {
              case Status.loading:
                return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
                break;
              case Status.error:
                return Align(
                  alignment: Alignment.center,
                  child: Text(value.provinceList.message.toString()),
                );
                break;
              case Status.completed:
                return ListView.builder(
                    itemCount: value.provinceList.data?.length,
                    itemBuilder: (context, index) {
                      return CardProvince(
                          value.provinceList.data!.elementAt(index));
                    });
                break;
              default:
            }
            return Container();
          })),
    );
  }
}
