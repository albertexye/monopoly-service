# CS 262 Monopoly Webservice

This is the data service application for the 
[CS 262 Monopoly project](https://github.com/albertexye/monopoly-project),
 which is deployed here:
          
- <https://monopoly-byczf6dbera4fuhd.canadacentral-01.azurewebsites.net>

It has the following read data route URLs:
- `/` a hello message, nullipotent
- `/players` a list of players, nullipotent
- `/players/:id` a single player with the given ID, nullipotent
- `/players/:id/games` a list of games that a player has, nullipotent

It is based on the standard Azure App Service tutorial for Node.js.

- <https://learn.microsoft.com/en-us/azure/app-service/quickstart-nodejs?tabs=linux&pivots=development-environment-cli>  

The database is relational with the schema specified in the `sql/` sub-directory
and is hosted on [Azure PostgreSQL](https://azure.microsoft.com/en-us/products/postgresql/).
The database server, user and password are stored as Azure application settings so that they 
aren&rsquo;t exposed in this (public) repo.

We implement this sample service as a separate repo to simplify Azure integration;
it&rsquo;s easier to auto-deploy a separate repo to Azure. For your team project&rsquo;s 
data service, configure your Azure App Service to auto-deploy from the master/main branch 
of your service repo. See the settings for this in the &ldquo;Deployment Center&rdquo; 
on your Azure service dashboard.

The service is RESTful because:
- it uses explicit URIs: the player id is included in the URI
- it uses the HTTP protocol: https://
- it is stateless: previous requests don't affect the current request
- it uses JSON to transfer data

Impedance Mismatch: Not so much, as the relationship between players and games is many-to-many, it fits into the SQL data model. So far, there isn't a clear mismatch. But once the properties and player positions are implemented, there will be an obvious mismatch as a player OWNS properties and the position, which SQL data model cannot accurately represent. 
 
