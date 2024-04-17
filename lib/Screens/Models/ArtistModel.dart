class ArtistModel {
  final String firstName;
  final String lastName;

  // Constructor for creating an empty ArtistModel with default values
  ArtistModel.empty()
      : firstName = 'Unknown',
        lastName = 'Artist';

  // Constructor for creating an ArtistModel with specified first and last names
  ArtistModel({
    required this.firstName,
    required this.lastName,
  });
}
