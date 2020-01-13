<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/includes/header.jsp"%>


<!-- administracion 3 tablas -->

<style>
.project-tab nav {
	background-color: transparent;
}

.project-tab {
	padding: 10%;
	margin-top: -8%;
}

.project-tab #tabs {
	background: #007b5e;
	color: #eee;
}

.project-tab #tabs h6.section-title {
	color: #eee;
}

.project-tab #tabs .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active
	{
	color: #0062cc;
	background-color: transparent;
	border-color: transparent transparent #f3f3f3;
	border-bottom: 3px solid !important;
	font-size: 16px;
	font-weight: bold;
}

.project-tab .nav-link {
	border: 1px solid transparent;
	border-top-left-radius: .25rem;
	border-top-right-radius: .25rem;
	color: #0062cc;
	font-size: 16px;
	font-weight: 600;
}

.project-tab .nav-link:hover {
	border: 1px solid transparent;
}

.project-tab .tab-pane {
	padding: 10px;
}

.project-tab thead {
	background: #f3f3f3;
	color: #333;
}

.project-tab a {
	text-decoration: none;
	color: #333;
	font-weight: 600;
}
</style>

<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

<section id="tabs" class="project-tab">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<nav>
					<div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
						<a class="nav-item nav-link active" id="nav-home-tab"
							data-toggle="tab" href="#nav-home" role="tab"
							aria-controls="nav-home" aria-selected="true">Productos
							activos</a> <a class="nav-item nav-link" id="nav-profile-tab"
							data-toggle="tab" href="#nav-profile" role="tab"
							aria-controls="nav-profile" aria-selected="false">Productos
							inactivos</a> <a class="nav-item nav-link" id="nav-contact-tab"
							data-toggle="tab" href="#nav-contact" role="tab"
							aria-controls="nav-contact" aria-selected="false">Productos
							por validar</a>
					</div>
				</nav>
				<div class="tab-content" id="nav-tabContent">
					<div class="tab-pane fade show active" id="nav-home"
						role="tabpanel" aria-labelledby="nav-home-tab">
						<table class="table table-bordered text-center" id="dataTable"
							width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>Id</th>
									<th>Foto</th>
									<th>Nombre</th>
									<th>Precio</th>
									<th>Descripción</th>
									<th>Descuento</th>
									<th>Fecha Última Modificación</th>
									<th>Usuario</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th>Id</th>
									<th>Foto</th>
									<th>Nombre</th>
									<th>Precio</th>
									<th>Descripción</th>
									<th>Descuento</th>
									<th>Fecha Última Modificación</th>
									<th>Usuario</th>
								</tr>
							</tfoot>
							<tbody>
								<c:forEach items="${productos}" var="p">
									<tr>
										<td>${p.id}</td>
										<td><img class="img-thumbnail rounded-circle img-tabla"
											src="${p.imagen}"></td>
										<td>${p.nombre}</td>
										<td>${p.precio}</td>
										<td>${p.descripcion}</td>
										<td>${p.descuento}</td>
										<c:if test="${producto.fechaModificacion == null}">
											<td>${p.fechaCreacion}</td>
										</c:if>
										<c:if test="${producto.fechaModificacion != null}">
											<td>${p.fechaModificacion}</td>
										</c:if>
										<td>${p.usuario.nombre}</td>
										<td><a
											href="seguridad/productos?accion=formulario&id=${p.id}">Editar</a></td>
										<td><a
											href="seguridad/productos?accion=desactivar&id=${p.id}">Desvalidar</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="tab-pane fade" id="nav-profile" role="tabpanel"
						aria-labelledby="nav-profile-tab">
						<table class="table table-bordered text-center" id="dataTable"
							width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>Id</th>
									<th>Foto</th>
									<th>Nombre</th>
									<th>Precio</th>
									<th>Descripción</th>
									<th>Descuento</th>
									<th>Fecha Última Modificación</th>
									<th>Usuario</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th>Id</th>
									<th>Foto</th>
									<th>Nombre</th>
									<th>Precio</th>
									<th>Descripción</th>
									<th>Descuento</th>
									<th>Fecha Última Modificación</th>
									<th>Usuario</th>
								</tr>
							</tfoot>
							<tbody>
								<c:forEach items="${productosInactivos}" var="pI">
									<tr>
										<td>${pI.id}</td>
										<td><img class="img-thumbnail rounded-circle img-tabla"
											src="${pI.imagen}"></td>
										<td>${pI.nombre}</td>
										<td>${pI.precio}</td>
										<td>${pI.descripcion}</td>
										<td>${pI.descuento}</td>
										<td>${pI.fechaEliminacion}</td>
										<td>${pI.usuario.nombre}</td>
										<td><a
											href="seguridad/productos?accion=formulario&id=${pI.id}">Editar</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-center">
			<a href="seguridad/productos?accion=formulario&id=0"
				class="btn btn-primary">Nuevo Producto</a>
		</h6>
	</div>
	<div class="card-body">
		<div class="table-responsive">
			<section id="tabs" class="project-tab">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<nav>
								<div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
									<a class="nav-item nav-link active" id="nav-home-tab"
										data-toggle="tab" href="#nav-home" role="tab"
										aria-controls="nav-home" aria-selected="true">Productos
										activos</a> <a class="nav-item nav-link" id="nav-profile-tab"
										data-toggle="tab" href="#nav-profile" role="tab"
										aria-controls="nav-profile" aria-selected="false">Productos
										inactivos</a> <a class="nav-item nav-link" id="nav-contact-tab"
										data-toggle="tab" href="#nav-contact" role="tab"
										aria-controls="nav-contact" aria-selected="false">Productos
										por validar</a>
								</div>
							</nav>
							<div class="tab-content" id="nav-tabContent">
								<div class="tab-pane fade show active" id="nav-home"
									role="tabpanel" aria-labelledby="nav-home-tab">
									<table class="table table-bordered text-center" id="dataTable"
										width="100%" cellspacing="0">
										<thead>
											<tr>
												<th>Id</th>
												<th>Foto</th>
												<th>Nombre</th>
												<th>Precio</th>
												<th>Descripción</th>
												<th>Descuento</th>
												<th>Fecha Última Modificación</th>
												<th>Usuario</th>
											</tr>
										</thead>
										<tfoot>
											<tr>
												<th>Id</th>
												<th>Foto</th>
												<th>Nombre</th>
												<th>Precio</th>
												<th>Descripción</th>
												<th>Descuento</th>
												<th>Fecha Última Modificación</th>
												<th>Usuario</th>
											</tr>
										</tfoot>
										<tbody>
											<c:forEach items="${productos}" var="p">
												<tr>
													<td>${p.id}</td>
													<td><img
														class="img-thumbnail rounded-circle img-tabla"
														src="${p.imagen}"></td>
													<td>${p.nombre}</td>
													<td>${p.precio}</td>
													<td>${p.descripcion}</td>
													<td>${p.descuento}</td>
													<c:if test="${producto.fechaModificacion == null}">
														<td>${p.fechaCreacion}</td>
													</c:if>
													<c:if test="${producto.fechaModificacion != null}">
														<td>${p.fechaModificacion}</td>
													</c:if>
													<td>${p.usuario.nombre}</td>
													<td><a
														href="seguridad/productos?accion=formulario&id=${p.id}">Editar</a></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="tab-pane fade" id="nav-profile" role="tabpanel"
									aria-labelledby="nav-profile-tab">
									<table class="table table-bordered text-center" id="dataTable"
										width="100%" cellspacing="0">
										<thead>
											<tr>
												<th>Id</th>
												<th>Foto</th>
												<th>Nombre</th>
												<th>Precio</th>
												<th>Descripción</th>
												<th>Descuento</th>
												<th>Fecha Última Modificación</th>
												<th>Usuario</th>
											</tr>
										</thead>
										<tfoot>
											<tr>
												<th>Id</th>
												<th>Foto</th>
												<th>Nombre</th>
												<th>Precio</th>
												<th>Descripción</th>
												<th>Descuento</th>
												<th>Fecha Última Modificación</th>
												<th>Usuario</th>
											</tr>
										</tfoot>
										<tbody>
											<c:forEach items="${productosInactivos}" var="pI">
												<tr>
													<td>${pI.id}</td>
													<td><img
														class="img-thumbnail rounded-circle img-tabla"
														src="${pI.imagen}"></td>
													<td>${pI.nombre}</td>
													<td>${pI.precio}</td>
													<td>${pI.descripcion}</td>
													<td>${pI.descuento}</td>
													<td>${pI.fechaEliminacion}</td>
													<td>${pI.usuario.nombre}</td>
													<td><a
														href="seguridad/productos?accion=formulario&id=${pI.id}">Editar</a></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="tab-pane fade" id="nav-contact" role="tabpanel"
									aria-labelledby="nav-contact-tab">
									<table class="table table-bordered text-center" id="dataTable"
										width="100%" cellspacing="0">
										<thead>
											<tr>
												<th>Id</th>
												<th>Foto</th>
												<th>Nombre</th>
												<th>Precio</th>
												<th>Descripción</th>
												<th>Descuento</th>
												<th>Fecha Última Modificación</th>
												<th>Usuario</th>
											</tr>
										</thead>
										<tfoot>
											<tr>
												<th>Id</th>
												<th>Foto</th>
												<th>Nombre</th>
												<th>Precio</th>
												<th>Descripción</th>
												<th>Descuento</th>
												<th>Fecha Última Modificación</th>
												<th>Usuario</th>
											</tr>
										</tfoot>
										<tbody>
											<c:forEach items="${productosToValidate}" var="pV">
												<tr>
													<td>${pV.id}</td>
													<td><img
														class="img-thumbnail rounded-circle img-tabla"
														src="${pV.imagen}"></td>
													<td>${pV.nombre}</td>
													<td>${pV.precio}</td>
													<td>${pV.descripcion}</td>
													<td>${pV.descuento}</td>
													<c:if test="${pV.fechaModificacion == null}">
														<td>${pV.fechaCreacion}</td>
													</c:if>
													<c:if test="${pV.fechaModificacion != null}">
														<td>${pV.fechaModificacion}</td>
													</c:if>
													<td>${pV.usuario.nombre}</td>
													<td><a
														href="seguridad/productos?accion=formulario&id=${pV.id}">Editar</a></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane fade" id="nav-contact" role="tabpanel"
						aria-labelledby="nav-contact-tab">
						<table class="table table-bordered text-center" id="dataTable"
							width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>Id</th>
									<th>Foto</th>
									<th>Nombre</th>
									<th>Precio</th>
									<th>Descripción</th>
									<th>Descuento</th>
									<th>Fecha Última Modificación</th>
									<th>Usuario</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th>Id</th>
									<th>Foto</th>
									<th>Nombre</th>
									<th>Precio</th>
									<th>Descripción</th>
									<th>Descuento</th>
									<th>Fecha Última Modificación</th>
									<th>Usuario</th>
								</tr>
							</tfoot>
							<tbody>
								<c:forEach items="${productosToValidate}" var="pV">
									<tr>
										<td>${pV.id}</td>
										<td><img class="img-thumbnail rounded-circle img-tabla"
											src="${pV.imagen}"></td>
										<td>${pV.nombre}</td>
										<td>${pV.precio}</td>
										<td>${pV.descripcion}</td>
										<td>${pV.descuento}</td>
										<c:if test="${pV.fechaModificacion == null}">
											<td>${pV.fechaCreacion}</td>
										</c:if>
										<c:if test="${pV.fechaModificacion != null}">
											<td>${pV.fechaModificacion}</td>
										</c:if>
										<td>${pV.usuario.nombre}</td>
										<td><a
											href="seguridad/productos?accion=formulario&id=${pV.id}">Editar</a></td>
										<td><a
											href="seguridad/productos?accion=activar&id=${pV.id}">Validar</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
		</div>
	</div>
</div>
</section>

<!-- .................................................................................................... -->





<%@ include file="/includes/footer.jsp"%>
