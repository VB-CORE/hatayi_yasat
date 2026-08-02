import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:life_shared/life_shared.dart';

extension VoteModelX on VoteModel {
  static const String merchantReplyField = 'merchantReply';

  bool get hasMerchantReply => merchantReply?.trim().isNotEmpty ?? false;

  static Map<String, Object?> updateFields({
    String? comment,
    String? merchantReply,
    bool clearMerchantReply = false,
  }) => {
    'comment': ?comment,
    'updatedAt': FieldValue.serverTimestamp(),
    if (clearMerchantReply) ...{
      'merchantReply': null,
      'merchantReplyAt': null,
    } else if (merchantReply != null) ...{
      'merchantReply': merchantReply,
      'merchantReplyAt': FieldValue.serverTimestamp(),
    },
  };

  static Map<String, Object> ratingDelta({
    required int score,
    required bool isIncrement,
  }) {
    final delta = isIncrement ? 1 : -1;
    return {
      'ratingSum': FieldValue.increment(score * delta),
      'ratingCount': FieldValue.increment(delta),
    };
  }
}
