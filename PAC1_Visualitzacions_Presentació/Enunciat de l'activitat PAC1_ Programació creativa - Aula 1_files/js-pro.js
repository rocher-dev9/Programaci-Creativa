// Store current URL
let currentUrl = window.location.href;

function uocWaitForElm(selector) {
  return new Promise(resolve => {
      if (document.querySelector(selector)) {
          return resolve(document.querySelector(selector));
      }

      const observer = new MutationObserver(mutations => {
          if (document.querySelector(selector)) {
              observer.disconnect();
              resolve(document.querySelector(selector));
          }
      });

      observer.observe(document.body, {
          childList: true,
          subtree: true
      });

    });
}
$(function() {
  if ( currentUrl.search(/.*courses\/\d+\/users/) != -1 )  {
    uocWaitForElm('select[name="enrollment_role_id"]')
      .then((selectEl) => {
        $(selectEl).find('option').each((index, element) => {
          const $element = $(element);
          if ($element.text().endsWith(' (0)')) {
            $element.hide();
          }
        });
      });
  }




const hideInactiveUsers = true;
const reorderInactiveUsers = true;
if ( currentUrl.search(/.*courses\/\d+\/users/) != -1 ) {
  uocWaitForElm('select[name="enrollment_role_id"]').then((elm) => {
    $("select$[name='enrollment_role_id'] option").each(function(ind, element) {
      if ($(element).text().endsWith(" (0)")) {
          $(element).hide();
      }
    }); 
    if (hideInactiveUsers) {
      $("select$[name='enrollment_role_id']").change(function() {
        setTimeout(function() {
          if (reorderInactiveUsers) {     
            uocReOrderInactiveUsers()
          } else {
            uocHideInactiveUsers();
          }
        }, 500);
      });
    }
  });  
  if (hideInactiveUsers) {
    if (reorderInactiveUsers) {
      $(window).scroll(function() {
        uocReOrderInactiveUsers();
    });
    } else {
      setInterval(function() {
        uocHideInactiveUsers();
      }, 1000);
    }
  }
}

  // If is not admin
const currentUserRoles = ENV["current_user_roles"];
// const isAdmin = currentUserRoles.includes("admin");
const isRootAdmin = currentUserRoles.includes("root_admin");
if (!isRootAdmin) {
    if ( currentUrl.search(/.*courses\/\d+\/settings/) != -1 ) {
      $("#course_course_grading_standard_enabled").attr("disabled", "disabled");
      function ejecutarCadaSegundo() {
        $("#grading-schemes-selector-dropdown").attr("disabled", "disabled");
          $("#grading_scheme_selector .css-19i4e00-textInput__layout span").css('background-color', '#F3F3F3');
  
      }
      const intervaloId = setInterval(ejecutarCadaSegundo, 1000);
      setTimeout(function() {
        clearInterval(intervaloId);
      }, 10000);
    }
    if ( currentUrl.search(/.*courses\/\d+\/assignments/) != -1 || window.location.href.toLowerCase().includes("edit")){
    let contador = 0;
    const intervalo = setInterval(function() {
        contador++;
        $("#assignment_grading_type").change(function() {
          $("#grading-schemes-selector-dropdown").attr("disabled", "disabled");
          $("#grading_scheme_selector-target .css-19i4e00-textInput__layout span").css('background-color', '#F3F3F3');
  
          setTimeout(function() {
            $("#grading-schemes-selector-dropdown").attr("disabled", "disabled");
            $("#grading_scheme_selector-target .css-19i4e00-textInput__layout span").css('background-color', '#F3F3F3');
          }, 300);
        });
        // $("#assignment_grading_type").attr("disabled", "disabled");
        $("#grading-schemes-selector-dropdown").attr("disabled", "disabled");
        $("#grading_scheme_selector-target .css-19i4e00-textInput__layout span").css('background-color', '#F3F3F3');
        if (contador >= 5) {
            clearInterval(intervalo);
        }
    }, 1000);



    }
    if ( currentUrl.search(/.*courses\/\d+\/assignments/) != -1 || window.location.href.toLowerCase().includes("edit")) {
      let contador2 = 0;
      const intervalo2 = setInterval(function() {
        contador2++;
        $("select#assignment_grading_type").change(function() {
          setTimeout(function() {
            $("p#view-grading-levels").hide();
          }, 0);
          setTimeout(function() {
            $("p#view-grading-levels").hide();
          }, 300);
        });
        $("p#view-grading-levels").hide();
        if (contador2 >= 10) {
          clearInterval(intervalo2);
        }
      } , 1000);
    }


} else {
  // If current URL is courses settings
  if ( currentUrl.search(/.*courses\/\d+\/settings/) != -1 ) {
    setTimeout(function() {
      $("#grading_scheme_selector > span > span > div > button").show();
      $("#grading_scheme_selector > div > button").show();
    }, 1000);
  }
  if ( currentUrl.search(/.*courses\/\d+\/assignments/) != -1 || currentUrl.search(/.*courses\/\d+\/discussion_topics/) != -1 ) {
    uocShowGrading()

    setTimeout(function() {
      $("select#assignment_grading_type").change(function() {
        setTimeout(function() {
          uocShowGrading();
        }, 0);
        setTimeout(function() {
          uocShowGrading();
        }, 300);
      });
      uocShowGrading();
    }, 1000);    
  }
}
});

