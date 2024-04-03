/* SLIDESHOW */
var num_pagina = [1, 1];
mostra_slides(0);
mostra_slides(1);

// Funzione per mostrare la slide desiderata
function mostra_slides(index) {
  var selector = index === 0 ? "#10_feb" : "#23_feb"; // Se la giornata è il 10 febbraio, seleziona la prima slideshow, altrimenti la seconda
  var immagini = $(selector + " .imgDiario"),
    testo = $(selector + " .pagine"),
    hasPreviousPage = num_pagina[index] > 1,
    hasNextPage = num_pagina[index] < immagini.length;

  // Mostra o nascondi i pulsanti di navigazione se la slideshow ha o meno pagine precedenti/successive
  $(selector + " .prev").toggle(hasPreviousPage);
  $(selector + " .next").toggle(hasNextPage);

  // Mostra solo la slideshow desiderata e nasconde tutti gli altri slideshow
  immagini.hide().eq(num_pagina[index] - 1).add(testo.hide().eq(num_pagina[index] - 1)).show();
}

$(".prev, .next").click(function () {
  // Ricava l'indice del contenitore della slideshow e la direzione della freccia cliccata
  var index = $(this).closest('section.row').index('section.row'),
    direzione = $(this).hasClass("prev") ? -1 : 1;

  // Aggiorna il numero di pagina e mostra la slide desiderata
  num_pagina[index] += direzione;
  mostra_slides(index);
});

// Funzione per mostrare/nascondere i pulsanti di navigazione della slideshow
function updateButtonVisibility(sectionId) {
  var offset = 300; // Offset per mantenere visibili i pulsanti anche quando la sezione è parzialmente visibile
  var sectionTop = $(sectionId).offset().top,
    sectionBottom = sectionTop + $(sectionId).outerHeight(),
    windowScrollTop = $(window).scrollTop(),
    windowHeight = $(window).height();

  $(sectionId + ' .prev, ' + sectionId + ' .next').css('position', (windowScrollTop >= sectionTop - offset && windowScrollTop <= sectionBottom - windowHeight + offset) ? 'fixed' : 'absolute');
}

$(window).scroll(function () {
  updateButtonVisibility('#10_feb');
  updateButtonVisibility('#23_feb');
});


// Funzioni focus riga 
$(".areaRiga").hover(function () {
  var idRiga = "#" + this.id;
  document.getElementById(idRiga).classList.add("riga_hover");
}, function () {
  var idRiga = "#" + this.id;
  document.getElementById(idRiga).classList.remove("riga_hover");
});


// Funzione per controllare la visibilità della sezione #giornate per mostrare la legenda
function checkVisibility(selector) {
  var windowTop = $(window).scrollTop(),
    windowBottom = windowTop + $(window).height(),
    sectionTop = $('#giornate').offset().top,
    sectionBottom = sectionTop + $('#giornate').height();

  if (sectionBottom > windowTop && sectionTop < windowBottom) $('#' + selector).slideDown(100);
  else $('#' + selector).slideUp(100);
}

// Esegui il codice solo sugli schermi superiori di 1135px
if ($(window).width() >= 1135) {

  // Controlla la visibilità all'inizio e aggiungi un listener per l'evento scroll
  checkVisibility("pulsanti_legenda");

  $(window).scroll(function () {
    checkVisibility("pulsanti_legenda");

    // Diminuisci il margine del navbar quando la pagina viene scrollata di 100px
    var navbar = $("#navbar");
    if ($(document).scrollTop() > 100) navbar.css("margin", ".2%");
    else navbar.css("margin", "1%");

    // Mostra icona Go to Top quando la pagina viene scrollata di 500px
    var button = $("#scroll_top");
    if ($(document).scrollTop() > 500) button.css("opacity", 1);
    else button.css("opacity", 0);
  });
} else {
  // Nascondi il menu quando si clicca fuori da esso o sul bottone chiudi
  $(document).click(function (event) {
    var menuBtn = $('#hamburger');
    var menu = $('#navbar');

    if (event.target === menuBtn.get(0)) {
      menu.toggleClass('show');
      menuBtn.toggleClass('fa-bars fa-xmark');
    } else if (!menu.has(event.target).length) {
      menu.removeClass('show');
      menuBtn.removeClass('fa-xmark').addClass('fa-bars');
    }
  });
  // Controlla la visibilità all'inizio e aggiungi un listener per l'evento scroll
  checkVisibility("mostra_pulsanti");

  $(window).scroll(function () {
    checkVisibility("mostra_pulsanti");
  });

  // Alterna tra visualizzazione/nascondimento
  $('#mostra_pulsanti').click(function () {
    $('#pulsanti_legenda').toggleClass("active");
    $('#mostra_pulsanti i').toggleClass("fa-ellipsis-vertical fa-xmark");
  });
}


