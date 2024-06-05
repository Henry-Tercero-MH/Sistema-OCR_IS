import React, { useState, useRef } from "react";
import { jsPDF } from "jspdf";
import "jspdf-autotable";
import { useNavigate } from "react-router-dom";
import Tesseract from "tesseract.js";
import "../src/App.css";
import logoPDf from "./imagenes/picture_as_pdf_24dp.png";
import scanSound from "./imagenes/audio.mp3"; // Importa el archivo de sonido

function App() {
  const [imagenUrl, setImagenUrl] = useState("");
  const [resultadosTabla, setResultadosTabla] = useState([]);
  const [analizandoImagen, setAnalizandoImagen] = useState(false); // Estado para controlar si se está analizando una imagen
  const videoRef = useRef(null);
  const canvasRef = useRef(null);
  const navigate = useNavigate();
  const audioRef = useRef(new Audio(scanSound)); // Crea una referencia al sonido

  const handleTakePhoto = async () => {
    audioRef.current.play(); // Reproduce el sonido
    if (analizandoImagen) return; // Si ya se está analizando una imagen, salir de la función

    try {
      setAnalizandoImagen(true); // Establecer el estado como true al iniciar el proceso de análisis

      const stream = await navigator.mediaDevices.getUserMedia({ video: true });
      const video = videoRef.current;
      const canvas = canvasRef.current;
      const context = canvas.getContext("2d");

      video.srcObject = stream;
      video.play();

      setTimeout(() => {
        context.drawImage(video, 0, 0, canvas.width, canvas.height);
        stream.getTracks().forEach((track) => track.stop());

        canvas.toBlob((blob) => {
          const imagenUrl = URL.createObjectURL(blob);
          setImagenUrl(imagenUrl);
        }, "image/jpeg");
      }, 3000);
    } catch (error) {
      console.error("Error al acceder a la cámara:", error);
    } finally {
      setAnalizandoImagen(false); // Establecer el estado como false al finalizar el proceso de análisis
    }
  };

  const handleImageLoad = async () => {
    if (analizandoImagen) return; // Si ya se está analizando una imagen, salir de la función

    try {
      setAnalizandoImagen(true); // Establecer el estado como true al iniciar el proceso de análisis

      const { data } = await Tesseract.recognize(imagenUrl, "eng", {
        logger: (m) => console.log(m),
      });

      const palabras = data.text
        .toLowerCase() // Convertir a minúsculas
        .replace(/[^\w\s]/gi, " ") // Reemplazar caracteres especiales por espacio
        .split(/\s+/) // Dividir por espacios múltiples
        .map((palabra) => palabra.trim())
        .filter((palabra) => palabra.length > 2); // Eliminar palabras de menos de 3 caracteres

      buscarProductos(palabras.join(" ")); // Unir palabras con espacio para enviarlas como un solo string
      console.log("Palabras reconocidas por OCR:", palabras);
    } catch (error) {
      console.error("Error en el reconocimiento OCR:", error);
    } finally {
      setAnalizandoImagen(false); // Establecer el estado como false al finalizar el proceso de análisis
    }
  };

  const buscarProductos = async (texto) => {
    try {
      const response = await fetch(
        `http://localhost:3001/api/product?texto=${encodeURIComponent(texto)}`
      );
      if (!response.ok) {
        throw new Error("Error al buscar productos");
      }
      const data = await response.json();
      console.log("Resultados obtenidos de la base de datos:", data);
      setResultadosTabla(data);
    } catch (error) {
      console.error("Error al buscar productos:", error);
    }
  };

  const handleScan = () => {
    if (imagenUrl) {
      handleImageLoad();
    } else {
      alert("Por favor, capture una foto primero.");
    }
  };

  const generatePDF = () => {
    const doc = new jsPDF();
    doc.text("COTIMEDIC", 20, 10);

    const tableColumn = ["Nombre", "Precio"];
    const tableRows = [];

    let total = 0;

    resultadosTabla.forEach((item) => {
      const rowData = [item.product_name, `Q. ${item.mrp}`];
      tableRows.push(rowData);
      total += parseFloat(item.mrp);
    });

    if (tableRows.length === 0) {
      alert("No hay datos disponibles para generar la tabla.");
      return;
    }

    doc.autoTable({
      head: [tableColumn],
      body: tableRows,
      startY: 20,
    });

    doc.text(
      `Total: Q. ${total.toFixed(2)}`,
      14,
      doc.autoTable.previous.finalY + 10
    );

    doc.save("tabla.pdf");
  };

  return (
    <div className="container">
      <main className="box-videoEscaner">
        <div className="video-container">
          <div className="card-video">
            <video className="video-cam" ref={videoRef}></video>
            <canvas ref={canvasRef} style={{ display: "none" }}></canvas>
            <div className="scan-line"></div>
          </div>
          <div className="contenedor-btn">
            <button className="btn-capturar" onClick={handleTakePhoto}>
              Capturar
            </button>
            <button className="btn-scanner" onClick={handleScan}>
              Escanear
            </button>
            <button className="btn-pdf" onClick={generatePDF}>
              <img src={logoPDf} width="35px" alt="PDF" />
            </button>
            <button
              className="btn-salir"
              type="button"
              onClick={() => navigate("/")}
            >
              <i className="material-icons">home</i>
            </button>
          </div>
        </div>
      </main>
      <div className="content">
        <div className="tabla">
          <h2>COTIMEDIC</h2>
          <table>
            <thead>
              <tr>
                <th>Nombre</th>
                <th>Precio</th>
              </tr>
            </thead>
            <tbody>
              {resultadosTabla.map((resultado, index) => (
                <tr key={index}>
                  <td>{resultado.product_name}</td>
                  <td>Q. {resultado.mrp}</td>
                </tr>
              ))}
            </tbody>
            <tfoot>
              <tr>
                <td colSpan="2" style={{ textAlign: "right" }}>
                  Total: Q.{" "}
                  {resultadosTabla
                    .reduce((total, item) => total + parseFloat(item.mrp), 0)
                    .toFixed(2)}
                </td>
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
    </div>
  );
}

export default App;
