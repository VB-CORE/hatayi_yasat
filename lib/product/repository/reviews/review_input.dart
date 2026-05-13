final class CreateReviewInput {
  const CreateReviewInput({
    required this.placeId,
    required this.rating,
    required this.text,
    required this.anonymous,
  });

  final String placeId;
  final int rating;
  final String text;
  final bool anonymous;
}
