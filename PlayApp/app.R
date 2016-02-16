require(shiny)
require(leaflet)

NumPoints = 100
DataCenterLat = 37.5287955
DataCenterLong = -77.493477

# rColors = rgb(t(col2rgb(colors()) / 255))
# names(r_colors) <- colors()

ui = fluidPage(
    tabsetPanel
    (
        type='tabs',id='tabs'
        ,tabPanel
        (
            'Documentation',value='Doc'
            ,titlePanel('Doc')
            ,h3('Application Documentation and Background')
            ,br()
            ,'This application '
            ,br(),br()
        ), # tabPanel - Documentation
        tabPanel
        (
            'Random Data 1',value='Random'
            ,br()
            ,leafletOutput('mymap1',width = 800, height = 800)
            ,p()
            ,actionButton('recalc1', 'New points')
        ), # tabPanel - Random 1
        tabPanel
        (
            'Random Data 2',value='Random'
            ,br()
            ,leafletOutput('mymap2',width = 800, height = 800)
            ,p()
            ,actionButton('recalc2', 'New points')
        ) # tabPanel - Random 2
    ) # tabsetPanel
) # fluidPage

server = function(input, output, session){
    points1 = eventReactive(
        input$recalc1
        ,{
            cbind(rnorm(NumPoints) / 10 + DataCenterLong, rnorm(NumPoints) / 20 + DataCenterLat)
        }
        ,ignoreNULL=F)
    points2 = eventReactive(
        input$recalc2
        ,{
            cbind(rnorm(NumPoints) / 10 + DataCenterLong, rnorm(NumPoints) / 20 + DataCenterLat)
        }
        ,ignoreNULL=F)


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
    output$mymap2 = renderLeaflet({
        leaflet() %>%
            addProviderTiles(
                'OpenStreetMap.BlackAndWhite'
                ,options=providerTileOptions(noWrap=T)
        ) %>%
            addMarkers(data=points2())
    })
} # server

shinyApp(ui, server)
