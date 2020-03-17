import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //声明一个编写的控制器
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎你来到这里';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('云烟成雨'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                //修饰文本框，增加一个input输入框
                decoration: InputDecoration(
                  //全局padding
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: '类型',
                  helperText: '请输入类型',
                ),
                //autofocus 自动对焦一定要关闭，不然就会自动打开手机输入键盘
                autofocus: false,
              ),
              RaisedButton(
                onPressed: _choiceAction,
                child: Text('选择完毕'),
              ),
              Text(
                showText,
                //超过外边容器，文本显示省略号
                overflow: TextOverflow.ellipsis,
                //允许最大显示行数，一般为1或者2
                maxLines: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _choiceAction() {
    print('开始选择...');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('类型不能为空'),
              ));
    } else {
      getHttp(typeController.text.toString()).then((val){
        setState(() {
          showText = val['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String typeText) async {
    try {
      Response response;
      var date = {'name': typeText};
      response = await Dio().get(
          "https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian",
          queryParameters: date);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}

//静态组件实例
/*class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getHttp();
    return Scaffold(
      body: Center(child: Text('商城首页'),),
    );
  }

//  使用dio进行http get请求示例
  void getHttp() async{
    try{
      Response response;
      response = await Dio().get("https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大胸美女");
      return print(response);

    }catch (e){
      return print(e);
    }
  }


}*/
