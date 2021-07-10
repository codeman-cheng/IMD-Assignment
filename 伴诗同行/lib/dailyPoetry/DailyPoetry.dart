import 'package:dailypoetry/service.dart';
import 'package:dailypoetry/userInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:dio/dio.dart";
import 'package:flutter_screenutil/screenutil.dart';
import 'dart:math';

class DailyPoetry extends StatefulWidget {
  @override
  _DailyPoetryState createState() => _DailyPoetryState();
}

class _DailyPoetryState extends State<DailyPoetry>{
  final options = Options(method: "get");
  bool isBack = true;
  var poetry;
  double angle = 0;

  void _flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }
  _DailyPoetryState();


  initState() {
    super.initState();
    initData();
  }

  Future getToken() async{
    return HttpRequest.request(
      'https://v2.jinrishici.com/token',
      method: 'get',
    );

  }

  Future testInfo() async{
    return HttpRequest.request(
        'https://v2.jinrishici.com/info',
        method: 'get',
      optionsGet: options
    );
  }

  void initData() async {
    try {
      await getToken().then((value) {
        if (value["status"] == "success") {
          User.getUser(value["data"]);
          Map<String, String> headers = {
            "X-User-Token": User.userInfo.token,
            "content-type": "multipart/form-data"
          };
          options.headers = headers;
        }
      });
    }
    catch(e){
      print(e);
    }
    getSentence();
  }

  void getSentence() async {
    await testInfo();
    await HttpRequest.request(
        'https://v2.jinrishici.com/sentence',
        method: 'get',
        optionsGet: options
    ).then((value){
      poetry = value;
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        context,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
      return Scaffold(
        backgroundColor: Color(0xFF292a3e),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _flip,
                  child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: angle),
                      duration: Duration(seconds: 1),
                      builder: (BuildContext context, double val, __) {
                        //here we will change the isBack val so we can change the content of the card
                        if (val >= (pi / 2)) {
                          isBack = false;
                        } else {
                          isBack = true;
                        }
                        return (Transform(
                          //let's make the card flip by it's center
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(val),
                          child: Container(
                              width: ScreenUtil().setWidth(300),
                              height: ScreenUtil().setHeight(500),
                              child: isBack
                                  ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage("assets/back.png"),
                                      fit: BoxFit.fill
                                  ),
                                ),
                                child: PoetryRecommend(),
                              ) //if it's back we will display here
                                  : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..rotateY(
                                      pi), // it will flip horizontally the container
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      image: AssetImage("assets/face.png"),
                                        fit: BoxFit.fill
                                    ),
                                  ),
                                  child: PoetryDetail(),
                                  ),
                                ),
                              ) //else we will display it here,
                          ));
                      }),
                )
              ],
            ),
          ),
        ),
      );
  }

  Widget PoetryRecommend() {
    return poetry==null?
    Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      InkWell(
      child: Icon(CupertinoIcons.goforward,color: Colors.white70,size: 30,),
      onTap: (){
        getSentence();
      },),
          SizedBox(height: 10,),
          Text('加载失败，点击重新加载',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100,fontSize: 10))
        ],
      ),
    ): PoetryRecommendDetail();
  }

  Widget PoetryRecommendDetail() {
    List<String> contentList = poetry['data']['content'].split('，');
    List<dynamic> recommendList = poetry['data']['matchTags'];
    List<Widget> contentWidget = [];
    String recommendString = '';
    for(int i =0;i<contentList.length-1;i++) {
      contentWidget.add(
          Center(child: Text('${contentList[i]}，',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100,fontSize: 25)))
      );
    }
    contentWidget.add(
        Center(child: Text('${contentList[contentList.length-1]}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100,fontSize: 25)))
    );
    if(recommendList.length == 0){
      recommendString = '无';
    }
    else{
      for(int i =0;i<recommendList.length;i++){
        recommendString = recommendString + recommendList[i];
        recommendString = recommendString + '  ';
      }
    }



    return Container(
      child: Stack(
        children: [
          Container(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: contentWidget,
              ),
            )
          ),
          Positioned(
            bottom: 73,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: ScreenUtil().setWidth(300),
              child: Center(child: Text('推荐原因：$recommendString',style: TextStyle(color: Colors.white54,fontWeight: FontWeight.w100,fontSize: 15)))
            ),
          ),
          Positioned(
          bottom: 28,
          right: 20,
          child: Container(
            child: InkWell(
                child: Icon(CupertinoIcons.goforward,color: Colors.white70,size: 30,),
              onTap: (){
                  getSentence();
              },
            ),
          ),
        ),]
      ),
    );
  }

  Widget PoetryDetail() {
    return Center(
        child: Container(
            child: poetry==null?
                Container():PoetryInfo(
                    poetry['data']["origin"]["title"],
                    poetry['data']["origin"]["author"],
                    poetry['data']["origin"]["dynasty"],
                    poetry['data']["origin"]["content"],
                    poetry['data']['origin']['translate']
                ),
            )
    );
  }

  dispose() {
    super.dispose();
  }

}

class PoetryInfo extends StatelessWidget {
  final title;
  final dynasty;
  final author;
  final translate;
  List<dynamic> content;

  PoetryInfo(this.title,this.dynasty,this.author,this.content,this.translate);

  @override
  Widget build(BuildContext context) {
    List<Widget> contentList = [];
    for(int i =0; i<content.length;i++){
      contentList.add(
          Center(child: Text('${content[i]}',style: TextStyle(color: Colors.black))));
      contentList.add(SizedBox(height: 5,));
    }
    if(translate!= null) {
      contentList.add(SizedBox(height: 20,));
      contentList.add(
          Center(child: Text('翻译：${translate[0]}',style: TextStyle(color: Colors.black))));

    }

    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 25,bottom: 80,left: 20,right: 20),
        child: Column(
          children: [
            Center(
              child: Text(title,style: TextStyle(color: Colors.black))),
            SizedBox(height: 5,),
            Center(
              child: Text('$author   $dynasty',style: TextStyle(color: Colors.black),),
            ),
            SizedBox(height: 5,),
            Expanded(child: ListView(children: contentList,)),
      ],)
      ),
    );
  }
}



