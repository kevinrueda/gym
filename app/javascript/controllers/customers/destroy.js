import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['row'];

    destroy(e) {
        e.preventDefault()
        let url = event.currentTarget.getAttribute("href")
        Swal.fire({
            title: '¿Estás seguro?',
            text: 'No podrás revertir los cambios!',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            cancelButtonText: 'Cancelar',
            confirmButtonText: 'Si, eliminar!'
        }).then(function (result) {
            if (result.value) {
                $.ajax({
                    headers: {
                        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
                    },
                    type: 'DELETE',
                    url: url,
                    success: function () {
                        let clientes = $('#customers-datatable').DataTable();
                        clientes.ajax.reload(null, false);
                        Swal.fire(
                            'Eliminado!',
                            'El Cliente fue eliminado.',
                            'success',
                        )
                    },
                    error: function () {
                        Swal.fire("Ocurrió un error");
                    }
                })
            }
        })
    }
}