worldNames=mapNames=eventNames=objectiveNames=items=recipes=[]
wvwMatches=null

#worldID has a default so that 70,000+ events don't get fetched accidently. Set to 0 when calling if you really want to
#If you want to get events from every world on a single map: getEvents(0,1234)
getEvents=(worldID=1001, mapID=0, eventID=0) ->
  data={}
  $.ajax({
    url:"https://api.guildwars2.com/v1/events.json"
    type:"get"
    dataType:"json"
    async:false
    data:
      world_id:worldID
      map_id:mapID
      event_id:eventID
  }).done (d) ->
    data=d
  data

#Checks if a given language is available in the API
checkValidLanguage= (language)->
  ["en","fr","de","es"].indexOf(language)>-1

#Gets the names of all worlds and caches the results
getWorldNames=(language="en")->
  if checkValidLanguage(language)
    if !worldNames.length
      $.ajax({
        url:"https://api.guildwars2.com/v1/world_names.json"
        type:"get"
        dataType:"json"
        async:false
        data:
          lang:language
      }).done (d) ->
        worldNames=d
    return worldNames
  false

#Gets the name of a world given an ID
getWorldName=(worldID, language="en")->
  if checkValidLanguage(language)
    worldID=worldID.toString()
    for i in getWorldNames(language)
      if i.id==worldID
        return i.name
    return false
  false

#Gets the names of all maps and caches the results
getMapNames=(language="en")->
  if checkValidLanguage(language)
    if !mapNames.length
      $.ajax({
        url:"https://api.guildwars2.com/v1/map_names.json"
        type:"get"
        dataType:"json"
        async:false
        data:
          lang:language
      }).done (d) ->
        mapNames=d
    return mapNames
false

#Gets the name of a map given an ID
getMapName=(mapID, language="en")->
  if checkValidLanguage(language)
    mapID=mapID.toString()
    for i in getMapNames(language)
      if i.id==mapID
        return i.name
    return false
  false

#Gets the names of all events and caches the results
getEventNames=(language="en")->
  if checkValidLanguage(language)
    if !eventNames.length
      $.ajax({
         url:"https://api.guildwars2.com/v1/event_names.json"
         type:"get"
         dataType:"json"
         async:false
         data:
           lang:language
       }).done (d) ->
        eventNames=d
    return eventNames
false

#Gets the name of an event given an ID
getEventName=(eventID, language="en")->
  if checkValidLanguage(language)
    for i in getEventNames(language)
      if i.id==eventID
        return i.name
    return false
  false

#Gets all currently running WvW matches
getWvwMatches= ->
  if !wvwMatches
    $.ajax({
      url:"https://api.guildwars2.com/v1/wvw/matches.json"
      type:"get"
      dataType:"json"
      async:false
    }).done (d)->
      wvwMatches=d
    wvwMatches.wvw_matches

#Gets the names of all WvW objectives and caches the results
getObjectiveNames=(language="en")->
  if checkValidLanguage(language)
    if !objectiveNames.length
      $.ajax({
        url:"https://api.guildwars2.com/v1/wvw/objective_names.json"
        type:"get"
        dataType:"json"
        async:false
        data:
          lang:language
      }).done (d)->
        objectiveNames=d
    return objectiveNames
  false

#Gets the name of an objective given an ID
getObjectiveName=(objectiveID, language="en")->
  if checkValidLanguage(language)
    objectiveID=objectiveID.toString()
    for i in getObjectiveNames(language)
      if i.id==objectiveID
        return i.name
    return false
  false

#Gets the details of a given match
getMatchDetails=(matchID)->
  data=null
  $.ajax({
    url:"https://api.guildwars2.com/v1/wvw/match_details.json"
    type:"get"
    dataType:"json"
    async:false
    data:
      match_id:matchID
  }).done (d)->
    data=d
  data

#Gets an array of all item IDs
getItems=->
  if !items.length
    $.ajax({
      url:"https://api.guildwars2.com/v1/items.json"
      type:"get"
      dataType:"json"
      async:false
    }).done (d)->
      items=d
  items

#Gets an object containing item details
getItemDetails=(itemID, language="en")->
  data=null
  $.ajax({
    url:"https://api.guildwars2.com/v1/item_details.json"
    type:"get"
    dataType:"json"
    async:false
    data:
      item_id:itemID
      lang:language
  }).done (d)->
    data=d
  data

#Gets an array of all recipe IDs
getRecipes=->
  if !recipes.length
    $.ajax({
      url:"https://api.guildwars2.com/v1/recipes.json"
      type:"get"
      dataType:"json"
      async:false
    }).done (d)->
      recipes=d
  recipes

#Gets an object containing recipe details
getRecipeDetails=(recipeID)->
  data=null
  $.ajax({
  url:"https://api.guildwars2.com/v1/recipe_details.json"
  type:"get"
  dataType:"json"
  async:false
  data:
   recipe_id:recipeID
  }).done (d)->
    data=d
  data

