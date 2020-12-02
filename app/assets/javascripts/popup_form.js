$("#company").click(function(){
    $.ajax({type: 'GET',
    url: '/articles',
    dataType: 'json',
    data: { filter : 'company' },
    timeout: 5000,
    success: function(result){
        alert(result.name);
    },
    error: function(xhrObj , textStatus , exception) { alert('Error!');
    }
    // 'error' function will be passed 3 args
    }); 
    $(".company_filter").show();
    return(false);
});