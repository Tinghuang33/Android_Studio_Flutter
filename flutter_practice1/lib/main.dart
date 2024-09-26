//載入material函式庫
import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_practice1/my_home_page.dart';
import 'product.dart';

//Dart 程式進入點
void main() {
  debugPaintSizeEnabled = true;

  //Flutter 程式進入點，若沒有載入上方 material 函式庫，將會不認識 runApp
  // 放在 Center 容器裡面 Text 的元件，將會被放置在畫面的正中間
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter標題',style: TextStyle(fontSize: 50)),
          ),
          body: __MyApp(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton( //一定要放在Scaffold裡面
              child: Icon(Icons.add),
              onPressed: () {
                print('press...');
              },
            foregroundColor: Colors.amber,
            backgroundColor: Colors.blue,
          ),
        ),
    );
  }
}

//DAY15 從Ａ頁跳到Ｂ頁，並傳遞資料 + 從Ｂ頁返回Ａ頁並傳回資料
class __MyApp extends StatefulWidget {
  const __MyApp({super.key});

  @override
  State<__MyApp> createState() => __MyAppState();
}

class __MyAppState extends State<__MyApp> {
  var result = "沒有資料";

  Product product = new Product('產品名稱', '產品內容', 100, 60);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: (){
              goToMyHomePage(context);
            },
            child: const Text('跳到另一頁')),),
        Container(
          child: Center(
            child: ElevatedButton(
                onPressed: () {
                  //SnackBar自定義按鈕
                  showSnackBar(context);
                  //直接顯示 SnackBar 簡單基本訊息
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('顯示訊息')));
                },
                child: Text('顯示SnackBar訊息')),
          ),
        ),
        Text('返回值： $result'),
      ],
    );
  }
  void goToMyHomePage(BuildContext context) async{
    var resultValue = await Navigator.push(
        context,MaterialPageRoute(builder: (context) => MyHomePage(title: 'MyHomePage標題', intVal: 100, strVal: 'Melon', product: product)));
    setState(() {
      result = resultValue;
    });
  }
  //顯示 SnackBar 訊息與自定義按鈕
  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('跳出來的訊息'),
      duration: Duration(seconds: 5),
      action: SnackBarAction(
          label: '復原',
          onPressed: () {
            print('復原...');
          }
      ),
    ));
  }
}


// //DAY14 從Ａ頁跳到Ｂ頁，並傳遞資料
// class _MyApp extends StatelessWidget {
//   const _MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//           onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'MyHomePage標題', intVal: 100, strVal: 'Melon')));
//           },
//           child: const Text('跳到另一頁')),
//     );
//   }
// }


// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
