<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>   
    	
	
	<a  class="btn btn-primary mb-4" href="seguridad/productos?accion=formulario">Nuevo Producto</a>
	
	<table  id="tablaProductos" class="display" style="width:100%">
        <thead>
            <tr>
                <th>id</th>                
                <th>nombre</th>
                <th>descripcion</th>
                <th>precio</th>
                <th>imagen</th>
                <th>descuento</th>
                <th>usuario</th>
                <th>Editar</th>                
            </tr>
        </thead>
        <tbody>
        	<c:forEach items="${productos}" var="p">
            	<tr>
                	<td>${p.id}</td>
                	<td>${p.nombre}</td>
                	<td>${p.descripcion}</td>
                	<td>${p.precio}</td>
                	<td><img src="${p.imagen}" alt="${p.nombre}" width="75" height="75" /></td>
                	<td>${p.descuento}</td>
                	<td>${p.usuario.nombre}</td>
                	<td><a  class="btn btn-primary" href="seguridad/productos?accion=formulario&id=${p.id}">Editar</a></td>
            	</tr>
            </c:forEach>	
        </tbody>    
    </table>
	
	

<%@ include file="/includes/footer.jsp" %> 