I18N =
  "app":
    "fr":
      "explication" : "Donner à chaque candidat-e une note allant de 1 (candidat dont on ne veut surtout pas) à 11 (candidat préféré). Chaque note ne doit être attribuée qu'une fois"
      
    "re":
      "explication" : "Oté ! Donn lo kandida lo poin 1 (kandida sa lé mol) ziska 11 (kandida sa lé gadiamb). insel note insel foi !"
     
    "uk":
      "explication" : "Donner à chaque candidat-e une note allant de 1 (candidat dont on ne veut surtout pas) à 11 (candidat préféré). Chaque note ne doit être attribuée qu'une fois"

  "qsort":
    "fr":
      1: "Nathalie Arthaud"
      2: "François Asselineau"
      3: "Jacques Cheminade"
      4: "Nicolas Dupont-Aignan"
      5: "François Fillon"
      6: "Benoît Hamon"
      7: "Jean Lassalle"
      8: "Marine Le Pen"
      9: "Emmanuel Macron"
      10: "Jean-Luc Mélenchon"
      11: "Philippe Poutou"
    "re":
      1: "Nathalie Arthaud"
      2: "François Asselineau"
      3: "Jacques Cheminade"
      4: "Nicolas Dupont-Aignan"
      5: "François Fillon"
      6: "Benoît Hamon"
      7: "Jean Lassalle"
      8: "Marine Le Pen"
      9: "Emmanuel Macron"
      10: "Jean-Luc Mélenchon"
      11: "Philippe Poutou"
    "uk":
      1: "Nathalie Arthaud"
      2: "François Asselineau"
      3: "Jacques Cheminade"
      4: "Nicolas Dupont-Aignan"
      5: "François Fillon"
      6: "Benoît Hamon"
      7: "Jean Lassalle"
      8: "Marine Le Pen"
      9: "Emmanuel Macron"
      10: "Jean-Luc Mélenchon"
      11: "Philippe Poutou"

CHOICES = 11
IDS = [0, 1230461260, 657859686, 112920957, 847960702, 2137008777, 1089137606, 470126607, 1505200759, 1375971800, 844555006, 855634272]
URL = "https://docs.google.com/forms/d/e/1FAIpQLSd-W4TlNjbg7n9KtQU09RiEpKz2kZI4qJpDwI3RjMMOQqKKgA/viewform?"

url=""

update_count = ->
  if $( "#container li" ).length is CHOICES
    i = 0
    url = URL
    $( ".candidat" ).each -> url+="entry.#{$( this ).attr('data-id')}=#{CHOICES-i++}&"    
    $( "#origin" ).before "<button id='go' data-url='#{url}'>Go</button>"
  else $( "#go" ).remove()

$ ->
  set_language = (lang) ->
    $( "#container, #origin" ).empty()
    qsort = I18N["qsort"][lang]
    app = I18N["app"][lang]
    
    $( ".explanation" )
      .html app["explication"]
      .dialog()
      
    for i in [1..CHOICES]
      $( "#origin" ).append "<li class='ui-state-default candidat' data-id='#{IDS[i]}'>#{qsort[i]}</li>"
   
    html = "<p class='caption'><h1>Classement :</h1><ul id='destination' class='connectedSortable destination'></ul></p>"
    $( "#container" ).append html
    
    $( "#langage" )
      .selectmenu()
      .on "selectmenuchange", ->
        lang = $(this).val()
        set_language(lang)      
       
    $( ".connectedSortable" )
      .sortable
        connectWith: ".connectedSortable"
        placeholder: "pholder"
        dropOnEmpty: true
      .disableSelection()
     
    $( "#origin" ).sortable
      receive: (event, ui) -> update_count()
      
    $( "#destination" ).sortable
      receive: (event, ui) -> update_count()
      stop: (event, ui) -> update_count()
      
  set_language("fr")
    
  $( "body" ).on "click", "#go", -> window.location.href = url
  $( "body" ).on "click", ".question", -> $( ".explanation" ).dialog("open")
