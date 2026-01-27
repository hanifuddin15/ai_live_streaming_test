enum MimeType {
  doc('.doc', 'application/msword'),
  docx(
    '.docx',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  ),
  xls('.xls', 'application/vnd.ms-excel'),
  xlsx(
    '.xlsx',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
  ),
  pdf('.pdf', 'application/pdf'),
  jpg('.jpg', 'image/jpeg'),
  jpeg('.jpeg', 'image/jpeg'),
  png('.png', 'image/png'),
  gif('.gif', 'image/gif'),
  mp4('.mp4', 'video/mp4'),
  mp3('.mp3', 'audio/mpeg'),
  zip('.zip', 'application/zip'),
  rar('.rar', 'application/vnd.rar'),
  txt('.txt', 'text/plain'),
  csv('.csv', 'text/csv'),
  json('.json', 'application/json'),
  ppt('.ppt', 'application/vnd.ms-powerpoint'),
  pptx(
    '.pptx',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation',
  );

  final String extension;
  final String type;

  const MimeType(this.extension, this.type);

  static String fromExtension(String ext) {
    ext = ext.toLowerCase();
    return MimeType.values
        .firstWhere(
          (m) => m.extension == (ext.startsWith('.') ? ext : '.$ext'),
          orElse: () => MimeType.txt,
        )
        .type;
  }
}
