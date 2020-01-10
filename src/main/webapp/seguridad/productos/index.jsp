<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/includes/header.jsp"%>


<a href="seguridad/productos?accion=formulario">Nuevo Producto</a>

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

.project-tab .tab-pane{
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
							por activar</a>
					</div>
				</nav>
				<div class="tab-content" id="nav-tabContent">
					<div class="tab-pane fade show active" id="nav-home"
						role="tabpanel" aria-labelledby="nav-home-tab">
						<table class="tabla display" style="width: 100%">
							<thead>
								<tr>
									<th>id</th>
									<th>nombre</th>
									<th>usuario</th>
									<th>Editar</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${productos}" var="p">
									<tr>
										<td>${p.id}</td>
										<td>${p.nombre }</td>
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
						<table class="table" cellspacing="0">
							<thead>
								<tr>
									<th>Project Name</th>
									<th>Employer</th>
									<th>Time</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><a href="#">Work 1</a></td>
									<td>Doe</td>
									<td>john@example.com</td>
								</tr>
								<tr>
									<td><a href="#">Work 2</a></td>
									<td>Moe</td>
									<td>mary@example.com</td>
								</tr>
								<tr>
									<td><a href="#">Work 3</a></td>
									<td>Dooley</td>
									<td>july@example.com</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="tab-pane fade" id="nav-contact" role="tabpanel"
						aria-labelledby="nav-contact-tab">
						<table class="table" cellspacing="0">
							<thead>
								<tr>
									<th>Contest Name</th>
									<th>Date</th>
									<th>Award Position</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><a href="#">Work 1</a></td>
									<td>Doe</td>
									<td>john@example.com</td>
								</tr>
								<tr>
									<td><a href="#">Work 2</a></td>
									<td>Moe</td>
									<td>mary@example.com</td>
								</tr>
								<tr>
									<td><a href="#">Work 3</a></td>
									<td>Dooley</td>
									<td>july@example.com</td>
								</tr>
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
