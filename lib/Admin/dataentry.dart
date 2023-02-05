import 'package:easy_stepper/easy_stepper.dart';

import '../config/NavBar.dart';
import '../config/config.dart';
import '../home.dart';

class DataEntry extends StatefulWidget {

  @override
  State<DataEntry> createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry>{

  @override
  Widget build(BuildContext context) {
    Future<bool> _back() async {
      return await Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
    return WillPopScope(
      onWillPop: _back,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Scaffold(
                  drawer: NavBar(),
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: AppColors.Black),
                    backgroundColor: AppColors.White,
                    title: Text(Names.AppName ,style: TextStyle(color: AppColors.Black,fontSize: 25, fontWeight: FontWeight.bold),),
                    centerTitle: true,
                    bottom: const TabBar(
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: AppColors.LightGold),
                      tabs: <Widget>[
                        Tab(
                          child: Text("شركات",style: TextStyle(color: AppColors.Black,fontSize: 15,fontWeight: FontWeight.bold),),
                        ),
                        Tab(
                          child: Text("افراد",style: TextStyle(color: AppColors.Black,fontSize: 15,fontWeight: FontWeight.bold),),
                        ),

                      ],
                    ),
                  ),
                  body:  TabBarView(
                    children: <Widget>[
                      //شركات
                      SingleChildScrollView(

                      ),
                      //افراد
                      SingleChildScrollView(

                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),

      ),
    );  }

}