<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>

	<h1>Registro de usuarios</h1>
	
	  <div class="row justify-content-center mb-5">
            <div class="col-6">

                    <form action="registro" method="post">
                    
                 		<input type="hidden" name="accion" value="guardar">
                 		<input type="hidden" id="id" name="id" value="${usuario.id}">

                        <div class="form-group">
                            <label for="nombre">Nombre</label>
                            <input type="text" 
                                   class="form-control"
                                   name="nombre"
                                   id="nombre" 
                                   value="${usuario.nombre}"
                                   placeholder="Mínimo 2 Máximo 150"
                                   aria-describedby="nombreHelp">
                            <small id="nombreHelp" class="form-text text-muted">Nombre del producto</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="descripcion">Contraseña</label>
                            <input type="text" 
                                   class="form-control"
                                   name="password"
                                   id="password" 
                                   value="${usuario.contrasenia}"     
                                   placeholder="Mínimo 2 Máximo 150"
                                   aria-describedby="nombreHelp">
                            <input type="hidden" name="contraseniaMD5" id="contraseniaMD5">
                            <small id="nombreHelp" class="form-text text-muted">Contraseña del usuario</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="imagen">Imagen de perfil</label>
                            <input type="url" 
                                   class="form-control"
                                   name="imagen"
                                   id="imagen" 
                                   value="${usuario.imagen}"
                                   aria-describedby="imagenHelp">
                            <small id="nombreHelp" class="form-text text-muted">Imagen del producto</small>
                        </div>
                        
                        <button type="submit" class="btn btn-block btn-outline-primary" onclick="calcMD5()">Crear usuario</button> 
                    
                    </form>

            </div>
        </div>  

<%@ include file="/includes/footer.jsp"%>