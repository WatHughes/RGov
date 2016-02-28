require(shiny)
require(leaflet)

NumPoints = 100
DataCenterLat = 37.5287955
DataCenterLong = -77.493477

# rColors = rgb(t(col2rgb(colors()) / 255))
# names(r_colors) <- colors()

# This is from https://github.com/WatHughes/leaflet-providers/blob/gh-pages/leaflet-providers.js
# Forked from https://github.com/leaflet-extras/leaflet-providers, which was also copied here.

MapProviders = c('OpenStreetMap.Mapnik'
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
)

DocTabUI = function(){
    tabPanel(
        'Documentation',value='Doc'
        ,titlePanel('Doc')
        ,h3('Application Documentation and Background')
        ,br()
        ,'This application '
        ,br(),br()
    ) # tabPanel - Documentation
} # DocTabUI

MP1TabUI = function(){
    tabPanel(
        'Map Play',value='MapPlay1'
        ,mainPanel(
            leafletOutput('mymap1',width = 800, height = 800)
        )
        ,sidebarPanel(
            selectInput('MapC1', 'Choose a map:', choices = MapProviders)
        )
    ) # tabPanel - Map Play 1
} # MP1TabUI

MP1TabServer = function(input, output, session){
    output$mymap1 = renderLeaflet({
        leaflet() %>%
            addProviderTiles(
                input$MapC1
                ,options=providerTileOptions(noWrap=T)
            ) %>%
                addMarkers(data=cbind(DataCenterLong,DataCenterLat))
    })
} # MP1TabServer

RD2TabUI = function()
{
    tabPanel(
        'Random Data 2',value='Random2'
        ,br()
        ,leafletOutput('mymap2',width = 800, height = 800)
        ,p()
        ,actionButton('recalc2', 'New points')
    ) # tabPanel - Random 2
} # RD2TabUI

RD2TabServer = function(input, output, session){
    points2 = eventReactive(
        input$recalc2
        ,{
            cbind(rnorm(NumPoints) / 10 + DataCenterLong, rnorm(NumPoints) / 20 + DataCenterLat)
        }
        ,ignoreNULL=F
    )

    output$mymap2 = renderLeaflet({
        leaflet() %>%
            addProviderTiles(
                'OpenStreetMap.BlackAndWhite'
                ,options=providerTileOptions(noWrap=T)
            ) %>%
                addMarkers(data=points2())
    })
} # RD2TabServer

ui = fluidPage(
    tabsetPanel
    (
        type='tabs',id='tabs'
        ,DocTabUI()
        ,MP1TabUI()
        ,RD2TabUI()
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

    MP1TabServer(input,output,session)
    RD2TabServer(input,output,session)
} # server

shinyApp(ui, server)
