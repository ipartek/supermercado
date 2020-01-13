<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pagina" value="inicio" scope="request"></c:set>

<%@ include file="includes/header.jsp" %>   
    	
    	
    	<div class="row contenedor-productos">
        
        	<c:forEach items="${productos}" var="p">

	            <div class="col">
	
	                <!-- producto -->
	                <div class="producto">
	                    <span class="descuento">${p.descuento}%</span>
	                    <div class="imagen-container">
	                    	   <img src="${p.imagen}" alt="imagen de ${p.nombre}">
	                    </div>
	                 
	
	                    <div class="body">
	                        <p>
	                            <span class="precio-descuento">	                            	
	                            	<fmt:formatNumber minFractionDigits="2" type="currency" currencySymbol="€" value="${p.precio}" />	                            
	                            </span>
	                            <span class="precio-original">
	                            	<fmt:formatNumber minFractionDigits="2" type="currency" currencySymbol="€" value="${p.precioDescuento}" />
	                            </span>
	                        </p>
	                        <p class="text-muted precio-unidad ">${p.nombre}</p>
	                        <p class="descripcion text-truncate">${p.descripcion}</p>
	                    </div>
	
	                    <div class="botones">
	                        <button class="minus">-</button>
	                        <input type="text" value="1">
	                        <button class="plus">+</button>
	                    </div>
	
	                    <button class="carro">añadir al carro</button>
	
	                </div>
	                <!-- /.producto -->
	
	            </div>  
	            <!-- /.col -->          
	
			</c:forEach>
           
        </div>
        <!-- row contenedor-productos -->

<%@ include file="includes/footer.jsp" %> 