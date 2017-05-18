require 'sinatra'

get '/' do
  '<title>No Page</title>
<h1>Please access the home page</h1>
<a href="/home">Home Page</a>'
end

get '/home' do
  erb :home
end

post '/captcha/validate' do
  @qid = params[:question]
  erb :validate
end

get '/*' do
  redirect '/'
end

__END__

@@ home
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home</title>
</head>
<body>
<h2>Flag Emporium</h2>
<h3>Welcome</h3>
Please complete the CAPTCHA below to receive your <b>FREE</b> flag.<br>

<form id="captcha">
    <input type="number">
    <input type="submit">
</form>
<div id="response"></div>
</body>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {
        $('captcha').submit(function (event) {
            event.preventDefault();

            $.ajax({
                url: "/captcha/validate",
                data: "question= 9", //<%= @qid %>
                dataType: "html",
                success: function (data) {
                    $('response').html(data);
                }
            }).done(function () {
                alert("success");
            })
                .fail(function () {
                    alert("error");
                })
                .always(function () {
                    alert("complete");
                });
        });
    });
</script>
</html>



@@ validate
<h1>Received DATA</h1>