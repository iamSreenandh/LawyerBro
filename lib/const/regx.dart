final RegExp emailRegex = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
);

final RegExp usernameRegex = RegExp(
  r'^(?=.{3,20}$)(?!.*[._]{2})[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*$',
);
final RegExp passwordRegex = RegExp(
  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&^#()_\-+=])[A-Za-z\d@$!%*?&^#()_\-+=]{8,}$',
);
