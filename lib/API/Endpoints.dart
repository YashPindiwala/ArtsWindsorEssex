enum Endpoint {
  GET_EVENT_CURR,
  GET_EVENT_PAST,
  GET_ARTWORK_DIGITAL,
  GET_ARTWORK_NOT_DIGITAL,
  GET_ARTWORK_ALL
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
    default:
      return "";
  }
}