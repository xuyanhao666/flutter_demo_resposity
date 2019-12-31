
import 'package:flutter/material.dart';

/*
image基本使用
 */
class ImageDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('image 基本组件使用'),

      ),

      body: Center(
        child: Column(
          children: <Widget>[
            Text('加载网络图片'),
            Image.network('https://upload.jianshu.io/users/upload_avatars/6831163/0e1aa1e8-f64e-4372-9937-796999856b73?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
            Divider(),
            Text('加载本地assets图片'),
            Image.asset('assets/images/icon.png'),
            Divider(),
            /*Text('加载本地图片'),
            Image.file(
              File('本地路径'),
            ),*/
            Text('图片重复'),
            Container(
              width: 400,
              height: 200,
              child:  Image.network('https://upload.jianshu.io/users/upload_avatars/6831163/0e1aa1e8-f64e-4372-9937-796999856b73?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240',
              repeat: ImageRepeat.repeat,),
            )

          ],
        ),
      ),


    );
  }




}