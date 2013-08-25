class window.GW2API
  constructor:->
    @worldNames=@mapNames=@eventNames=@objectiveNames=@items=@recipes=@colors=@wvwMatches=@gameBuild=@continents=@maps=@assets=null
    @mapFloors=@mapDetails={}

  #worldID has a default so that 70,000+ events don't get fetched accidently. Set to 0 when calling if you really want to
  #If you want to get events from every world on a single map: getEvents(0,1234)
  getEvents:(worldID=1001, mapID=0, eventID=0)->
    data=null
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
      data=d.events
    data

  #Checks if a given language is available in the API
  checkValidLanguage:(language)->
    @getValidLanguages().indexOf(language)>-1

  #Gets all languages valid in the API
  getValidLanguages:->
    ["en","fr","de","es"]

  #Gets the names of all worlds and caches the results
  getWorldNames:(language="en")->
    if @checkValidLanguage(language)
      if !@worldNames
        me=@
        $.ajax({
          url:"https://api.guildwars2.com/v1/world_names.json"
          type:"get"
          dataType:"json"
          async:false
          data:
            lang:language
        }).done (d) ->
          me.worldNames=d
      return @worldNames
    false

  #Gets the name of a world given an ID
  getWorldName:(worldID, language="en")->
    if @checkValidLanguage(language)
      worldID=worldID.toString()
      for i in @getWorldNames(language)
        if i.id==worldID
          return i.name
    false

  #Gets the names of all maps and caches the results
  getMapNames:(language="en")->
    if @checkValidLanguage(language)
      if !@mapNames
        me=@
        $.ajax({
          url:"https://api.guildwars2.com/v1/map_names.json"
          type:"get"
          dataType:"json"
          async:false
          data:
            lang:language
        }).done (d) ->
          me.mapNames=d
      return @mapNames
    false

  #Gets the name of a map given an ID
  getMapName:(mapID, language="en")->
    if @checkValidLanguage(language)
      mapID=mapID.toString()
      for i in @getMapNames(language)
        if i.id==mapID
          return i.name
    false

  #Gets the names of all events and caches the results
  getEventNames:(language="en")->
    if @checkValidLanguage(language)
      if !@eventNames
        me=@
        $.ajax({
          url:"https://api.guildwars2.com/v1/event_names.json"
          type:"get"
          dataType:"json"
          async:false
          data:
            lang:language
        }).done (d) ->
          me.eventNames=d
      return @eventNames
    false

  #Gets the name of an event given an ID
  getEventName:(eventID, language="en")->
    if @checkValidLanguage(language)
      for i in @getEventNames(language)
        if i.id==eventID
          return i.name
    false

  #Gets all currently running WvW matches
  getWvwMatches:->
    if !@wvwMatches
      me=@
      $.ajax({
        url:"https://api.guildwars2.com/v1/wvw/matches.json"
        type:"get"
        dataType:"json"
        async:false
        }).done (d)->
          console.log(d)
          me.wvwMatches=d.wvw_matches
      @wvwMatches

  #Gets the names of all WvW objectives and caches the results
  getObjectiveNames:(language="en")->
    if @checkValidLanguage(language)
      if !@objectiveNames
        me=@
        $.ajax({
          url:"https://api.guildwars2.com/v1/wvw/objective_names.json"
          type:"get"
          dataType:"json"
          async:false
          data:
            lang:language
        }).done (d)->
          me.objectiveNames=d
      return @objectiveNames
    false

  #Gets the name of an objective given an ID
  getObjectiveName:(objectiveID, language="en")->
    if @checkValidLanguage(language)
      objectiveID=objectiveID.toString()
      for i in @getObjectiveNames(language)
        if i.id==objectiveID
          return i.name
    false

  #Gets the details of a given match
  getMatchDetails:(matchID)->
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
  getItems:->
    if !@items
      me=@
      $.ajax({
        url:"https://api.guildwars2.com/v1/items.json"
        type:"get"
        dataType:"json"
        async:false
      }).done (d)->
        me.items=d.items
    @items

  #Gets an object containing item details
  getItemDetails:(itemID, language="en")->
    if @checkValidLanguage(language)
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
      return data
    false

  #Gets an array of all recipe IDs
  getRecipes:->
    if !@recipes
      me=@
      $.ajax({
        url:"https://api.guildwars2.com/v1/recipes.json"
        type:"get"
        dataType:"json"
        async:false
      }).done (d)->
        me.recipes=d.recipes
    @recipes

  #Gets an object containing recipe details
  getRecipeDetails:(recipeID, language="en")->
    if @checkValidLanguage(language)
      data=null
      $.ajax({
        url:"https://api.guildwars2.com/v1/recipe_details.json"
        type:"get"
        dataType:"json"
        async:false
        data:
          recipe_id:recipeID
          lang:language
      }).done (d)->
        data=d
      return data
    false

  #Gets the game's current build ID
  getBuildID:->
    if !@gameBuild
      me=@
      $.ajax({
        url:"https://api.guildwars2.com/v1/build.json"
        type:"get"
        dataType:"json"
        async:false
        }).done (d)->
          me.gameBuild=d.build_id
    return @gameBuild

  #Gets guild details
  getGuildDetails:(name=null, ID=null)->
    data=null
    requestData=null
    if !name && ID
      requestData={
        guild_id:ID
      }
    if !ID && name
      requestData={
        guild_name:name
      }
    if !requestData
      return false
    $.ajax({
      url:"https://api.guildwars2.com/v1/guild_details.json"
      type:"get"
      dataType:"json"
      async:false
      data:
        requestData
      }).done (d)->
        data=d
    return data

  #Gets all dye colors currently available in the game
  getColors:(language="en")->
    if @checkValidLanguage(language)
      if !@colors
        me=@
        $.ajax({
          url:"https://api.guildwars2.com/v1/colors.json"
          type:"get"
          dataType:"json"
          async:false
          data:
            lang:language
          }).done (d)->
            me.colors=d.colors;
      return @colors
    false

  #Gets the correct color of a dye color when on a certain material
  #Returns an array container each color component (RGB)
  getColorOnMaterial:(colorID, material, language="en")->
    if ["cloth","leather","metal"].indexOf(material)>-1
      if @checkValidLanguage(language)
        color=@getColors(language)[colorID]

        brightness=color[material].brightness/128
        contrast=color[material].contrast
        hue=(color[material].hue*3.14159265358979323846)/180
        saturation=color[material].saturation
        lightness=color[material].lightness

        matrix=Matrix.I(4)

        if brightness!=0 || contrast!=1
          t=128*(2*brightness+1-contrast)
          mult=$M([
            [contrast,0,0,t]
            [0,contrast,0,t]
            [0,0,contrast,t]
            [0,0,0,1]
          ])
          matrix=mult.x(matrix)

        if hue!=0 || saturation!=1 || lightness!=1
          multRgbToHsl=$M([
            [ 0.707107, 0.0,      -0.707107, 0]
            [-0.408248, 0.816497, -0.408248, 0]
            [ 0.577350, 0.577350,  0.577350, 0]
            [ 0,        0,         0,        1]
          ])
          matrix=multRgbToHsl.x(matrix)

          cosHue=Math.cos(hue)
          sinHue=Math.sin(hue)
          mult=$M([
            [cosHue * saturation,  sinHue * saturation, 0,         0]
            [-sinHue * saturation, cosHue * saturation, 0,         0]
            [0,                    0,                   lightness, 0]
            [0,                    0,                   0,         1]
          ])
          matrix=mult.x(matrix)

          multHslToRgb=$M([
            [ 0.707107, -0.408248, 0.577350, 0]
            [        0,  0.816497, 0.577350, 0]
            [-0.707107, -0.408248, 0.577350, 0]
            [ 0,        0,         0,        1]
          ])
          matrix=multHslToRgb.x(matrix)
        bgrVector=$V([color.base_rgb[2],color.base_rgb[1],color.base_rgb[0],1])
        bgrVector=matrix.x(bgrVector)
        resultRgb=[bgrVector.elements[2],bgrVector.elements[1],bgrVector.elements[0]]

        resultRgb[0]=Math.floor(Math.max(0,Math.min(255,resultRgb[0])))
        resultRgb[1]=Math.floor(Math.max(0,Math.min(255,resultRgb[1])))
        resultRgb[2]=Math.floor(Math.max(0,Math.min(255,resultRgb[2])))

        return resultRgb
    false

  #Assembles a valid URL for the render service
  getAssetURL:(signature, id, format="png")->
    if ["png","jpg"].indexOf(format)>-1
      return "https://render.guildwars2.com/file/#{signature}/#{id}.#{format}"
    false

  #Gets all file assets through the files API
  getAssets:->
    if !@assets
      me=@
      $.ajax({
        url:"https://api.guildwars2.com/v1/files.json"
        type:"get"
        dataType:"json"
        async:false
      }).done (d)->
        me.assets=d;
    @assets

  #Gets a single assets details through the files API
  getAsset:(assetName)->
    @getAssets()[assetName]

  #Gets an array containing each continent and it's details
  getContinents:->
    if !@continents
      me=@
      $.ajax({
        url:"https://api.guildwars2.com/v1/continents.json"
        type:"get"
        dataType:"json"
        async:false
      }).done (d)->
        me.continents=d.continents;
    @continents

  getContinent:(continentID)->
    if continentID
      return @getContinents()[continentID]
    false

  getMaps:(language="en")->
    if @checkValidLanguage(language)
      if !@maps
        me=@
        $.ajax({
          url:"https://api.guildwars2.com/v1/maps.json"
          type:"get"
          dataType:"json"
          async:false
          data:
            lang:language
        }).done (d)->
          me.maps=d.maps;
      return @maps
    false

  #Gets map details
  getMap:(mapID, language="en")->
    if @checkValidLanguage(language)
      if mapID
        return @getMaps(language)[mapID]
    false

  #Gets all details about a map, it's POIs, tasks, skill challenges, and sectors
  getMapFloor:(continentID, floorID, language="en")->
    if @checkValidLanguage(language)
      if continentID && floorID
        id=continentID+","+floorID
        if !@mapFloors || !@mapFloors[id]
          me=@
          $.ajax({
            url:"https://api.guildwars2.com/v1/map_floor.json"
            type:"get"
            dataType:"json"
            async:false
            data:
              continent_id:continentID
              floor:floorID
              lang:language
          }).done (d)->
            me.mapFloors[id]=d
        return @mapFloors[id]
    false

  #Gets a valid tile URL
  getTileURL:(continentID, floorID, z, x, y)->
    return "https://tiles.guildwars2.com/#{continentID}/#{floorID}/#{z}/#{x}/#{y}.jpg"

  #Gets all event details
  getAllEventDetails:(language="en")->
    if @checkValidLanguage(language)
      if !@eventDetails
        me=@
        $.ajax({
          url:"https://api.guildwars2.com/v1/event_details.json"
          type:"get"
          dataType:"json"
          async:false
          data:
            lang:language
        }).done (d)->
          me.eventDetails=d.events
      return @eventDetails
    false

  #Get a single event's details
  getEventDetails:(eventID, language="en")->
    if @checkValidLanguage(language)
      return @getAllEventDetails(language)[eventID]
    false