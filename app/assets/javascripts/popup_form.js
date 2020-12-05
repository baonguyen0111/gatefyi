"use strict";

var js = (function(){
    //private functions
    var show_company_popup = function() {
        $.ajax({type: 'GET',
            url: '/articles?filter=company&popup=true',
            timeout: 5000,
            success: function(result){
                $(".company_filter").css("visibility", "visible");
                alert("Success");
            },
            error: function(xhrObj , textStatus , exception) { alert('Error!');
            }
            // 'success' and 'error' functions will be passed 3 args
        });
        return(false);
    };
    var show_industry_popup = function() {
        $.ajax({type: 'GET',
            url: '/articles?filter=industry_type&popup=true',
            timeout: 5000,
            success: function(result){
                alert(result.name);
                $(".industry_filter").css("visibility", "visible");
            },
            error: function(xhrObj , textStatus , exception) { alert('Error!');
            }
            // 'success' and 'error' functions will be passed 3 args
        }); 
        return(false);
    };
    var show_salary_popup = function() {
        $.ajax({type: 'GET',
            url: '/articles',
            timeout: 5000,
            success: function(result){
                alert(result.name);
                $(".salary_filter").css("visibility", "visible");
            },
            error: function(xhrObj , textStatus , exception) { alert('Error!');
            }
            // 'success' and 'error' functions will be passed 3 args
        }); 
        return(false);
    };
    var show_location_popup = function() {
        $.ajax({type: 'GET',
            url: '/articles?filter=location&popup=true',
            timeout: 5000,
            success: function(result){
                alert(result.name);
                $(".location_filter").css("visibility", "visible");
            },
            error: function(xhrObj , textStatus , exception) { alert('Error!');
            }
            // 'success' and 'error' functions will be passed 3 args
        }); 
        return(false);
    };
    var hide_company_popup = function() {
        $(".company_filter").css("visibility", "hidden");
    };
    var hide_industry_popup = function() {
        $(".industry_filter").css("visibility", "hidden");
    };
     var hide_location_popup = function() {
        $(".location_filter").css("visibility", "hidden");
    };
     var hide_salary_popup = function() {
        $(".salary_filter").css("visibility", "hidden");
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
            $(".close_company").click(hide_company_popup);
            $(".close_industry").click(hide_industry_popup);
            $(".close_location").click(hide_location_popup);
            $(".close_salary").click(hide_salary_popup);
        },
    };
})();
    
$(js.init);