function uocReOrderInactiveUsers() {
  uocWaitForElm('table.roster').then((elm) => {
    $('table.roster tr.rosterUser td a.roster_user_name').parent().children('span.label').parent().parent().appendTo('table.roster');
  });
}

function uocHideInactiveUsers() {
  $('table.roster tr.rosterUser td a.roster_user_name').parent().children('span.label').parent().parent().remove();  
}

function uocWaitForElm(selector) {
  return new Promise(resolve => {
      if (document.querySelector(selector)) {
          return resolve(document.querySelector(selector));
      }

      const observer = new MutationObserver(mutations => {
          if (document.querySelector(selector)) {
              observer.disconnect();
              resolve(document.querySelector(selector));
          }
      });

      observer.observe(document.body, {
          childList: true,
          subtree: true
      });

    });
}



function uocShowGrading() {
  $("#grading_scheme_selector-target > span > span button").show();
  $("div#grading_scheme_selector-target > div > button").show();
}

// Multilingual
var MULTILINGUAL_ENV = {
  domain: "https://multilingual-translation-prod.herokuapp.com/",
  organization_id: 1,
  script: "https://multilingual-translation-prod.herokuapp.com/js_override.js",
}

var MULTILINGUAL_ENV_PRE = {
  domain: "https://multilingual-translation-test.herokuapp.com/",
  organization_id: 2,
  script: "https://multilingual-translation-test.herokuapp.com/js_override.js",
}

function uocIsPre() {
  return window.location.hostname === 'uoc.test.instructure.com';
}
  
$.getScript(uocIsPre() ? MULTILINGUAL_ENV_PRE.script :  MULTILINGUAL_ENV.script);

// Impact: Launching from the Canvas Help Menu button
function uocRemoveHelpLinkBindings() {
  $('#global_nav_help_link').unbind();
  setTimeout(uocRemoveHelpLinkBindings, 1000);
}
setTimeout(uocRemoveHelpLinkBindings, 500);
$(document).on('click', "#global_nav_help_link", function(event) {
    window.dispatchEvent(new Event('eesy_launchSupportTab'));
    event.preventDefault();
  }
);

/*
setTimeout(function() {
  var iframes = document.querySelectorAll('iframe');
  for (var i = 0; i < iframes.length; i++) {
      if (iframes[i].src.includes("https://uoc.test.instructure.com/courses/")|| iframes[i].src.includes("https://uoc.instructure.com/courses/")|| iframes[i].src.includes("https://uoc.beta.instructure.com/courses/")|| iframes[i].src.includes("aula.uoc.edu/courses/")){
          iframes[i].style.minHeight = "400px";
      }
  }
  }, 3000);    */

if (typeof ENV!== 'undefined' && typeof ENV["BLUEPRINT_COURSES_DATA"]!== 'undefined') {
  if(ENV["BLUEPRINT_COURSES_DATA"]["isMasterCourse"]){
    $("#application .ic-app-nav-toggle-and-crumbs").css("background-color", "#D8D8EA");
    $("#application .ic-app-nav-toggle-and-crumbs #breadcrumbs").css("background-color", "#D8D8EA");
    $(".ic-Layout-columns #left-side #sticky-container").css("background-color", "#D8D8EA");
    $(".ic-Layout-columns #left-side .nav-icon").css("background-color", "#D8D8EA");
  }
}


//Activacion Smowl 

/**
 * Execute when the page is loaded
 */
$(document).ready(function () {
  loadScriptSmowl("https://elearnlab.s3.eu-west-1.amazonaws.com/js/uoc-canvas-20240111_pro_smowl_chat.js");
});
if (typeof loadScriptSmowl !== 'function') {
  /**
   * Function to loaded external script
   */
  function loadScriptSmowl(url) {
    let script = document.createElement("script");
    script.type = "text/javascript";
    script.src = url;
    document.getElementsByTagName("head")[0].appendChild(script);
    return false;
  }
}

