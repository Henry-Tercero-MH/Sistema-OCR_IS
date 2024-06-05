// validations.js

export const isValidEmail = (email) => {
  const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
  return emailRegex.test(email);
};

// Función para validar la contraseña
export const isValidPassword = (password) => {
  const minLength = 8;
  const uppercaseRegex = /[A-Z]/;
  const lowercaseRegex = /[a-z]/;
  const digitRegex = /[0-9]/;
  const specialCharRegex = /[!@#$%^&*()_+\-=[\]{};':"\\|,.<>/?]+/;

  // Verificar la longitud mínima
  if (password.length < minLength) {
    return false;
  }

  // Verificar la presencia de al menos una letra mayúscula
  if (!uppercaseRegex.test(password)) {
    return false;
  }

  // Verificar la presencia de al menos una letra minúscula
  if (!lowercaseRegex.test(password)) {
    return false;
  }

  // Verificar la presencia de al menos un número
  if (!digitRegex.test(password)) {
    return false;
  }

  // Verificar la presencia de al menos un carácter especial
  if (!specialCharRegex.test(password)) {
    return false;
  }

  // Si todas las validaciones pasan, la contraseña es válida
  return true;
};
