require(shiny)
require(leaflet)

NumPoints = 1000
DataCenterLat = 37.5287955
DataCenterLong = -77.493477

# rColors = rgb(t(col2rgb(colors()) / 255))
# names(r_colors) <- colors()

# This is from https://github.com/WatHughes/leaflet-providers/blob/gh-pages/leaflet-providers.js
# Forked from https://github.com/leaflet-extras/leaflet-providers, which was also copied here.

MapProviders = c(
    'OpenStreetMap.Mapnik'
    ,'OpenStreetMap.BlackAndWhite'
    ,'OpenStreetMap.DE'
#     ,'OpenStreetMap.France' # Appears blank for Richmond
    ,'OpenStreetMap.HOT'
#    ,'OpenSeaMap' # Appears blank
#     ,'OpenTopoMap' # No info at needed scale?
    ,'Thunderforest.OpenCycleMap'
    ,'Thunderforest.Transport'
    ,'Thunderforest.TransportDark'
#    ,'Thunderforest.SpinalMap' # Appears blank
    ,'Thunderforest.Landscape'
    ,'Thunderforest.Outdoors'
#    ,'Thunderforest.Pioneer' # Appears blank
#    ,'OpenMapSurfer.Roads' # Appears blank
#    ,'OpenMapSurfer.AdminBounds' # Appears blank
#    ,'OpenMapSurfer.Grayscale' # Appears blank
    ,'Hydda.Full' # Flaky
    ,'Hydda.Base' # Flaky
    ,'Hydda.RoadsAndLabels'
    ,'MapQuestOpen.OSM'
    ,'MapQuestOpen.Aerial'
    ,'MapQuestOpen.HybridOverlay'
#    ,'MapBox' # Appears blank
    ,'Stamen.Toner'
    ,'Stamen.TonerBackground'
    ,'Stamen.TonerHybrid'
    ,'Stamen.TonerLines'
    ,'Stamen.TonerLabels'
    ,'Stamen.TonerLite'
    ,'Stamen.Watercolor'
    ,'Stamen.Terrain'
    ,'Stamen.TerrainBackground'
    ,'Stamen.TopOSMRelief'
    ,'Stamen.TopOSMFeatures'
    ,'Esri.WorldStreetMap'
    ,'Esri.DeLorme'
    ,'Esri.WorldTopoMap'
    ,'Esri.WorldImagery'
    ,'Esri.WorldTerrain'
    ,'Esri.WorldShadedRelief'
    ,'Esri.WorldPhysical'
    ,'Esri.OceanBasemap'
    ,'Esri.NatGeoWorldMap'
    ,'Esri.WorldGrayCanvas'
#    ,'OpenWeatherMap.Clouds' # Doesn't make sense for this application
#    ,'OpenWeatherMap.CloudsClassic' # Doesn't make sense for this application
#    ,'OpenWeatherMap.Precipitation' # Doesn't make sense for this application
#    ,'OpenWeatherMap.PrecipitationClassic' # Doesn't make sense for this application
#    ,'OpenWeatherMap.Rain' # Doesn't make sense for this application
#    ,'OpenWeatherMap.RainClassic' # Doesn't make sense for this application
#    ,'OpenWeatherMap.Pressure' # Doesn't make sense for this application
#    ,'OpenWeatherMap.PressureContour' # Doesn't make sense for this application
#    ,'OpenWeatherMap.Wind' # Doesn't make sense for this application
#    ,'OpenWeatherMap.Temperature' # Doesn't make sense for this application
#    ,'OpenWeatherMap.Snow' # Doesn't make sense for this application
#    ,'HERE.normalDay' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.normalDayCustom' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.normalDayGrey' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.normalDayMobile' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.normalDayGreyMobile' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.normalDayTransit' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.normalDayTransitMobile' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.normalNight' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.normalNightMobile' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.normalNightGrey' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.normalNightGreyMobile' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.basicMap' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.mapLabels' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.trafficFlow' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.carnavDayGrey' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.hybridDay' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.hybridDayMobile' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.pedestrianDay' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.pedestrianNight' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.satelliteDay' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.terrainDay' # Doesn't seem to have data at athe needed resolution
#    ,'HERE.terrainDayMobile' # Doesn't seem to have data at athe needed resolution
#    ,'FreeMapSK' # Appears blank
#    ,'MtbMap' # Appears white
    ,'CartoDB.Positron'
    ,'CartoDB.PositronNoLabels'
#     ,'CartoDB.PositronOnlyLabels' # Appears blank
    ,'CartoDB.DarkMatter'
    ,'CartoDB.DarkMatterNoLabels'
#    ,'CartoDB.DarkMatterOnlyLabels' # Appears blank
    ,'HikeBike.HikeBike'
    ,'HikeBike.HillShading'
 #   ,'BasemapAT.basemap' # Appears blank
 #   ,'BasemapAT.grau' # Appears blank
 #   ,'BasemapAT.bmapgrau' # Appears blank
 #   ,'BasemapAT.overlay' # Appears blank
 #   ,'BasemapAT.highdpi' # Appears blank
 #   ,'BasemapAT.orthofoto' # Appears blank
    ,'NASAGIBS.ModisTerraTrueColorCR'
    ,'NASAGIBS.ModisTerraBands367CR'
#    ,'NASAGIBS.ViirsEarthAtNight2012' # Appears blank
#    ,'NASAGIBS.ModisTerraLSTDay' # Appears blank
#    ,'NASAGIBS.ModisTerraSnowCover' # Appears useless
#    ,'NASAGIBS.ModisTerraAOD' # Appears blank
#    ,'NASAGIBS.ModisTerraChlorophyll' # Appears blank
#    ,'NLS' # Appears blank
) # MapProviders

