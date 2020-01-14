<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>   
    	
	<h1> Datos del usuario </h1>
	
	  <div class="row justify-content-center mb-5">
            <div class="col-6">

                    <form action="mipanel/usuarios" method="post">
                    
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
                                   aria-describedby="nombreHelp"
                                   readonly>
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
                            <small id="nombreHelp" class="form-text text-muted">Contraseña del usuario</small>
                        </div>   
                        
                        <div class="form-group">
                            <label for="descripcion">Confirmar Contraseña</label>
                            <input type="text" 
                                   class="form-control"
                                   name="password-confirm"
                                   id="password-confirm" 
                                   value=""     
                                   placeholder="Mínimo 2 Máximo 150"
                                   aria-describedby="nombreHelp">
                            <small id="nombreHelp" class="form-text text-muted">Contraseña del usuario</small>
                        </div>      
                        
                        <div class="form-group">
                            <label for="imagen"> Avatar</label>
                            <input type="url" 
                                   class="form-control"
                                   name="imagen"
                                   id="imagen" 
                                   value="${usuario.imagen}"
                                   placeholder="URL (.JPG, .JPEG, .PNG)"
                                   aria-describedby="nombreHelp">
                            <small id="nombreHelp" class="form-text text-muted">Avatar de usuario</small>
                        </div>             
                     
                       <button type="submit" class="btn btn-block btn-primary">Modificar usuario</button>           		                    
  
                    </form>

            </div>
        </div>  

<%@ include file="/includes/footer.jsp" %> 