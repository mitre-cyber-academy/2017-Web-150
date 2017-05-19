require 'sinatra'

get '/' do
  '<title>No Page</title>
<h1>Please access the home page</h1>
<a href="/home">Home Page</a>'
end

get '/home' do
  erb :home
end

get '/captcha/validate' do
  @qid = params[:qid]
  if(params[:cb0].nil?)
    @cb = '0'
  else
    @cb = '1'
  end
  if(params[:cb1].nil?)
    @cb += '0'
  else
    @cb += '1'
  end
  if(params[:cb2].nil?)
    @cb += '0'
  else
    @cb += '1'
  end
  if(params[:cb3].nil?)
    @cb += '0'
  else
    @cb += '1'
  end
  @answ = @cb
  erb :validate
end

get '/*' do
  redirect '/'
end

__END__

@@ home
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <title>CAPTTTTCHA</title>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#viz_form').submit(function (ev) {
                //this happens if form is submitted
                //prevent the default behavior of a form (it should do nothing in our case)
                ev.preventDefault();
                //send an ajax request to our action

                $.ajax({
                    url: "/captcha/validate",
                    //serialize the form and use it as data for our ajax request
                    data: $(this).serialize(),
                    //the type of data we are expecting back from server, could be json too
                    dataType: "html",
                    success: function (data) {
                        //if our ajax request is successful, replace the content of our viz div with the response data
                        $('#viz').html(data);
                    }
                });
                //show the link to the repo_viz (don't forget: we are still in the submit event!)
                //$('#viz_link').append($("#viz_form input:first").val());
                $('#viz_p').show();
            });

        });
    </script>
    <script type="text/javascript">
        function load() {
            var all_checkbox_divs = document.getElementsByClassName("image-checkbox");

            for (var i=0;i<all_checkbox_divs.length;i++) {

                all_checkbox_divs[i].onclick = function (e) {
                    var div_id = this.id;
                    var checkbox_id =div_id.split("_")[0];
                    var checkbox_element = document.getElementById(checkbox_id);

                    if (checkbox_element.checked === true) {
                        checkbox_element.checked = false;
                        this.setAttribute("class","image-checkbox");
                    } else {
                        checkbox_element.checked = true;
                        this.setAttribute("class","image-checkbox-checked");
                    }

                };
            }

        }
    </script>
    <style>
        input.cb {
            visibility: hidden;
        }

        .image-checkbox {
            background:url(http://blog.adriansandu.com/wp-content/uploads/2012/08/ie8-broken.png);
            width:100px;
            height:100px;
        }

        .image-checkbox-checked {
            background:url(http://blog.adriansandu.com/wp-content/uploads/2012/08/ie8-broken.png);
            width:100px;
            height:100px;
        }
    </style>
</head>
<body onload="load()">
<form action="/" method="post" id="viz_form">
    <label>Enter your username:</label>
    <input name="qid" type="hidden" value="9">
    <input name="cb0" type="checkbox" id="cb0" class="cb"/>
    <div id="cb0_proxy" class="image-checkbox"/>
    <input name="cb1" type="checkbox" class="cb" id="cb1"/>
    <div id="cb1_proxy" class="image-checkbox"/>
    <input name="cb2" type="checkbox" class="cb" id="cb2"/>
    <div id="cb2_proxy" class="image-checkbox"/>
    <input name="cb3" type="checkbox" class="cb" id="cb3"/>
    <div id="cb3_proxy" class="image-checkbox"/>
    <!--<label for="cb0"><img src="/bad/link"/></label>
    <input name="cb1" type="checkbox" class="cb"/>
    <label for="cb1"><img src="/awful/link"/></label>
    <input name="cb2" type="checkbox" class="cb"/>
    <label for="cb2"><img src="/broken/link"/></label>
    <input name="cb3" type="checkbox" class="cb"/>
    <label for="cb3"><img src="/no"/></label> -->
    <br/><br/><br/><br/><br/><br/><br/>
    <input type="submit" value="Do it!">
</form>
<p id="viz_p" style="display:none;"><a id="viz_link"
                                       href="#">click here if you want to see the awesome repo_viz for </a></p>
<div id="viz">
</div>
</body>
</html>



@@ validate
<h1>Received <%= @qid %> and <%= @answ %></h1>