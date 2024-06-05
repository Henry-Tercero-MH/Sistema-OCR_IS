import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import "../Login/reset.css";
import "../Login/Login.css";
import ShowIcon from "./img/Show Password_1.ico";
import HideIcon from "./img/Hide.ico";
import CloseIcon from "./img/Show Password_1.ico";

function Login() {
  const navigate = useNavigate();
  const [passwordShown, setPasswordShown] = useState(false);
  const [alertMessage, setAlertMessage] = useState("");

  const togglePassword = () => {
    setPasswordShown(!passwordShown);
  };

  const mostrarAlerta = (mensaje) => {
    setAlertMessage(mensaje);
    const alertElement = document.getElementById("custom-alert");
    alertElement.style.display = "block";
  };

  const cerrarAlerta = () => {
    const alertElement = document.getElementById("custom-alert");
    alertElement.style.display = "none";
  };

  const handleLogin = async (e) => {
    e.preventDefault();
    const email = e.target.username.value;
    const password = e.target.password.value;

    try {
      const response = await fetch(
        `http://localhost:3001/api/user?email=${encodeURIComponent(
          email
        )}&password=${encodeURIComponent(password)}`
      );

      if (!response.ok) {
        throw new Error("Error al iniciar sesión");
      }
      const userData = await response.json();

      if (userData) {
        navigate("/app");
      } else {
        mostrarAlerta("Credenciales incorrectas");
      }
    } catch (error) {
      console.error("Error al iniciar sesión:", error);
      mostrarAlerta("Credenciales Incorrectas... ");
    }
  };

  return (
    <div className="login-container">
      <h2 alt="Bienvenido">
        {" "}
        <i class="material-icons">account_circle</i>
        <p>Bienvenido</p>
      </h2>
      <form onSubmit={handleLogin}>
        <div className="input-group">
          <label htmlFor="username">Usuario:</label>
          <input
            type="text"
            id="username"
            name="username"
            required
            placeholder="example@gmail.com"
          />
        </div>
        <div className="input-group">
          <label htmlFor="password">Contraseña:</label>
          <div className="password-input-container">
            <input
              type={passwordShown ? "text" : "password"}
              id="password"
              name="password"
              required
            />
            <img
              className="bx"
              src={passwordShown ? HideIcon : ShowIcon}
              alt="Toggle Password Visibility"
              onClick={togglePassword}
            />
          </div>
        </div>
        <div className="container-botones">
          <button className="btnEnviar" type="submit" alt="Login">
            <i className="material-icons">login</i>
          </button>
          <button
            className="btnCrear"
            type="button"
            onClick={() => navigate("/register")}
          >
            {" "}
            <i className="material-icons">person_add</i>
          </button>
        </div>
        <p className="recuperar-contraseña">¿Olvidó su Contraseña?</p>
      </form>

      <div id="custom-alert" className="custom-alert">
        <span id="alert-message">{alertMessage}</span>
        <button onClick={cerrarAlerta}>
          <img src={CloseIcon} alt="Cerrar Alerta" />
        </button>
      </div>
    </div>
  );
}

export default Login;
