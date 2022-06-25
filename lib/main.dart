import 'package:flutter/material.dart';
import 'package:inputactivity/sql_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'CRUD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController kode_bukuController= TextEditingController();
  TextEditingController  judulController= TextEditingController();
  TextEditingController  pengarangController= TextEditingController();


List<Map<String,dynamic>>catatan=[];
void refreshCatatan()async{
  final data = await SQLHelper.getCatatan();
  setState(() {
    catatan=data;
  });
}

  @override
  Widget build(BuildContext context) {
    print(catatan);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          modelForm();
        },

        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> tambahCatatan()async{
    await SQLHelper.tambahcatatan(kode_bukuController.text, judulController.text, pengarangController.text);
    refreshCatatan();
  }
void modelForm()async{
  showModalBottomSheet(context: context, builder: (_)=> 
  Container(
    padding: const EdgeInsets.all(15),
    width: double.infinity,
    height: 800,
    child :SingleChildScrollView(
      child:Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        TextField(
          controller: kode_bukuController,
          decoration: const InputDecoration(hintText:'kode buku'),
        ),
        const SizedBox(
            height: 10,
        ),
        TextField(
          controller: judulController,
          decoration: const InputDecoration(hintText:'Judul'),  
        ),
          
                TextField(
          controller: pengarangController,
          decoration: const InputDecoration(hintText:'pengarang'),  
        ),
                const SizedBox(
            height: 20,
        ),
        ElevatedButton(onPressed: ()async{
          await tambahCatatan();
        },
        child: Text('simpan'))

      ],
      ),
       ),
  ),
  );
}

}
