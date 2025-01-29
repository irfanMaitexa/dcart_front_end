String? validateEmail({ required String? value}) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  }

  else{

    final RegExp emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if(emailRegex.hasMatch(value)){
      return null;

    }else{
      return 'Enter a valid email';

    }
  }
}

String? validatePassword({required String password}) {
  if (password.isEmpty) {
    return 'Please enter a password';
  } else if (password.length < 8) {
    return 'Password must be at least 8 characters long';
  } else if (!RegExp(r'^(?=.*[A-Z])').hasMatch(password)) {
    return 'Password must contain at least one uppercase letter';
  } else if (!RegExp(r'^(?=.*[a-z])').hasMatch(password)) {
    return 'Password must contain at least one lowercase letter';
  } else if (!RegExp(r'^(?=.*\d)').hasMatch(password)) {
    return 'Password must contain at least one digit';
  } else if (!RegExp(r'^(?=.*[!@#\$&*~])').hasMatch(password)) {
    return 'Password must contain at least one special character';
  }
  return null;  // Password is valid
}


String ? validateDropdown({ required String ? value}) {
  if (value == null) {

     return 'Please select an option';

  } else {

      return null;

  }
}

