// $(document).on('turbolinks:load', function(){
//     $('#new_message').on('submit', function(e){
//       e.preventDefault();
//       var comment = new FormData(this);
//       var url = (window.location.href); // $(this).attr('action')でも可能です
//       $.ajax({  
//         url: url,
//         type: 'POST',
//         data: comment,
//         dataType: 'json',
//         processData: false,
//         contentType: false
//       })
//     })
//   });