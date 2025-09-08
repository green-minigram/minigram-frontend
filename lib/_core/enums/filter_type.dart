enum FilterType {
  all("ALL"),
  pending("PENDING"),
  accepted("ACCEPTED"),
  rejected("REJECTED");

  const FilterType(this.serverValue);

  final String serverValue;
}
