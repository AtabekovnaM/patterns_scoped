import 'package:patterns_scoped/model/post_model.dart';
import 'package:patterns_scoped/service/http_service.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateScoped extends  Model{
  var isLoading = false;
  List<Post> items = new List();

  void apiPostCreate(Post post) async{
    isLoading = true;
    notifyListeners();

    var response = await NetWork.POST(NetWork.API_CREATE, NetWork.paramsCreate(post));
    print("Response: $response:");
    isLoading = false;
    notifyListeners();
  }
}