if(window.location.href.toLowerCase().includes("gradebook")){

  function txtLiteralButton(){
    const idioma= ENV["MOMENT_LOCALE"];
    let button = '';
    let select = '';
    switch (idioma) {
      case 'es':
        button = 'Publica las notas totales';
        select = 'Publica / despublica las notas totales';
          break;
      case 'ca':
        button = 'Publica les notes totals';
        select = 'Publica / despublica les notes totals';
          break;
      case 'en':
        button = "Publish grade totals";
        select = 'Publish / Hide grade totals';
          break;
      default:
        button = 'Publica les notes totals';
        select = 'Publica / despublica les notes totals';
  }


    $(" button#Menu__label_2 .css-mhq5yr-view span").html(button);
    $("button#Menu__label_2").click(function() {
      setTimeout(function() {
        $('li span[data-menu-id="post_grades_lti_126"]').html(select);
      }, 1); 
    });
    if (typeof ENV!== 'undefined' && typeof ENV["BLUEPRINT_COURSES_DATA"]!== 'undefined') {
    if(ENV["BLUEPRINT_COURSES_DATA"]["isMasterCourse"]){
      $("button#Menu__label_2").hide();
    }
    }
  }

function txtTitlePopup(){
  const idioma= ENV["MOMENT_LOCALE"];
                  let titulo = '';
                  switch (idioma) {
                    case 'es':
                        titulo = 'Publicar / Despublicar les notes totals';
                        break;
                    case 'ca':
                      titulo = 'PublicaciÃ³ / DespublicaciÃ³ les notes totals';
                        break;
                    case 'en':
                      titulo = "Publish  / Hide the students' grade totals";
                        break;
                    default:
                      titulo = 'PublicaciÃ³ / DespublicaciÃ³ les notes totals';
                }
                  $(".ui-dialog-title").html("<p>"+titulo+"</p>");
}

let contador = 0;
const intervalo = setInterval(function() {
    contador++;
    txtLiteralButton();
    if (contador >= 10) {
        clearInterval(intervalo);
    }
}, 1000);


  window.addEventListener('load', function() {
   
    const targetDivSelector1 = '#gradebook-actions';
    const container1 = document.getElementById('application');
    const observer1 = new MutationObserver((mutationsList, observer) => {
        for (let mutation1 of mutationsList) {
            if (mutation1.type === 'childList') {
                const specificDiv1 = document.querySelector(targetDivSelector1);
                if (specificDiv1) {
                  txtLiteralButton();
                observer1.disconnect();
                }
            }
        }
    });
    const config1 = { childList: true, subtree: true };
    observer1.observe(container1, config1);
  });
  
  
  const targetDivSelector = '.post-grades-frame-dialog';
  const container = document.getElementById('application');
  const observer = new MutationObserver((mutationsList, observer) => {
      for (let mutation of mutationsList) {
          if (mutation.type === 'childList') {
              const specificDiv = document.querySelector(targetDivSelector);
              if (specificDiv) {
                txtTitlePopup();
              }
          }
      }
  });
  const config = { childList: true, subtree: true };
  observer.observe(container, config);
  }

  if(window.location.href.toLowerCase().includes("assignments")){
    uocWaitForElm('.assignment-list').then((elm) => {
      setTimeout(function() {
        $('.icon-post-to-sis').remove(); 
      }, 1000);  
      let contador3 = 0;
      const intervalo3 = setInterval(function() {
          contador3++;
          $(".ui-kyle-menu a.edit_assignment").click(function() {
            setTimeout(function() {
            $('fieldset .control-group').has('.control-label').hide();
            }, 50);
          });
      }, 500);
    }); 
  }

  if(window.location.href.toLowerCase().includes("quizzes")){
    uocWaitForElm('.collectionViewItems').then((elm) => {
        let contador4 = 0;
        const intervalo4 = setInterval(function() {
            contador4++;
            $('.icon-post-to-sis').remove(); 
            if (contador4 >= 5) {
                clearInterval(intervalo4);
            }
        }, 1000);
    }); 
  }



//ocultar Sincronitza amb SIS
if(window.location.href.toLowerCase().includes("assignments")){
  uocWaitForElm('#edit_assignment_form').then((elm) => {
  $('#graded_assignment_fields>div').has('input[name="post_to_sis"]').hide();
}); 
  uocWaitForElm('.item-group-condensed .ig-header i.icon-plus').then((elm) => {
    $(".item-group-condensed .ig-header i.icon-plus").click(function() {
      setTimeout(function() {
      $('fieldset .control-group').has('.control-label').hide();
      }, 100); 
    });


  }); 
}