// Entrypoint for the esbuild command defined in package.json scripts

window.$ = window.jQuery = require('jquery/dist/jquery');

const dt = require("admin-lte/plugins/datatables/jquery.dataTables.min")();
require("datatables.net-responsive-bs4/js/responsive.bootstrap4.min")();
window.Swal = require("admin-lte/plugins/sweetalert2/sweetalert2.min");
require("admin-lte/plugins/select2/js/select2.min")();
require("admin-lte/plugins/jquery-ui/jquery-ui.min");
require("admin-lte/dist/js/adminlte.min");
require("admin-lte/plugins/bootstrap/js/bootstrap.bundle.min");
require("admin-lte/plugins/moment/moment.min");
import {Calendar} from '@fullcalendar/core';
window.Calendar = Calendar
import dayGridPlugin from '@fullcalendar/daygrid';

$.fn.select2.defaults.set("theme", "bootstrap4");
$.fn.select2.defaults.set("width", "100%");
import "./controllers"

$.extend(true, $.fn.dataTable.defaults, {
    "language": {
        "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Spanish.json"
    },
    "responsive": true
});

$(document).ready(function () {
    $('.select2').select2();
});
