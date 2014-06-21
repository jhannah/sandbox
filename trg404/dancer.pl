#!/usr/bin/perl
use Dancer;

get '/' => sub {
  return <<EOT;

<h1>Hi</h1>

<form action="/process_input" method="POST">
  <input name="fname"/>
  <input name="lname"/>
  <select name="cars" multiple>
    <option value="volvo">Volvo</option>
    <option value="saab">Saab</option>
    <option value="opel">Opel</option>
    <option value="audi">Audi</option>
  </select>
  <input type="submit"/>
</form>

EOT
};

post '/process_input' => sub {
  my $bgcolor = "#ffffff";
  if (param('fname') =~ /jay/i) {
    $bgcolor = "#ffbbbb";
  }

  my $fname   = param('fname');
  my $lname   = param('lname');
  my $carsref = param('cars');

  my $rval = <<EOT;
<body bgcolor="$bgcolor">
Why, hello there $fname $lname
</body>
EOT
  foreach my $car (@$carsref) {
    $rval .= "<p>And you like $car????</p>";
  }
  return $rval;
};

 
dance;

