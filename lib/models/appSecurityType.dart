enum AppSecurityType {
  e2ee("Сквозное (E2EE)", "e2ee"),
  transport("Транспортное (AES)", "transport");

  final String label;
  final String mode;
  const AppSecurityType(this.label, this.mode);
}
