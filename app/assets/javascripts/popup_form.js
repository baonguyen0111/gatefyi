"use strict";

var js = (function(){
    //private functions
    var show_company_popup = function() {
        $(".company_filter").css("visibility", "visible");
        return(false);
    };
    var show_industry_popup = function() {
        $(".industry_filter").css("visibility", "visible");
        return(false);
    };
    var show_salary_popup = function() {
        $(".salary_filter").css("visibility", "visible");
        return(false);
    };
    var show_location_popup = function() {
        $(".location_filter").css("visibility", "visible");
        return(false);
    };
    var hide_company_popup = function() {
        $('#submit_company')[0].reset();
        $(".company_filter").css("visibility", "hidden");
        return(false);
    };
    var hide_industry_popup = function() {
        $('#submit_industry')[0].reset();
        $(".industry_filter").css("visibility", "hidden");
        return(false);
    };
     var hide_location_popup = function() {
        $('#submit_location')[0].reset();
        $(".location_filter").css("visibility", "hidden");
        return(false);
    };
     var hide_salary_popup = function() {
        $('#submit_salary')[0].reset();
        $(".salary_filter").css("visibility", "hidden");
        return(false);
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