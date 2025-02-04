enum Endpoint {
  GET_EVENT_CURR,
  GET_EVENT_PAST,
  GET_ARTWORK_DIGITAL,
  GET_ARTWORK_NOT_DIGITAL,
  GET_ARTWORK_ALL,
  GET_ARTWORK,
  GET_TAGS,
  POST_COMMENT,
  GET_COMMENT,
  POST_TRANSACTION,
}

String toString(Endpoint endpoint) {
  switch (endpoint) {
    case Endpoint.GET_EVENT_CURR:
      return "events?status=current";
    case Endpoint.GET_EVENT_PAST:
      return "events?status=past";
    case Endpoint.GET_ARTWORK_ALL:
      return "artworks?type=all";
    case Endpoint.GET_ARTWORK_DIGITAL:
      return "artworks?type=digital";
    case Endpoint.GET_ARTWORK_NOT_DIGITAL:
      return "artworks?type=notDigital";
      case Endpoint.GET_ARTWORK:
      return "artworks/";
    case Endpoint.GET_TAGS:
      return "tags";
    case Endpoint.POST_COMMENT:
      return "comments";
    case Endpoint.GET_COMMENT:
      return "comments/";
    case Endpoint.POST_TRANSACTION:
      return "transaction";
    default:
      return "";
  }
}