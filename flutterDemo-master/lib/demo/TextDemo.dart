import 'package:flutter/material.dart';



class TextDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        appBar: AppBar(
          title: Text('text基本使用'),
        ),
        
        body:Center(

          child:Column(
            children: <Widget>[
              Text('默认text'), //默认text样式
              Text('修改text字体颜色以及大小', style: TextStyle(color: Colors.red,fontSize: 30),),//修改text字体颜色及大小
              Container(
                width: 300,
                height: 50,
                color: Colors.green,
                child: Text('text水平居中', textAlign: TextAlign.center,),

              ),
              Container(
                width: 300,
                height: 50,
                color: Colors.grey,

                 child: Text('text上下左右居中'),
                 alignment: Alignment.center,

              ),
              Container(
                  width: 300,
                  height: 50,
                  color: Colors.amberAccent,
                  child:
                  Text('text底部对齐', textAlign: TextAlign.right,),


              ),
              Container(
                width: 300,

                color: Colors.purple,
                child:
                Text('text行数限制奶粉司法解释呢减肥不能素恩福额数据恢复本色就好比个精神病根据色斑赶紧扼杀背景故事背景跟被忽视',
                maxLines: 2,//最多显示两行
                overflow: TextOverflow.ellipsis, //多出的省略号代替
                style: TextStyle(color: Colors.white),//设置字体颜色
                ),

                padding: EdgeInsets.all(10),//设置上下左右padding值为10
              ),
            ],

          ),
        )

    );

  }

}