<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="includes/header.jsp" %>   


	<div class="row justify-content-center">
		<div class="col-4 mt-5">
		
				<form action="login" method="post">
				
					 <div class="form-group">
					    <label for="nombre">Nombre:</label>
					    <input type="text" class="form-control" name="nombre" id="nombre" required autofocus>					    
					 </div>					
					 
					 <div class="form-group">
					    <label for="contrasenya">Contraseña:</label>
					    <input type="password" class="form-control" name="contrasenya" id="password" required>
					    <input type="hidden" name="contraseniaMD5" id="contraseniaMD5">					    
					 </div>
					
					 <button type="submit" class="btn btn-block btn-primary" onclick="calcMD5()">Entrar</button>
				
				</form>	
		
		</div>
	</div>

	


<%@ include file="includes/footer.jsp" %> 