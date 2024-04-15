enum TableName {
  ArtworkScanned,
  Tag,
  ArtworkTag,
}

String toString(TableName tableName) {
  switch(tableName){
    case TableName.ArtworkScanned:
      return "Artwork_Scanned";
      break;
    case TableName.Tag:
      return "Tag";
      break;
    case TableName.ArtworkTag:
      return "Artwork_Tag";
      break;
    default:
      return "";
  }
}