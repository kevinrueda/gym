import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        $("#plans-datatable").dataTable({
            "retrieve": true,
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": $("#plans-datatable").data("source")
            },
            "columns": [
                {
                    "data": "",
                    "className": "dtr-control",
                    "defaultContent": "",
                    "orderable": false
                },
                {"data": "name"},
                {"data": "price"},
                {"data": "number_days"},
                {"data": "actions", "orderable": false, "width": "10%"}
            ],
            "order": [[1, "asc"]]
        });
    }
}