import 'package:dailypoetry/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchPoetry extends StatefulWidget {
  const SearchPoetry({Key key}) : super(key: key);

  @override
  _SearchPoetryState createState() => _SearchPoetryState();
}

class _SearchPoetryState extends State<SearchPoetry> {
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> searchList = [];
  int page = 1;
  var word;
  var isLoadMore = true;
  String loadMoreText = "没有更多数据";
  TextStyle loadMoreTextStyle =
  new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
  ScrollController _scrollController = new ScrollController();


  _SearchPoetryState({Key key}) {
    //固定写法，初始化滚动监听器，加载更多使用
    _scrollController.addListener(() {
      var maxScroll = _scrollController.position.maxScrollExtent;
      var pixel = _scrollController.position.pixels;
      if (maxScroll == pixel && isLoadMore) {
        setState(() {
          loadMoreText = "正在加载中...";
          loadMoreTextStyle =
          new TextStyle(color: const Color(0xFF4483f6), fontSize: 14.0);
        });
        page+=1;
        search(word);
      } else {
        setState(() {
          loadMoreText = "没有更多数据";
          loadMoreTextStyle =
          new TextStyle(color: const Color(0xFF999999), fontSize: 14.0);
        });
      }
    });
  }

  void search(String word) async{
    await HttpRequest.request(
      'http://api.tianapi.com/txapi/poetries/index',
      method: 'post',
      params: {
        'key': '387063fcf2ced79481cd430c1175226e',
        'word': word,
        'page': page,
        'num': 10
      }
    ).then((value) {
      if(value['code'] == 200){
        searchList.addAll(value['newslist']);
        print(searchList.length);
        if(value['newslist'].length< 10){
          isLoadMore = false;
        }
      }
      else{
        isLoadMore = false;
      }
    });
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    search(word);
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Color(0xFF292a3e),
       body: Container(
         padding: const EdgeInsets.only(top: 20),
        child: Column(children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "请输入搜索内容",
                  hintMaxLines: 1,
                  prefixIcon: Icon(CupertinoIcons.search)),
              keyboardType: TextInputType.text,
              controller: _controller,
            ),
          ),
          FlatButton(
            minWidth: 0,
            child: Text("搜索"),
            color: Colors.white,
            onPressed: () {
              if (_controller.text == '') {
                Fluttertoast.showToast(
                    msg: "请输入查询内容",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black45,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }else {
                searchList = [];
                page = 1;
                isLoadMore = true;
                word = _controller.text;
                search(word);
              }
            }),
          Expanded(
            child: searchList.length ==0 ?
            new Center(child: new CircularProgressIndicator()):
              ListView.builder(
                itemCount: searchList.length+1,
                itemBuilder: (context,index) {
                    if (index == searchList.length) {
                        return _buildProgressMoreIndicator();
                    } else {
                    return _PoetryItem(searchList[index]);
                    }
                    },
                controller: _scrollController,
              ),
          )

    ])
    ),
     );
  }

  Widget _buildProgressMoreIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Center(
        child: new Text(loadMoreText, style: loadMoreTextStyle),
      ),
    );
  }
}

class _PoetryItem extends StatelessWidget {
  var title;
  var content;
  var author;
  _PoetryItem(newslist) {
    title = newslist['title'];
    content = newslist['content'];
    author = newslist['author'];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
      decoration: new BoxDecoration(
        border: new Border.symmetric(horizontal: BorderSide(color: Colors.grey)),
      ),
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200,
              child: Text(title,style: TextStyle(color: Colors.white),),
            ),
            Container(child: Text(author,style: TextStyle(color: Colors.white,))),
          ],
        ),
      ),
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return _PoetryDetail(author, title, content);
            }));
      },
    );
  }
}

class _PoetryDetail extends StatelessWidget {
  var author;
  var content;
  var title;

  _PoetryDetail(this.author, this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF292a3e),
      ),
      backgroundColor: Color(0xFF292a3e),
      body: Center(
        child: Container(
            width: ScreenUtil().setWidth(300),
            height: ScreenUtil().setHeight(500),
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: AssetImage("assets/face.png"),
                  fit: BoxFit.fill
              ),
            ),
            child: _poetry()
        ),
      ),
    );
  }

  Widget _poetry() {
    List<Widget> contentList = [];
    var contentDetail = content.split(new RegExp('，|。'));
    for (int i = 0; i < contentDetail.length; i++) {
      contentList.add(Center(child: Text(
          '${contentDetail[i]}', style: TextStyle(color: Colors.black,fontSize: 15))));
      contentList.add(SizedBox(height: 5,));
    }
    return Center(
      child: Container(
          width: ScreenUtil().setWidth(300),
          height: ScreenUtil().setHeight(500),
          padding: const EdgeInsets.only(
              top: 65, bottom: 80, left: 20, right: 20),
          child: Column(
            children: [
              Center(
                  child: Text(title, style: TextStyle(color: Colors.black,fontSize: 15))),
              SizedBox(height: 5,),
              Center(
                child: Text('$author', style: TextStyle(color: Colors.black,fontSize: 15),),
              ),
              SizedBox(height: 5,),
              Expanded(child: ListView(children: contentList,)),
            ],)
      ),
    );
  }
}