MarkerChoices = data.frame(stringsAsFactors=F
    ,Choice=c('Default Icon','Green Circles','Dark Orchid 3 Circles','Sienna 2 Circles')
    ,Type=c('I','C','C','C')
    ,Color=c('','green','darkorchid3','sienna2')
) # MarkerChoices

# To make it easy to add tabs, remove tabs, and maintain tabs, the code implements each tab's
# portion of ui and server in its own functions. By convention, the function names
# start with some descriptive text but also will include a tab number. That number
# will be used in the names of all controls on that tab to make sure there are no
# accidents where a control name is used more than once. (Such controls are difficult
# to work with.)
# In this application the rightmost tab number is 1 and the numbers increase from there.
# The doc tab is 99 and comes first.

Doc99TabUI = function(){
    tabPanel(
        'Documentation',value='Doc'
        ,titlePanel('Doc')
        ,h3('Application Documentation and Background')
        ,br()
        ,'This application '
        ,br(),br()
    ) # tabPanel - Documentation
} # Doc99TabUI

Map2TabUI = function(){
    tabPanel(
        'Choose Map Source',value='Map2'
        ,mainPanel(
            leafletOutput('mymap2',width=800,height=800)
        )
        ,sidebarPanel(
            selectInput('MapC2','Choose a map source:',choices=MapProviders, selected='MapQuestOpen.OSM')
        )
    ) # tabPanel - Map Play 1
} # Map2TabUI

Map2TabServer = function(input, output, session){
    output$mymap2 = renderLeaflet({
        leaflet() %>%
            addProviderTiles(
                input$MapC2
                ,options=providerTileOptions(noWrap=T)
            ) %>%
                addMarkers(DataCenterLong,DataCenterLat)
    })
} # Map2TabServer

Marker1TabUI = function()
{
    ChoiceList=list() # selectInput will display the name if each element but return its value, which is the row number of MarkerChoices
    for(i in 1:nrow(MarkerChoices)){
        ChoiceList[[i]] = i
    }
    names(ChoiceList) = MarkerChoices$Choice

    tabPanel(
        'Choose Marker Style',value='Marker1'
        ,mainPanel(
            leafletOutput('mymap1',width=800,height=800)
        )
        ,sidebarPanel(
            selectInput('MapM1', 'Choose a map marker style:', choices = ChoiceList, selected=1)
            ,actionButton('NP1', 'New points')
        )
    ) # tabPanel - Marker1
} # Marker1TabUI

Marker1TabServer = function(input, output, session){
    points1 = eventReactive(
        input$NP1
        ,{
            cbind(rnorm(NumPoints) / 10 + DataCenterLong, rnorm(NumPoints) / 20 + DataCenterLat)
        }
        ,ignoreNULL=F
    )

    output$mymap1 = renderLeaflet({
        leaflet() %>%
            addProviderTiles(
                input$MapC2
                ,options=providerTileOptions(noWrap=T)
            ) %>%
                addMarkers(data=points1())
    })
} # Marker1TabServer

ui = fluidPage( # Todo, consider navbarPage with a bootstrap theme.
    tabsetPanel
    (
        type='tabs',id='tabs'
        ,Doc99TabUI()
        ,Map2TabUI()
        ,Marker1TabUI()
        ) # tabsetPanel
) # fluidPage

server = function(input, output, session){
    observeEvent( # Keep track of which tab the user has open to support optimizations elsewhere
        input$tabs
        ,{
            CurrentTab <<- input$tabs
            # print(CurrentTab)
            if (CurrentTab == 'Doc')
            {
            }
            if (CurrentTab == 'Random1')
            {
            }
            if (CurrentTab == 'Random2')
            {
            }
        }
    ) # observeEvent(tabs)

    Map2TabServer(input,output,session)
    Marker1TabServer(input,output,session)
} # server

shinyApp(ui, server)
