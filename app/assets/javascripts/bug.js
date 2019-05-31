


$(document).ready(function(){

    

   $('#resolve').click(function(){
    var $this = $(this);
   
    
    $this.toggleClass('btn-resolve');
    if($this.hasClass('btn-danger')){
        $this.text('Bug Resolved');
        $(this).removeClass('btn-danger').addClass('btn-success');
        $('.btn1').show();         
    } 
});

  //$('.button').removeClass('btn-success').addClass('btn-primary ');
  //$(this).addClass('btn-success').removeClass('btn-primary ');
$("#bug_bug_type").change(function(){

        var selectedOption = $(this).children("option:selected").val();
        var dropdownItems =['','',''];
        if(selectedOption==="bug")
        {
            dropdownItems =['new','started','resolved'];
            //$('#dropdown_items').val(dropdownItems);
            $('#bug_status > option')[2].text='Resolved';
            $('#bug_status > option')[2].value='Resolved';
            //alert("You have selected the Option - " + selectedOption);    
        }
        else
        {
            dropdownItems =['new','started','completed'];
            //$('#dropdown_items').val(dropdownItems);
            $('#bug_status > option')[2].text='Completed';
        }

    });

         var ellipsestext = "";
        var showchar = 20;
        var moretext = "Read More";
        var lesstext = "Read Less";
    $('.description').each(function() {
        
        var content = $(this).html();
        if(content.length > showchar) {
 
            var c = content.substr(0, showchar);
            var h = content.substr(showchar, content.length - showchar);
 
            var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';
 
            $(this).html(html);
        }
 
    });
    $(".morelink").click(function(){
        if($(this).hasClass("less")) {
            $(this).removeClass("less");
            $(this).html(moretext);
        } else {
            $(this).addClass("less");
            $(this).html(lesstext);
        }
        $(this).parent().prev().toggle();
        $(this).prev().toggle();
        return false;
    });
});
