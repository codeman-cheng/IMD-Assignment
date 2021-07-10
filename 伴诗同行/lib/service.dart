// 对http请求进行封装
import "package:dio/dio.dart";
class HttpConfig{
  static const baseUrl = "Https://httpbin.org";
  static const timeOut = 3000;
}

class HttpRequest {
  static final BaseOptions baseOptions = BaseOptions(
    baseUrl: HttpConfig.baseUrl,
    connectTimeout: HttpConfig.timeOut
  );
  static final dio = Dio(baseOptions);

  static Future<T> request<T>(String url, {
                        Options optionsGet,
                        String method = "get",
                        Map<String, dynamic> params,
                        Interceptor inter}) async{
    Options options;
    //1. 创建单独配置
    if(optionsGet == null){
      options = Options(method: method);
    }
    else {
      options = optionsGet;
    }

    // 全局拦截器
    Interceptor dIter = InterceptorsWrapper(
      onRequest: (options) {
        print("请求拦截");
        return options;
      },
      onResponse: (response) {
        print("响应拦截");
        return response;
    },
      onError: (err) {
        print("错误拦截");
        return err;
      },
    );
    List<Interceptor> inters = [dIter];

    // 请求单独拦截器
    if(inter != null) {
      inters.add(inter);
    }

    //2. 发送网络请求
    try {
      Response response = await dio.request(
          url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch(e) {
      return Future.error(e);
    }

  }

}