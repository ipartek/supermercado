 </main>

    <div class="footer-wrapper">
        <footer class="container py-5">
            <div class="row">
                <div class="col-12 col-md">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="d-block mb-2" role="img" viewBox="0 0 24 24" focusable="false"><title>Product</title><circle cx="12" cy="12" r="10"/><path d="M14.31 8l5.74 9.94M9.69 8h11.48M7.38 12l5.74-9.94M9.69 16L3.95 6.06M14.31 16H2.83m13.79-4l-5.74 9.94"/></svg>
                    <small class="d-block mb-3 text-muted">&copy; 2019</small>
                </div>
    
                <div class="col-6 col-md offset-6">
                    <h5>Enlaces de Interes</h5>
                    <ul class="list-unstyled text-small">
                        <li><a class="text-muted" href="politica-privacidad.html">Politica Privacidad</a></li>
                        <li><a class="text-muted" href="localizacion.html">Localizaci�n</a></li>
                        <li><a class="text-muted" href="contacto.html">Contacto</a></li>                    
                    </ul>
                </div>

            </div>    
        </footer>
    </div>    

    <a id="btn-top" href="#top" class="btn btn-primary">top</a>

    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>    
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    
    <!-- Llamamos el script de encriptaci�n MD5 desde la p�gina de Paul Johnston -->
	<script src="http://pajhome.org.uk/crypt/md5/2.2/md5-min.js"></script>
    
    <script>
	    $(document).ready(function() {
	        $('.tabla').DataTable();
	    } );
    </script>
    
    <!-- Funci�n para convertir la cadena a MD5 e imprimirla -->
	<script type="text/javascript">
		function calcMD5(){
			var passwordMD5 = document.getElementById('nombre').value + document.getElementById('password').value;
			document.getElementById('contraseniaMD5').value = hex_md5(passwordMD5);
		}
	</script>

    </body>

</html>
