<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menu List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            color: #333;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Menu List</h1>
    <table>
        <thead>
            <tr>
                <th>Menu No</th>
                <th>Menu Name</th>
                <th>Price</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="menu" items="${menuList}">
                <tr>
                    <td>${menu.menuNo}</td>
                    <td>${menu.menuName}</td>
                    <td>${menu.price}</td>
                    <td>${menu.description}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
