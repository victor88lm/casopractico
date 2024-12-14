// Función para manejar las acciones del formulario (add, edit, delete)
function handleAction(action) {
    const form = document.querySelector('form');
    const idEquipo = form.querySelector('[name="idEquipo"]');
    const marca = form.querySelector('[name="marca"]');
    const modelo = form.querySelector('[name="modelo"]');
    const precio = form.querySelector('[name="precio"]');

    if (!marca.value || !modelo.value || !precio.value) {
        alert('Todos los campos son obligatorios');
        return;
    }

    // Si la acción es eliminar, preguntamos al usuario si está seguro
    if (action === 'delete') {
        if (confirm('¿Estás seguro de que quieres eliminar este equipo?')) {
            form.submit(); // Si es eliminar, enviamos el formulario
        }
    } else {
        // Si es agregar o editar, enviamos el formulario
        form.querySelector('[name="action"]').value = action;
        form.submit();
    }
}

// Función para llenar el formulario cuando se hace clic en editar
function editEquipo(idEquipo, marca, modelo, precio) {
    const form = document.querySelector('form');
    form.querySelector('[name="idEquipo"]').value = idEquipo;
    form.querySelector('[name="marca"]').value = marca;
    form.querySelector('[name="modelo"]').value = modelo;
    form.querySelector('[name="precio"]').value = precio;
}
