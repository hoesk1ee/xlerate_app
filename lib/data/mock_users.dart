// A simple blueprint for our temporary users
class MockUser {
  final String email;
  final String password;
  final bool isAdmin;

  MockUser({
    required this.email,
    required this.password,
    required this.isAdmin,
  });
}

// I created a temporary database just for fun 😁
// I mean for testing the User's Workflow

final List<MockUser> mockDatabase = [
  MockUser(
    email: 'admin@excelerate.com',
    password: 'Excelerate',
    isAdmin: true,
  ),
  MockUser(
    email: 'learner@excelerate.com',
    password: 'Intern',
    isAdmin: false,
  ),
];
