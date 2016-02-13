require(shiny)
require(leaflet)

DataCenterLat = 37.5287955
DataCenterLong = -77.493477

# rColors = rgb(t(col2rgb(colors()) / 255))
# names(r_colors) <- colors()

ui = fluidPage(
    leafletOutput('mymap'),
    p(),
    actionButton('recalc', 'New points')
) # fluidPage

server = function(input, output, session){
    points = eventReactive(
        input$recalc
        ,{
            cbind(rnorm(40) / 10 * 2 + DataCenterLong, rnorm(40) / 20 + DataCenterLat)
        }
        ,ignoreNULL=F)

    output$mymap = renderLeaflet({
        leaflet() %>%
            addProviderTiles(
#                'Stamen.TonerLite'
#                'OpenStreetMap.BlackAndWhite'
                'MapQuestOpen.OSM'
                ,options=providerTileOptions(noWrap=T)
        ) %>%
            addMarkers(data=points())
    })
} # server

shinyApp(ui, server)
