require(shiny)
require(leaflet)

NumPoints = 100
DataCenterLat = 37.5287955
DataCenterLong = -77.493477

# rColors = rgb(t(col2rgb(colors()) / 255))
# names(r_colors) <- colors()

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

RD1TabUI = function(){
    tabPanel(
        'Random Data 1',value='Random1'
        ,br()
        ,leafletOutput('mymap1',width = 800, height = 800)
        ,p()
        ,actionButton('recalc1', 'New points')
    ) # tabPanel - Random 1
} # RD1TabUI

RD1TabServer = function(input, output, session){
    points1 = eventReactive(
        input$recalc1
        ,{
            cbind(rnorm(NumPoints) / 10 + DataCenterLong, rnorm(NumPoints) / 20 + DataCenterLat)
        }
        ,ignoreNULL=F
    )

    output$mymap1 = renderLeaflet({
        leaflet() %>%
            addProviderTiles(
#                'Stamen.TonerLite'
#                'OpenStreetMap.BlackAndWhite'
                'MapQuestOpen.OSM'
                ,options=providerTileOptions(noWrap=T)
            ) %>%
                addMarkers(data=points1())
    })
} # RD1TabServer

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
        ,RD1TabUI()
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

    RD1TabServer(input,output,session)
    RD2TabServer(input,output,session)
} # server

shinyApp(ui, server)
