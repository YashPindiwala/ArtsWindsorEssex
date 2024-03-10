enum Endpoint {
  GET_EVENT,
}

String toString(Endpoint endpoint) {
  switch (endpoint) {
    case Endpoint.GET_EVENT:
      return "events";
    default:
      return "";
  }
}