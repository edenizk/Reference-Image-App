class RefPhotos {
  final String fileName;

  RefPhotos({this.fileName});

  String getUrl({containerName = 'photos'}){
    return "https://ergindenizazureblob.blob.core.windows.net/$containerName/" + this.fileName;
  }
}