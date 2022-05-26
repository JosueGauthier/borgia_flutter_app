import 'package:borgiaflutterapp/data/repository/rank_user_repo.dart';
import 'package:borgiaflutterapp/models/rank_user_shop_model.dart';
import 'package:get/get.dart';

class RankUserStatController extends GetxController {
  final RankUserStatRepo rankUserStatRepo;

  RankUserStatController({required this.rankUserStatRepo});

  List<dynamic> _statList = [];

  List<dynamic> get statList => _statList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRankUserList() async {
    Response response = await rankUserStatRepo.getRankUserList();

    if (response.statusCode == 200) {
      _statList = [];

      List responseBody = response.body;

      for (var i = 0; i < responseBody.length; i++) {
        _statList.add(RankUserShopModel.fromJson(responseBody[i]));
      }
      _isLoaded = true;

      update();
    } else {}
  }
}
