I18N =
  "app":
    "fr":
      "explication" : "Le but de ce questionnaire n’est pas de rechercher une bonne réponse mais de vous permettre d’identifier votre attitude ainsi que des autres camarades et m’aider à mieux vous connaître et m’adapter à votre situation. Faites glisser les différentes phrases dans les cases correspondantes."
      "Les 2 plus" : "Les 2 qui me correspondent le plus"
      "Les 2 peu"     : "Les 2 qui me correspondent peu"
      "Les 2 sans opinion" : "Les 2 pour lesquelles je n’ai pas d’opinion"
      "Les 2 pas trop"    : "Les 2 qui me correspondent pas trop"
      "les 2 pas du tout" : "Les 2 qui me correspondent pas du tout"
    "re":
      "explication" : "té lé difficil pou espliké !"
      "Les 2 plus" : "bann 2 le plus"
      "Les 2 peu"     : "bann 2 inn bout"
      "Les 2 sans opinion" : "bann 2 pa la ek sa !"
      "Les 2 pas trop"    : "bann 2 pa trotro"
      "les 2 pas du tout" : "bann 2 pa di tou"
    "uk":
      "explication" : "The purpose of this questionnaire is not to find a good answer but to help you identify your attitude as well as other friends and help me get to know you and adapt to your situation. Drag the sentences in the corresponding frames."
      "Les 2 plus" : "The 2 that correspond the most to me"
      "Les 2 peu"     : "The 2 corresponding a bit to me"
      "Les 2 sans opinion" : "The 2 whom I do not have an opinion"
      "Les 2 pas trop"    : "The 2 who do not fit me too"
      "les 2 pas du tout" : "The 2 that do not correspond to me at all"
  "qsort":
    "fr":
      1: "Arthaud"
      2: "Dupont-Aignan"
      3: "Le Pen"
      4: "Asselineau"
      5: "Fillon"
      6: "Mélenchon"
      7: "Lassalle"
      8: "Cheminade"
      9: "Macron"
      10: "Hamon"
    "re":
      1: "Arthaud"
      2: "Dupont-Aignan"
      3: "Le Pen"
      4: "Asselineau"
      5: "Fillon"
      6: "Mélenchon"
      7: "Lassalle"
      8: "Cheminade"
      9: "Macron"
      10: "Hamon"
    "uk":
      1: "Arthaud"
      2: "Dupont-Aignan"
      3: "Le Pen"
      4: "Asselineau"
      5: "Fillon"
      6: "Mélenchon"
      7: "Lassalle"
      8: "Cheminade"
      9: "Macron"
      10: "Hamon"


CHOICES = 10
IDS = [1911008042, 2060227356, 1552551457, 441796097, 1823859130, 1887310124, 377892327, 945229228, 1764134384, 1332486413]
URL = "https://docs.google.com/forms/d/1oXe3VZp31tv28lsCEEQEGynQKHHbHHcqGRyWEfC_FV4/viewform?"

url=""

update_count = ->
  $( ".connectedSortable" ).each -> $( this ).prevAll( "p.caption:first" ).find( ".count").html $( this ).children().length

  if $( "#container li" ).length is CHOICES
    i = 0
    url = URL
    $( "#2 li" ).each  -> url+="entry.#{IDS[i++]}=#{$( this ).attr( 'data-item' )}&"
    $( "#1 li" ).each  -> url+="entry.#{IDS[i++]}=#{$( this ).attr( 'data-item' )}&"
    $( "#0 li" ).each  -> url+="entry.#{IDS[i++]}=#{$( this ).attr( 'data-item' )}&"
    $( "#-1 li" ).each -> url+="entry.#{IDS[i++]}=#{$( this ).attr( 'data-item' )}&"
    $( "#-2 li" ).each -> url+="entry.#{IDS[i++]}=#{$( this ).attr( 'data-item' )}&"
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
      $( "#origin" ).append "<li class='ui-state-default' data-item='#{i}'>#{qsort[i]}</li>"
   
    c = [2, 1, 0, -1, -2]
    n = [2, 2, 2, 2, 2 ] 
    t = [app["Les 2 plus"], app["Les 2 peu"], app["Les 2 sans opinion"], app["Les 2 pas trop"], app["les 2 pas du tout"]]   
   
    for i in [0..4]
      html = "<p class='caption'>#{t[i]} (<span class='count'>0</span>/#{n[i]})</p><ul id='#{c[i]}' class='connectedSortable destination' data-coeff='#{c[i]}' data-max='#{n[i]}'></ul>"
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
      
    $( ".destination" ).sortable
      receive: (event, ui) ->
        m = parseInt $(this).attr("data-max")
        if ($(this).children().length > m )
          alert "Attention #{m} max ! Liberez en un avant !"
          $(ui.sender).sortable('cancel')
        update_count()
      
  set_language("fr")
    
  $( "body" ).on "click", "#go", -> window.location.href = url
  $( "body" ).on "click", ".question", -> $( ".explanation" ).dialog("open")
