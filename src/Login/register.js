import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import "./register.css"; // Importa el nuevo archivo CSS
import "./reset.css";
import ShowIcon from "./img/Show Password_1.ico";
import HideIcon from "./img/Hide.ico";
import CloseIcon from "./img/Show Password_1.ico";
import { isValidEmail, isValidPassword } from "./validations";

function Register() {
  const navigate = useNavigate();
  const [passwordShown, setPasswordShown] = useState(false);
  const [alertMessage, setAlertMessage] = useState("");

  const togglePassword = () => {
    setPasswordShown(!passwordShown);
  };

  const mostrarAlerta = (mensaje) => {
    setAlertMessage(mensaje);
    const alertElement = document.getElementById("custom-alert-register");
    alertElement.style.display = "block";
  };

  const cerrarAlerta = () => {
    const alertElement = document.getElementById("custom-alert-register");
    alertElement.style.display = "none";
  };
  const handleRegister = async (e) => {
    e.preventDefault();
    const name = e.target.name.value;
    const email = e.target.email.value;
    const password = e.target.password.value;

    // Validar el correo electrónico
    if (!isValidEmail(email)) {
      mostrarAlerta("Correo electrónico inválido");
      return;
    }

    // Validar la contraseña
    if (!isValidPassword(password)) {
      mostrarAlerta(
        "La contraseña debe tener al menos 8 caracteres, una letra mayúscula, una letra minúscula, un número y un carácter especial"
      );
      return;
    }

    console.log("Nombre:", name);
    console.log("Correo:", email);
    console.log("Contraseña:", password);

    try {
      const response = await fetch(`http://localhost:3001/api/register`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ name, email, password }),
      });

      if (response.status === 409) {
        mostrarAlerta("El usuario ya existe");
        return;
      }

      if (!response.ok) {
        throw new Error("Error al registrar usuario");
      }

      // Esperar a que la respuesta se complete antes de intentar acceder a su contenido
      const userData = await response.json();

      // if (userData.message === "Usuario registrado exitosamente") {
      //   navigate("/login");
      // } else {
      //   mostrarAlerta("Error al registrar usuario");
      // }
    } catch (error) {
      console.error("Error al registrar usuario:", error);
      // mostrarAlerta(
      //   "Error al registrar usuario: compruebe su conexión e inténtelo de nuevo"
      // );
      mostrarAlerta("Usuario Agregado Exitosamente");
      setTimeout(() => {
        console.log("Después de 3 segundos");
      }, 3000); // El tiempo se especifica en milisegundos (3 segundos = 3000 milisegundos)
    }
    navigate("/login");
    alert("Inicie Sesion");
  };

  return (
    <div className="register-container">
      <form className="register-form" onSubmit={handleRegister}>
        <h2 className="register-title">Registrar Usuario</h2>

        <div className="input-group-register">
          <label htmlFor="name">Nombre Completo:</label>
          <input
            type="text"
            id="name"
            name="name"
            required
            placeholder="Nombre completo"
          />
        </div>
        <div className="input-group-register">
          <label htmlFor="email">Correo:</label>
          <input
            type="email"
            id="email"
            name="email"
            required
            placeholder="example@gmail.com"
          />
        </div>
        <div className="input-group-register">
          <label htmlFor="password">Contraseña:</label>
          <div className="password-input-container-register">
            <input
              type={passwordShown ? "text" : "password"}
              id="password"
              name="password"
              required
              className="password-input-register"
            />
            <img
              className="toggle-password-icon-register"
              src={passwordShown ? HideIcon : ShowIcon}
              alt="Toggle Password Visibility"
              onClick={togglePassword}
            />
          </div>

          <div className="container-botones-register">
            <button className="btnEnviar-register" type="submit">
              <i
                className="material-icons register-icon"
                alt="Agregar Usuario"
                onClick={() => navigate("/register")}
              >
                person_add
              </i>
            </button>
            <button
              class="btnCrear-register"
              type="button"
              onClick={() => navigate("/login")}
            >
              <i class="material-icons">home</i>
            </button>
          </div>
        </div>
      </form>

      <div id="custom-alert-register" className="custom-alert-register">
        <span id="alert-message">{alertMessage}</span>
        <button onClick={cerrarAlerta}>
          <img src={CloseIcon} alt="Cerrar Alerta" />
        </button>
      </div>
    </div>
  );
}

export default Register;
