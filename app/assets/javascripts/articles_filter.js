"use strict";

var js = (function(){
    //private functions
    var filter_company = function() {
        var choice = $(".company_filter_content .form-control").val()
        $.ajax({type: 'GET',
            url: '/articles?filter=company&company='+choice,
            timeout: 5000,
            dataType: "html",
            complete: function(xhrObj , textStatus , exception){
                alert("Complete");
                console.log(xhrObj.responseText);
                $('.company_list').html(xhrObj.responseText);
                $('#submit_company')[0].reset();
                $(".company_filter").css("visibility", "hidden");
            }
            // error: function(xhrObj , textStatus , exception) { 
            //     alert('Error!');
            //     console.log(xhrObj)
            // }
            // 'success' and 'error' functions will be passed 3 args
        });
    };
    
    var filter_industry = function() {
        var choice = $(".industry_filter_content .form-control").val()
        $.ajax({type: 'GET',
            url: "/articles?filter=industry_type&industry="+choice,
            timeout: 5000,
            dataType: "html",
            complete: function(xhrObj , textStatus , exception){
                alert("Complete");
                console.log(xhrObj.responseText);
                $('.company_list').html(xhrObj.responseText);
                $('#submit_industry')[0].reset();
                $(".industry_filter").css("visibility", "hidden");
            }
            // 'success' and 'error' functions will be passed 3 args
        });
    };
    
    var filter_location = function() {
        var state = $(".location_filter_content #state .form-control").val();
        var city = $(".location_filter_content #city .form-control").val();
        $.ajax({type: 'GET',
            url: "/articles?filter=location&state="+state+"&city="+city,
            timeout: 5000,
            dataType: "html",
            complete: function(xhrObj , textStatus , exception){
                alert("Complete");
                console.log(xhrObj.responseText);
                $('.company_list').html(xhrObj.responseText);
                $('#submit_location')[0].reset();
                $(".location_filter").css("visibility", "hidden");
            }
            // 'success' and 'error' functions will be passed 3 args
        });
    };
    
    var filter_salary = function() {
        var low = $(".salary_filter_content #low .form-control").val();
        var high = $(".salary_filter_content #high .form-control").val();
        $.ajax({type: 'GET',
            url: "/articles?filter=salary&low_salary="+low+"&high_salary="+high,
            timeout: 5000,
            dataType: "html",
            complete: function(xhrObj , textStatus , exception){
                alert("Complete");
                console.log(xhrObj.responseText);
                $('.company_list').html(xhrObj.responseText);
                $('#submit_salary')[0].reset();
                $(".salary_filter").css("visibility", "hidden");
            }
            // 'success' and 'error' functions will be passed 3 args
        });
    };
    
    return {
        init: function() {
            // any initialization code goes here, such as adding
            // event handlers
            $("#submit_company").on("ajax:success", filter_company);
            $("#submit_salary").on("ajax:success", filter_salary);
            $("#submit_industry").on("ajax:success", filter_industry);
            $("#submit_location").on("ajax:success", filter_location);
        },
    };
})();
    
$(js.init);