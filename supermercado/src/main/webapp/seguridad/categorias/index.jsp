<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>   
    	
	
	<a href="seguridad/categorias?accion=formulario">Nueva categoría</a>
	
	<table  class="tabla display" style="width:100%">
        <thead>
            <tr>
                <th>ID</th>                
                <th>Nombre</th>
                <th>Editar</th>                
            </tr>
        </thead>
        <tbody>
        	<c:forEach items="${categorias}" var="c">
            	<tr>
                	<td>${c.id}</td>
                	<td>${c.nombre }</td>
                	<td><a href="seguridad/categorias?accion=formulario&id=${c.id}">Editar</a></td>
            	</tr>
            </c:forEach>	
        </tbody>    
    </table>
	
	

<%@ include file="/includes/footer.jsp" %> 