enum Endpoint {
  GET_EVENT_CURR,
  GET_EVENT_PAST,
}

String toString(Endpoint endpoint) {
  switch (endpoint) {
    case Endpoint.GET_EVENT_CURR:
      return "events?status=current";
    case Endpoint.GET_EVENT_PAST:
      return "events?status=past";
    default:
      return "";
  }
}