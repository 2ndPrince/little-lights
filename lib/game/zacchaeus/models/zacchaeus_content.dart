import '../../../constants/asset_paths.dart';
import 'branch.dart';

/// Static content registry for the Zacchaeus mini-game.
class ZacchaeusContent {
  ZacchaeusContent._();

  /// The three branches Zacchaeus climbs down from top to bottom.
  static const List<Branch> branches = [
    Branch(id: 'branch_1', flamePath: AssetPaths.flameZacchaesuBranch1, order: 1),
    Branch(id: 'branch_2', flamePath: AssetPaths.flameZacchaesuBranch2, order: 2),
    Branch(id: 'branch_3', flamePath: AssetPaths.flameZacchaesuBranch3, order: 3),
  ];
}
