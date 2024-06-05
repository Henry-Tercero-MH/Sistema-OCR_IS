const express = require("express");
const mysql = require("mysql2");
const cors = require("cors");

const app = express();
const port = 3001;

// Permitir CORS
app.use(cors());

// Configuración de la conexión a la base de datos
const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "admin",
  database: "farmacia",
});

connection.connect((error) => {
  if (error) {
    console.error("Error conectando a la base de datos:", error);
    return;
  }
  console.log("Conectado a la base de datos MySQL");
});

app.get("/api/user", (req, res) => {
  const email = req.query.email;
  const password = req.query.password;

  if (!email || !password) {
    res.status(400).send("Faltan parámetros de consulta");
    return;
  }

  console.log("Consulta a la base de datos - Usuarios:");
  console.log("Email:", email);
  console.log("Password:", password);

  const query = "SELECT * FROM users WHERE email = ? AND password = ?";
  const queryParams = [email, password];

  connection.query(query, queryParams, (error, results) => {
    if (error) {
      console.error("Error en la consulta:", error);
      res.status(500).send("Error en la consulta");
      return;
    }

    if (results.length > 0) {
      res.json(results[0]);
    } else {
      res.status(401).send("Credenciales incorrectas");
    }
  });
});

app.get("/api/product", (req, res) => {
  const texto = req.query.texto;
  const palabras = texto
    .split(" ") // Separar las palabras por espacios
    .map((palabra) => palabra.trim())
    .filter((palabra) => palabra.length > 0);

  if (palabras.length === 0) {
    res.status(400).send("No se proporcionaron palabras para buscar");
    return;
  }

  console.log("Consulta a la base de datos - Productos:");
  console.log("Palabras de búsqueda:", palabras);

  const likeClauses = palabras
    .map((palabra) => `product_name LIKE ?`)
    .join(" OR ");
  const query = `SELECT * FROM product WHERE ${likeClauses}`;
  const queryParams = palabras.map((palabra) => `%${palabra}%`);

  connection.query(query, queryParams, (error, results) => {
    if (error) {
      console.error("Error en la consulta:", error);
      res.status(500).send("Error en la consulta");
      return;
    }

    console.log("Resultados de la consulta de productos:", results);

    // Filtrar resultados para devolver solo coincidencias exactas
    const palabrasUnicas = new Set(
      palabras.map((palabra) => palabra.toLowerCase())
    );
    const resultadosFiltrados = results.filter((product) => {
      const nombreProducto = product.product_name.toLowerCase();
      return Array.from(palabrasUnicas).some((palabra) =>
        nombreProducto.includes(palabra)
      );
    });

    console.log("Resultados filtrados de productos:", resultadosFiltrados);

    res.json(resultadosFiltrados);
  });
});

app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});
