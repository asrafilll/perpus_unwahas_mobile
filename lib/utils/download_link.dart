String getDirectDownloadUrl(String driveUrl) {
  final RegExp regex = RegExp(r'/d/(.+?)/');
  final String? fileId = regex.firstMatch(driveUrl)?.group(1);

  if (fileId != null) {
    return 'https://drive.google.com/uc?export=download&id=$fileId';
  } else {
    return driveUrl; // Return the original URL if file ID is not found
  }
}
