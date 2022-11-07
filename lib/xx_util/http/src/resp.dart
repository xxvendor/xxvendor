/// 返回数据
class Resp {
  dynamic code;
  dynamic errorCode;
  dynamic msg;
  dynamic data;
  dynamic errorDesc;

  Resp({this.code, this.msg});

  Resp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    errorCode = json['errorcode'];
    msg = json['msg'] ?? '';
    errorDesc = json['errordesc'] ?? '';
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['errorcode'] = errorCode;
    data['msg'] = msg;
    data['errordesc'] = errorDesc;
    data['data'] = this.data;
    return data;
  }

  /// 是否成功
  bool get success => code == "0" || code == 0;
}
