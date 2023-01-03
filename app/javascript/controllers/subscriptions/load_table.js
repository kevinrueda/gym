import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        $("#subscriptions-datatable").dataTable({
            "retrieve": true,
            "processing": true,
            "serverSide": false,
            "ajax": {
                "url": $("#subscriptions-datatable").data("source")
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
                    data: "is_active",
                    render: function (data) {
                        if (data == 'true') {
                            return '<td><span class="fas fa-check-circle fa-2x text-success"></span></td>'
                        } else {
                            return '<td><span class="fas fa-times-circle fa-2x text-danger"></span></td>'
                        }
                    }
                },
                {"data": "customer"},
                {"data": "plan"},
                {"data": "start_sub"},
                {"data": "end_sub"},
                {"data": "actions", "orderable": false, "width": "10%"}
            ],
            "order": [[1, "desc"]]
        });
    }
}