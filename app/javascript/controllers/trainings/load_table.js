import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        $("#trainings-datatable").dataTable({
            "retrieve": true,
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": $("#trainings-datatable").data("source")
            },
            "columns": [
                {
                    "data": "",
                    "className": "dtr-control",
                    "defaultContent": "",
                    "orderable": false
                },
                {"data": "number"},
                {"data": "start"},
                {"data": "actions", "orderable": false, "width": "10%"}
            ],
            "order": [[1, "asc"]]
        });
    }
}