"use strict";

var js = (function(){
    //private functions
    var show_company_popup = function() {
        $.ajax({type: 'GET',
            url: '/articles?filter=company&popup=true',
            timeout: 5000,
            success: function(result){
                alert(result.name);
            },
            error: function(xhrObj , textStatus , exception) { alert('Error!');
            }
            // 'success' and 'error' functions will be passed 3 args
        }); 
        $(".company_filter").show();
        return(false);
    };
    var show_industry_popup = function() {
        $.ajax({type: 'GET',
            url: '/articles?filter=industry_type&popup=true',
            timeout: 5000,
            success: function(result){
                alert(result.name);
            },
            error: function(xhrObj , textStatus , exception) { alert('Error!');
            }
            // 'success' and 'error' functions will be passed 3 args
        }); 
        $(".industry_filter").show();
        return(false);
    };
    var show_salary_popup = function() {
        $(".salary_filter").show();
    };
    var show_location_popup = function() {
        $.ajax({type: 'GET',
            url: '/articles?filter=location&popup=true',
            timeout: 5000,
            success: function(result){
                alert(result.name);
            },
            error: function(xhrObj , textStatus , exception) { alert('Error!');
            }
            // 'success' and 'error' functions will be passed 3 args
        }); 
        $(".location_filter").show();
        return(false);
    };
    var hide_popup = function() {
        $(".filter").hide();
    };
    
    return {
        init: function() {
            // any initialization code goes here, such as adding
            // event handlers
            //$("#company").on("ajax:success", show_company_popup);
            //$("#filter").click(show_choice);
            $("#company").click(show_company_popup);
            $("#industry_type").click(show_industry_popup);
            $("#location").click(show_location_popup);
            $("#salary").click(show_salary_popup);
            $(".close").click(hide_popup);
        },
    };
})();
    
$(js.init);