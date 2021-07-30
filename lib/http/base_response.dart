/*{
"data": ...,
"errorCode": 0,
"errorMsg": ""
}*/

class WResponseData {

  int errorCode;

  String errorMsg;

  var data;


  WResponseData({this.errorCode, this.errorMsg, this.data});

  bool get isSuccess{
    return 0==errorCode;
  }
}