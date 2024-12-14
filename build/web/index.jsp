<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %> <!-- Importa tu clase de conexión -->
<%
    // Conexión a la base de datos utilizando la clase DBConnection
    Connection conn = null;
    try {
        conn = DBConnection.getConnection(); // Usa tu clase de conexión
    } catch (SQLException e) {
        out.println("<p>Error al conectar con la base de datos: " + e.getMessage() + "</p>");
    }

    // Operaciones CRUD
    String action = request.getParameter("action");
    if (conn != null && action != null) {
        String idEquipo = request.getParameter("idEquipo");
        String marca = request.getParameter("marca");
        String modelo = request.getParameter("modelo");
        String precio = request.getParameter("precio");

        try {
            Statement stmt = conn.createStatement();

            if (action.equals("add")) {
                stmt.executeUpdate("INSERT INTO Equipos (marca, modelo, precio) VALUES ('" + marca + "', '" + modelo + "', " + precio + ")");
            } else if (action.equals("edit")) {
                stmt.executeUpdate("UPDATE Equipos SET marca='" + marca + "', modelo='" + modelo + "', precio=" + precio + " WHERE idEquipo=" + idEquipo);
            } else if (action.equals("delete")) {
                stmt.executeUpdate("DELETE FROM Equipos WHERE idEquipo=" + idEquipo);
            }
        } catch (SQLException e) {
            out.println("<p>Error al ejecutar operación: " + e.getMessage() + "</p>");
        }
    }

    // Consultar equipos
    ResultSet rs = null;
    if (conn != null) {
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM Equipos");
        } catch (SQLException e) {
            out.println("<p>Error al consultar equipos: " + e.getMessage() + "</p>");
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Gestión de Equipos</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid black; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
    </style>
    <link rel="stylesheet" type="text/css" href="src/css/styles.css">
</head>
<body>
    <h1>Gestión de Equipos</h1>

    <!-- Formulario para Registrar un equipo -->
    <h2>Registrar Nuevo Equipo</h2>
    <form action="index.jsp" method="post">
        <label>Marca:</label><input type="text" name="marca" required />
        <label>Modelo:</label><input type="text" name="modelo" required />
        <label>Precio:</label><input type="number" name="precio" required />
        <button type="submit" name="action" value="add">Registrar</button>
    </form>

    <!-- Formulario para Editar un equipo (solo si se está editando) -->
    <% 
        String idEquipoEdit = request.getParameter("idEquipo");
        if (idEquipoEdit != null) {
            try {
                Statement stmt = conn.createStatement();
                ResultSet rsEdit = stmt.executeQuery("SELECT * FROM Equipos WHERE idEquipo=" + idEquipoEdit);
                if (rsEdit.next()) { 
    %>
    <h2>Actualizar Equipo</h2>
    <form action="index.jsp" method="post">
        <input type="hidden" name="idEquipo" value="<%= rsEdit.getInt("idEquipo") %>" />
        <label>Marca:</label><input type="text" name="marca" value="<%= rsEdit.getString("marca") %>" required />
        <label>Modelo:</label><input type="text" name="modelo" value="<%= rsEdit.getString("modelo") %>" required />
        <label>Precio:</label><input type="number" name="precio" value="<%= rsEdit.getInt("precio") %>" required />
        <button type="submit" name="action" value="edit">Actualizar</button>
    </form>
    <% 
                }
            } catch (SQLException e) {
                out.println("<p>Error al consultar equipo para edición: " + e.getMessage() + "</p>");
            }
        }
    %>

    <h2>Lista de Equipos</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Marca</th>
            <th>Modelo</th>
            <th>Precio</th>
            <th>Acciones</th>
        </tr>
        <% while (rs != null && rs.next()) { %>
        <tr>
            <td><%= rs.getInt("idEquipo") %></td>
            <td><%= rs.getString("marca") %></td>
            <td><%= rs.getString("modelo") %></td>
            <td><%= rs.getInt("precio") %></td>
            <td>
                <!-- Formulario para Editar -->
                <form action="index.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="idEquipo" value="<%= rs.getInt("idEquipo") %>" />
                    <button type="submit">Editar</button>
                </form>
                <!-- Formulario para Eliminar -->
                <form action="index.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="idEquipo" value="<%= rs.getInt("idEquipo") %>" />
                    <button type="submit" name="action" value="delete" onclick="return confirm('¿Estás seguro de eliminar este equipo?');">Eliminar</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