// Seleziona cancellature
$("#cancellature").click(function () {
  $(this).toggleClass('active_leg');
  $(".del").toggle().css({ "color": "#e74c3c", "text-decoration": "line-through" });
});

// Seleziona correzioni
$("#correzioni").click(function () {
  $(this).toggleClass('active_leg');
  $(".corr, .sic").toggle();
  $(".sic").css({ "background-color": "purple", "color": "white" });
});

// Seleziona abbreviazioni
$("#abbreviazioni").click(function () {
  $(this).toggleClass('active_leg');
  $(".abbr, .expan").toggle();
  $(".expan").css({ "background-color": "#f08080" });
});

// Seleziona normalizzazioni
$("#normalizzazioni").click(function () {
  $(this).toggleClass('active_leg');
  $(".reg, .orig").toggle();
  $(".orig").css("background-color", "#ffe062");
});

// Seleziona aggiunte codificatore
$("#aggiunte").click(function () {
  $(this).toggleClass('active_leg');
  if ($(".supplied").css('background-color') === 'rgb(0, 139, 139)') $(".supplied").css('background-color', 'transparent');
  else $(".supplied").css('background-color', 'darkcyan');
})

// Seleziona persone, luoghi e organizzazioni
$("#persone, #luoghi, #organizzazioni").click(function () {
  $(this).toggleClass('active_leg');

  var color, elementClass;
  switch (this.id) {
    case 'persone':
      color = '240, 111, 5';
      elementClass = 'persName';
      break;
    case 'luoghi':
      color = '11, 148, 11';
      elementClass = 'placeName';
      break;
    case 'organizzazioni':
      color = '22, 77, 172';
      elementClass = 'orgName';
      break;
  }

  if ($("." + elementClass).css('border-bottom') === '2.4px solid rgb(' + color + ')') $("." + elementClass).css('border-bottom', 'transparent');
  else $("." + elementClass).css('border-bottom', '3px solid rgb(' + color + ')');
});


// Approfondimenti
function appr_click(listClass, noteClass) {
  $(document).on("click", listClass, function (event) {
    event.preventDefault();

    // Determina l'indice dell'elemento della lista su cui è stato fatto click
    var index = $(listClass).index(this);

    // Seleziona la nota corrispondente all'elemento della lista su cui è stato fatto click
    var currentNote = $(noteClass).eq(index);

    // Seleziona l'icona associata all'elemento della lista su cui è stato fatto click
    var icon = $(this).find('.fa-angle-down');

    // Nascondi tutte le altre note e reimposta l'icona in tutte le categorie
    $('.note_p, .note_l, .note_o').not(currentNote).slideUp();
    $('.fa-angle-down').css('transform', 'rotate(0)');

    // Se la nota corrente è visibile, chiudila e reimposta l'icona
    if (currentNote.is(":visible")) {
      icon.css('transform', 'rotate(0)');
      currentNote.slideUp();
    } else {
      // Altrimenti, ruota l'icona e mostra la nota corrente
      icon.css('transform', 'rotate(-180deg)');
      currentNote.slideDown();
    }
  });
}

appr_click(".persona", ".note_p");
appr_click(".luogo", ".note_l");
appr_click(".organizzazione", ".note_o");