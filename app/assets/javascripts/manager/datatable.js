function initDataTableTheater(){
  $("#dataTable").DataTable({
   destroy: true,
   order: [],
   "aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
  });
}

$(document).ready(function() {
  $("#dataTable").DataTable();
  initDataTableTheater();
});
