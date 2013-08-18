What is this?
------------------
This library of functions is a JS wrapper for the Guild Wars 2 public API. It wraps the current APIs available with functions and provides some utility functions.

Requirements
------------------
* **jQuery 1.8.0+** (Example using jQuery 1.10.2 hosted on Google's servers)
* **sylvester.js** Used for *getColorOnMaterial()*

Installation
------------------
Include the following wherever you are loading your libraries, make sure it is loaded after the required libraries
`<script src="gw2-api-wrapper.js"></script>`

Function Reference
------------------
###General
**checkValidLanguages(language)** - Checks if the given language is available with the API

###Dynamic Event API
**getEvents(worldID, mapID, eventID)** - Gets all events, filtered by the given arguments  
**getEventNames([language])** - Gets all event names  
**getEventName(eventID [,language])** - Gets a single event's name  
**getWorldNames([language])** - Gets all world names and IDs  
**getWorldName(worldID [,language])** - Gets a single world's name  
**getMapNames([language])** - Gets all map names and IDs  
**getMapName(mapID [,language])** - Gets a single map's name  
**getAllEventDetails([language])** - Gets all event details  
**getEventDetails(eventID [,language])** - Get a single event's details  

###WvW API
**getWvwMatches()** - Gets all currently running WvW matches  
**getObjectiveNames([language])** - Gets all WvW objectives  
**getObjectiveName(objectiveID [,language])** - Gets a single objective's name  
**getMatchDetails(matchID)** - Get the details of a single match  

###Item and Recipe API
**getItems()** - Gets a list of all item IDs  
**getItemDetails(itemID [,language])** - Gets a single item's details  
**getRecipes()** - Gets a list of all recipe IDs  
**getRecipeDetails(recipeID)** - Gets a single recipe's details

###Map API
**getContinents()** - Gets an array containing each continent and it's details  
**getContinent(continentID)** - Gets all details about a continent  
**getMaps([language])** - Gets all maps  
**getMap(map_id [,language])** - Gets a map's size details  
**getMapFloor(continentID, floorID [,language])** - Gets all details about a map, it's POIs, tasks, skill challenges, and sectors  

###Render Service
**getAssetURL(signature, id [,format])** - Creates a valid asset URL given a signature and id retrieved from getItemDetails()

###Tile Service
**getTileURL(continentID, floorID, z, x, y)** - Gets a valid tile URL. Can be used to make dynamic maps like [this](http://jsfiddle.net/cliff/CRRGC/)  

###Miscellaneous APIs
**getBuildID()** - Gets the current build ID  
**getColors([language])** - Gets all currently available dye colors  
**getColorOnMaterial(colorID, material [,language])** - Gets a dye color as if it were on a certain material. Materials can be "cloth", "leather", or "metal"  
**getAssets()** - Gets all file assets through the [files service](http://wiki.guildwars2.com/wiki/API:1/files)  
**getAsset(assetID)** - Gets a single assets details through the [files service](http://wiki.guildwars2.com/wiki/API:1/files)  
