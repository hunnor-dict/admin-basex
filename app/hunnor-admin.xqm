module namespace hunnor = 'hunnor/basex';

declare
  %rest:path('')
  %output:method('html')
function hunnor:admin(
) as element(html) {
  <html>
    <head>
      <title>HunNor - BaseX</title>
      <link href="./static/hunnor-admin.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
      <h1>HunNor</h1>
      <form>
      <input id="search-query" type="text"/>
      <button id="search-submit" type="button">Search</button>
      <ul id="search-results">
      </ul>
      </form>
      <form>
        <textarea id="entry-content" cols="50" rows="20"></textarea>
      </form>
      <script src="./static/jquery-3.6.0.min.js" type="text/javascript"> </script>
      <script src="./static/hunnor-admin.js" type="text/javascript"> </script>
    </body>
  </html>
};
