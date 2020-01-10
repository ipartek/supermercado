<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>   
    	
	
	<a href="seguridad/usuarios?accion=formulario">Crear Usuario</a>
	
	<table  class="tabla display" style="width:100%">
        <thead>
            <tr>
                <th>Id</th>                
                <th>Nombre</th>
                <th>Rol</th>
                <th>Editar</th>                
            </tr>
        </thead>
        <tbody>
        	<c:forEach items="${usuarios}" var="u">
            	<tr>
                	<td>${u.id}</td>
                	<td>${u.nombre }</td>
                	<td>${u.rol.nombre}</td>
                	<td><a href="seguridad/usuarios?accion=formulario&id=${p.id}">Editar</a></td>
            	</tr>
            </c:forEach>	
        </tbody>    
    </table>
	
	

<%@ include file="/includes/footer.jsp" %> 