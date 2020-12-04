"use strict";

var js = (function(){
    //private functions
    var filter_company = function() {
        var choice = $(".company_filter_content .form-control").val()
        $.ajax({type: 'GET',
            url: "/articles?filter=company&company=#{choice}#",
            timeout: 5000,
            success: function(result){
                alert(result.name);
            },
            error: function(xhrObj , textStatus , exception) { alert('Error!');
            }
            // 'success' and 'error' functions will be passed 3 args
        });
    };
    
    var filter_industry = function() {
        var choice = $(".industry_filter_content .form-control").val()
        $.ajax({type: 'GET',
            url: "/articles?filter=industry_type&industry=#{choice}#",
            timeout: 5000,
            success: function(result){
                alert(result.name);
            },
            error: function(xhrObj , textStatus , exception) { alert('Error!');
            }
            // 'success' and 'error' functions will be passed 3 args
        });
    };
    
    var filter_location = function() {
        var state = $(".industry_filter_content .form-control_state").val();
        var city = $(".location_filter_content .form-control_city").val();
        $.ajax({type: 'GET',
            url: "/articles?filter=location&state=#{state}#$city=#{city}#",
            timeout: 5000,
            success: function(result){
                alert(result.name);
            },
            error: function(xhrObj , textStatus , exception) { alert('Error!');
            }
            // 'success' and 'error' functions will be passed 3 args
        });
    };
    
    var filter_salary = function() {
        var low = $(".salary_filter_content .form-control_low").val();
        var high = $(".salary_filter_content .form-control_high").val();
        $.ajax({type: 'GET',
            url: "/articles?filter=salary&low_salary=#{low}#&high_salary=#{high}#",
            timeout: 5000,
            success: function(result){
                alert(result.name);
            },
            error: function(xhrObj , textStatus , exception) { alert('Error!');
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