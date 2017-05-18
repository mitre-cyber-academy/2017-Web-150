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
    <title>githubviz</title>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(function (){
            $('#viz_form').submit(function(ev){
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
                    success: function(data) {
                        //if our ajax request is successful, replace the content of our viz div with the response data
                        $('#viz').html(data);
                    }
                });
                //show the link to the repo_viz (don't forget: we are still in the submit event!)
                $('#viz_link').append($("#viz_form input:first").val());
                $('#viz_p').show();
            });

        });
    </script>
</head>
<body>
<form action="/" method="post" id="viz_form">
    <label>Enter your username:</label>
    <input name="qid" type="hidden" value="9">
    <input name="cb0" type="checkbox"/>
    <input name="cb1" type="checkbox"/>
    <input name="cb2" type="checkbox"/>
    <input name="cb3" type="checkbox"/>
    <input type="submit" value="Do it!">
</form>
<p id="viz_p" style="display:none;"><a id="viz_link" href="#">click here if you want to see the awesome repo_viz for </a></p>
<div id="viz">
</div>
</body>
</html>



@@ validate
<h1>Received <%= @qid %> and <%= @answ %></h1>