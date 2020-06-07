class RefPhotos {
  final String fileName;

  RefPhotos({this.fileName});

  String getUrl(){
    return "https://ergindenizazureblob.blob.core.windows.net/test/" + this.fileName;
  }
}