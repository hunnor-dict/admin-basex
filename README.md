# BaseX

[BaseX Home](https://basex.org/)

BaseX is an XML database with some features that can be useful for the admin application:

* Provides a REST backend for creating database and modifying database content
* Can easily host single page applications, which is mostly enough for the editor functionality

# Demo

1. Start the server: `docker-compose up --build`
1. Create the sample database: `curl -X PUT -u admin:admin http://localhost:8984/rest/hunnor`
1. Load sample data: `curl -X PUT -u admin:admin -H "Content-Type: application/xml" -d@samples/nb/15006.xml http://localhost:8984/rest/hunnor/nb/15006.xml`

Repeat step 3. for all files in the `samples` directory.

Visit http://localhost:8984/ and try a search for "b" or "f". Click on the result list items to load the XML of the entries.

# How does this work?

* The `app` directory is mounted into the container. The application itself is the `hunnor-admin.xqm` file, this contains the URL mapping and the HTML code. The configuration files in the `WEB-INF` directory enable the application and serving of static assets in the `static` directory. This could probably be changed to serve the HTML as a static file as well, without using RESTXQ.
* Listing entries is done with XQuery. The query URL that the JavaScript code calls is http://localhost:8984/rest?run=hunnor-list.xq&$name=b
  * The query is stored in the `queries/entry-list.xq` file. The $name variable is declared to be external, it is supplied in the URL query parameter above. It doesn't make sense to call it name though, it should be renamed eventually.
  * The directory of the query is mounted into the container to `/opt/hunnor-dict/queries`. This directory is defined as the `RESTPATH` environment variable in the `config/basex` configuration file. The configuration file is copied into the container when the image is created with the `Dockerfile`.
  * The path defined in `/rest?run=` is relative to `RESTPATH`, which means that `/rest?run=hunnor-list.xq` looks for the file `$RESTPATH/hunnor-list.xq`, which then becomes `/opt/hunnor-dict/queries/hunnor-list.xq`

# How will the editor change?

* The whole article will be edited in XML. Today, the translation is edited as XML while the written forms, grammatical categories and metadata are edited with a combination of YAML and form inputs.
* Saving and deleting the entries can then be done with the built-in REST API of BaseX.

# Where to go from here?

1. Load sample files for the Hungarian-Norwegian direction to the `/hunnor/hu` database path.
1. Write a better XQuery for listing the entries.
1. Improve the HTML and CSS of the application, arrange the navigation to the right and make it scroll separately.
1. Add CodeMirror to the XML editor part. This will add support for syntax highlighting and tag suggestions.
1. Add save and delete buttons to the XML editor. The XML in the editor can be saved with the built-in REST API of BaseX. In addition, the XML or delete command can be sent to a Solr server. The Solr cores are prepared to handle the custom XML of HunNor, but may require the namespace or some wrapper elements.
