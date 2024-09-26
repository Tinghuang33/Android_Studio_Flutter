import 'package:flutter/material.dart';
import 'package:flutter_practice1/main.dart';
import 'package:flutter_practice1/product.dart';

void main() {
  runApp(const MyApp());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title, required this.intVal, required this.strVal, required this.product});

  final String title;
  final int intVal;
  final String strVal;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我是 B 頁'),
      ),
      body: _MyHomePage(intVal: intVal, strVal: strVal, product: product),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  final int intVal;
  final String strVal;
  final Product product;
  _MyHomePage({Key? key, required this.intVal, required this.strVal, required this.product}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: ElevatedButton(
            onPressed: (){
              Navigator.pop(context, '來自MyHomePage的資料');
            },
            child: Text('返回首頁')),
        ),
        Text('intVal: $intVal'),
        Text('strVal: $strVal'),
        Text('name: ${product.name}'),
        Text('desc: ${product.desc}'),
        Text('price: ${product.price}'),
        Text('price: ${product.stock}'),
        Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  showAlert(context);  //基本訊息視窗，往下滑在下面
                  confirmDialog(context);  //確認取消對話訊息視窗，往下滑在下面
                  inputDialog(context);  //帶輸入框訊息視窗，往下滑在下面
                  optionDialog(context);
                 //SimpleDialog 多選項訊息視窗，往下滑在下面
                },
                child: Text('顯示對話框訊息'),
              ),
              ElevatedButton(
                  onPressed: () async{
                    final OptionDatas? inputData = await optionDialog(context);
                    print('你選擇: $inputData');
                  },
                  child: Text('顯示對話框訊息'))

            ],
          )
        )
      ]
    );
  }
}

    //DAY12
    // //宣告一個Textcontroller用來註冊文字框的controller來監聽文字輸入框內容
    // final TextEditingController myController = new TextEditingController();
    // return Column(
    // children: [
    // TextField(
    // controller: myController,
    // decoration: InputDecoration(hintText: '請輸入...'),
    // style: TextStyle(fontSize: 50),
    // ),
    // OutlinedButton(
    // onPressed: btnClickEvent,
    // child: Text('印出輸入框內容',style: TextStyle(fontSize: 50),),
    // )
    // ],
    // );
    // }
    // void btnClickEvent(){
    // print(myController.text,);

    //DAY11
    // return Center(
    // child: Center(
    // child: Image.asset('assets/images/bear.png'),
    // ),
    // );

    //Day10
    // return Center(
    // child: ElevatedButton(
    // child: Text('按鈕',),
    // onPressed: btnClickEvent,
    // )
    // );
    // }
    //
    // void btnClickEvent() {
    // print('btnClickEvent...');

    //DAY8-9
    // return Center(
    //   child: Text('內文\n1\n2\n3\n4\n5\n6',
    //     style: TextStyle(
    //         fontSize: 50,
    //         fontWeight: FontWeight.bold,
    //         color: Color(0xffff0000),
    //         decoration: TextDecoration.lineThrough,
    //     ),
    //     maxLines: 3,),
    // );

    //DAY7
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Container(
    //       color: Colors.amber,
    //       child: Text('1',style: TextStyle(fontSize: 100),),
    //     ),
    //     Container(
    //       color: Colors.green,
    //       child: Text('2',style: TextStyle(fontSize: 100),),
    //     ),
    //     Container(
    //       color: Colors.blue,
    //       child: Text('3',style: TextStyle(fontSize: 100),),
    //     )
    //   ],
    // );
    //     //Row 和 Column 容器佈局，可以搭配 Expanded 或 Flexible 防止版面跑版。

    //DAY6
    // return Center(
    //     child: Container(
    //       color: Color.fromARGB(50, 255, 00, 00),
    //       alignment: Alignment.center,
    //       child: Text('發大財'),
    //       // constraints: BoxConstraints(
    //       //     maxHeight: 300, maxWidth: 300, minHeight: 50, minWidth: 50),
    //       margin: EdgeInsets.all(50),
    //       padding: EdgeInsets.only(left: 50, top: 100, right: 100, bottom: 10),
    // ));

//基本訊息視窗
Future<void> showAlert(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('測試標題'),
          content: Text('內文'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('確定')
            )
          ],
        );
      }
  );
}

//確認取消對話訊息視窗
enum ConfirmAction {ACCEPT, CANCEL}

Future<ConfirmAction?> confirmDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,  //控制點擊對話框以外的區域是否隱藏對話框
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('確認取消對話視窗'),
          content: Text('內容訊息'),
          actions: [
            ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop(ConfirmAction.ACCEPT);
                },
                child: Text('確認')
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop(ConfirmAction.CANCEL);
                },
                child: Text('取消')
            )
          ],
        );
      }
  );
}

//帶輸入框訊息視窗
Future<String?> inputDialog(BuildContext context) {
  String inputData = "";
  return showDialog(
      context: context,
      barrierDismissible: false, //控制點擊對話框以外的區域是否隱藏對話框
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('帶輸入框訊息視窗'),
          content: new Row(
            children: [
              new Expanded(
                  child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                      labelText: '測試可輸入資料對話視窗', hintText: '請輸入資料...'
                    ),
                    onChanged: (value) {
                      inputData = value;
                    },
                  ),
              )
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(inputData);
                },
                child: Text('送出')
            )
          ],
        );
      }
  );
}

//SimpleDialog 多選項訊息視窗
enum OptionDatas {Java, Python, Swift}

Future<OptionDatas?> optionDialog(BuildContext context) async{
  return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('想要報名的課程'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, OptionDatas.Java);
              },
              child: const Text('Java'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, OptionDatas.Python);
              },
              child: const Text('Python'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, OptionDatas.Swift);
              },
              child: const Text('Swift'),
            )
          ],
        );
      }
  );
}