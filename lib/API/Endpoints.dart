enum Endpoint {
  GET_EVENT_CURR,
  GET_EVENT_PAST,
  GET_ARTWORK_DIGITAL,
  GET_ARTWORK_NOT_DIGITAL,
  GET_ARTWORK_ALL,
  GET_TAGS
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
    case Endpoint.GET_ARTWORK_DIGITAL:
      return "artworks?type=notDigital";
    case Endpoint.GET_TAGS:
      return "tags";
    default:
      return "";
  }
}