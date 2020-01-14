<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>

	<h1>FORMULARIO</h1>

	<c:if test="${categoria.id == 0}">
		<h3>Nueva Categoria</h3>
	</c:if>
	<c:if test="${categoria.id > 0}">
		<h3>Editar Categoria</h3>
	</c:if>
	<c:if test="${not empty mensajeAlerta }"/>

	<div class="row justify-content-center">
            <div class="col-4 mt-5 bg-warn">

                    <form action="seguridad/categorias" method="post">


                        <div class="form-group">
                            <label for="id">id</label>
                            <input type="text" value="${categoria.id}" class="form-control" name="id" readonly required>
                        </div>

                        <div class="form-group">
                            <label for="nombre">Nombre</label>
                            <input type="text"
                           			autofocus
                            	   value="${categoria.nombre}"
                                   class="form-control"
                                   name="nombre"
                                   required
                                   placeholder="Mínimo 2 Máximo 50"
                                   pattern=".{2,50}">
                        </div>

                        <input type="text" hidden name="accion" value="guardar">

                        <button type="submit" class="btn btn-block btn-outline-primary mb-4">Listo</button>

                    </form>
					<c:if test="${categoria.id > 0}">

						<!-- Button trigger modal -->
						<button type="button" class="btn btn-outline-danger mb-5" data-toggle="modal" data-target="#exampleModal">
						  Eliminar
						</button>

						<!-- Modal -->
						<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
						  <div class="modal-dialog" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="exampleModalLabel">Eliminar</h5>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body">
						       ¿Esta seguro de que quiere eliminar la categoria : <span style="color: red;">${categoria.nombre}</span>?
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-dismiss="modal">cerrar</button>
						        <a class="btn btn-danger" href="seguridad/s?id=${categoria.id}&accion=eliminar" style="margin-top: 5px">Eliminar</a>
						      </div>
						    </div>
						  </div>
						</div>
					</c:if>
            </div>
        </div>

<%@ include file="/includes/footer.jsp" %>