class ArtistModel{
  final String firstName;
  final String lastName;

  ArtistModel.empty()
      : firstName = 'Unknown',
        lastName = 'Artist';

  ArtistModel({
    required this.firstName,
    required this.lastName,
  });
}