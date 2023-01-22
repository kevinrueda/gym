import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        $("#customers-datatable").dataTable({
            "retrieve": true,
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": $("#customers-datatable").data("source")
            },
            "columns": [
                {
                    "data": "",
                    "className": "dtr-control",
                    "defaultContent": "",
                    "orderable": false
                },
                {"data": "id"},
                {
                    data: "status",
                    render: function (data) {
                        if (data != 'false') {
                            return '<td><span class="fas fa-check-circle fa-2x text-success"></span></td>'
                        } else {
                            return '<td><span class="fas fa-times-circle fa-2x text-danger"></span></td>'
                        }
                    }
                },
                {"data": "name"},
                {"data": "phone"},
                {"data": "created_at"},
                {"data": "actions", "orderable": false, "width": "10%"}
            ],
            "order": [[1, "desc"]]
        });
    }
}