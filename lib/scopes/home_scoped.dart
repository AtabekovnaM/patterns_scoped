import 'package:patterns_scoped/model/post_model.dart';
import 'package:patterns_scoped/service/http_service.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScoped extends Model{
  List<Post> items = new List();
  bool isLoading = false;

  Future apiPostList() async{
    isLoading = true;
    notifyListeners();
    var response = await NetWork.GET(NetWork.API_LIST, NetWork.paramsEmpty());
    // print("list item: $response");
    if(response != null){
      items = NetWork.parsePostList(response);
    }else{
      items = new List();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> apiPostDelete(Post post) async{
    isLoading = true;
    var response = await NetWork.DEL(NetWork.API_DELETE + post.id.toString(), NetWork.paramsEmpty());

    isLoading = false;
    notifyListeners();

    return response != null;
  }
}