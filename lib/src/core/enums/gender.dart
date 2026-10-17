/// Who a product is cut for. [all] is a filter value, never a product's own.
enum Gender {
  all,
  men,
  women,
  unisex;

  static Gender fromName(String? value) => Gender.values.firstWhere(
    (Gender e) => e.name == value,
    orElse: () => Gender.unisex,
  );
}
