# Karate API Automation – Petstore

## 📌 Descripción
Este proyecto automatiza pruebas de API utilizando **Karate DSL** sobre la API pública de **Petstore**.

Se validan los módulos:
- User
- Store

Incluye:
- Escenarios Happy Path
- Escenarios Unhappy Path
- Validación de status code
- Validación de response body
- Uso de tags
- Configuración centralizada (`karate-config.js`)
- Reporte HTML automático

---

## 🧪 ¿Qué valida la automatización?

### User
- Creación correcta de usuario (Happy Path)
- Búsqueda de usuario inexistente (Unhappy Path)

### Store
- Creación correcta de orden (Happy Path)
- Búsqueda de orden inexistente (Unhappy Path)

Se validan:
- Código HTTP
- Contenido del response
- Estructura JSON

---

## ⚙️ Requisitos
- Java 8+
- Maven
- IntelliJ (opcional)

---

## ▶️ Cómo ejecutar

Ejecutar todos los tests:
mvn test

Ejecutar solo Happy Path:
mvn test -Dkarate.options="--tags @happy"

Ejecutar solo Unhappy Path:
mvn test -Dkarate.options="--tags @unhappy"

---

## 📊 Reporte

Después de ejecutar:
target/karate-reports/karate-summary.html


Abrir en el navegador para ver el resultado de las pruebas.

---

## 🧠 Tecnologías usadas
- Karate DSL
- Maven
- JUnit5
- Gherkin

---

## 👨‍💻 Autor
Jonathan Angelo Revilla Arroyo

