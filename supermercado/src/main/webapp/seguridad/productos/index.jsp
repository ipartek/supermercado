
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/header.jsp" %>   
    	
	
	<a href="seguridad/productos?accion=formulario">Nuevo Producto</a>
	
	<table  class="tabla display" style="width:100%">
        <thead class="thead-dark">
				<tr>
					<th>ID</th>
					<th>NOMBRE</th>
					<th>IMAGEN</th>
					<th>PRECIO</th>
					<th>DESCRIPCIÓN</th>
					<th>DESCUENTO</th>
					<th>USUARIO</th>
					<th>CATEGORIA</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${productos}" var="p">
					<tr>
						<td>${p.id}</td>
						<td>${p.nombre}</td>
						<td class="producto"><img src="${p.imagen }" alt="imagen del producto ${p.imagen }" /></td>
						<td>${p.precio } €</td>
						<td>${p.descripcion }</td>
						<td>${p.descuento }%</td>
						<td>${p.usuario.nombre}
						<td>${p.categoria.nombre }</td>
						<td><a href="seguridad/productos?accion=formulario&id=${p.id}">Editar</a></td>
			
					</tr>
				</c:forEach>
			</tbody>
		
	</table>	
	
	

<%@ include file="/includes/footer.jsp" %> 