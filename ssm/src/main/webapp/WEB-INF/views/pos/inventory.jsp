<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inventory List</title>
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
    <h1>Inventory List</h1>
    <table>
        <thead>
            <tr>
                <th>Inventory No</th>
                <th>Goods No</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="inventory" items="${inventoryList}">
                <tr>
                    <td>${inventory.inventoryNo}</td>
                    <td>${inventory.goodsNo}</td>
                    <td>${inventory.quantity}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
