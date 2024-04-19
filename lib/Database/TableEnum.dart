enum TableName {
  ArtworkScanned,
  Tag,
  ArtworkTag,
}

String toString(TableName tableName) {
  switch(tableName){
    case TableName.ArtworkScanned:
      return "Artwork_Scanned";
    case TableName.Tag:
      return "Tag";
    case TableName.ArtworkTag:
      return "Artwork_Tag";
    default:
      return "";
  }
}