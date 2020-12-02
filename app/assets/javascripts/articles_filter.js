$(".company_filter .btn btn-default btn-primary").click(function(){
    $.ajax({type: 'GET',
    url: '/articles',
    data: { company : $(".company_filter .form-control").val() },
    timeout: 5000,
    success: function(result){
        alert(result.name);
    },
    error: function(xhrObj , textStatus , exception) { alert('Error!');
    }
    // 'success' and 'error' functions will be passed 3 args
    }); 
    return(false);
});

$(".salary_filter #filter_submit").click(function(){
    $.ajax({type: 'GET',
    url: '/articles',
    data: { low_salary : $("#low_salary").val(),
        high_salary : $("#high_salary").val()
    },
    timeout: 5000,
    success: function(result){
        alert(result.name);
    },
    error: function(xhrObj , textStatus , exception) { alert('Error!');
    }
    // 'success' and 'error' functions will be passed 3 args
    });
    return(false);
});

$(".close").click(function(){
    //$(this).hide();
    return(false);
});