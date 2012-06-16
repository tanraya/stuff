$(function () {
  'use strict';
  var counter    = 0;
  var fileupload = $('#fileupload');

  // Initialize the jQuery File Upload widget:
  fileupload.fileupload({
    autoUpload : true,
    url        : '/attachments'
  }).bind('fileuploaddone', function (e, data) {
    $(document.createElement('input'))
        .attr('type', 'hidden')
        .attr('name', 'upload[attachments_attributes][' + counter + '][attachment_id]')
        .attr('value', data.result[0].attachment_id)
        .appendTo(fileupload);

    counter++;
  });

  // Load existing files:
  /*
  $('#fileupload').each(function () {
    var that = this;
    $.getJSON(this.action, function (result) {
        if (result && result.length) {
            $(that).fileupload('option', 'done')
                .call(that, null, {result: result});
        }
    });
  });*/
});
