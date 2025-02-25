bool isValidEmail(String email) {
  final List<String> allowedDomains = [
    'gmail.com',
    'yahoo.com',
    'outlook.com',
    'hotmail.com'
  ];
  final emailParts = email.split('@');
  if (emailParts.length != 2) {
    return false;
  }

  String domain = emailParts[1];
  return allowedDomains.contains(domain);
}
