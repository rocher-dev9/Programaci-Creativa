let ENTITY_NAME = '';
let SMOWL_LICENSE_KEY = '';
let SMOWL_CM = true;
let SMOWL_LOCK = false;
if (ENV.ACCOUNT_ID) {
  const SMOWL_PILOT_ACCOUNTS = [7951, 7956, 7959, 7656, 6350, 3083, 3069, 2831, 2861, 6646, 7219, 6769, 7310];
  const SMOWL_CURRENT_ACCOUNT_ID = parseInt(ENV.ACCOUNT_ID, 10);
  const ENABLE_ZEND_DESK_CHAT = false;
  if (SMOWL_PILOT_ACCOUNTS.includes(SMOWL_CURRENT_ACCOUNT_ID)) {
    if (SMOWL_CURRENT_ACCOUNT_ID == 7951) {
      ENTITY_NAME = 'TRIALUOC';
      SMOWL_LICENSE_KEY = 'a816dcc84f781baf6e08dc09d0a8bbe1b4d040f5';
      SMOWL_CM = true;
      SMOWL_LOCK = false;
    }
    else {
      ENTITY_NAME = 'ESUOC24';
      SMOWL_LICENSE_KEY = 'e270f0b311237b465c7c52200fff3ac086645b8e';
      SMOWL_CM = true;
      SMOWL_LOCK = true;
    }
    const SMOWL_EXTERNAL_TOOLS_ID = [8086, 8547, 8548, 8549, 8550, 8551, 8552, 8553, 8554, 8555, 8570, 8571, 8572];
    const SMOWL_LTI_URL = 'https://lti-smowl-global.smowltech.net/lti/login';

    /**
     * Execute when the page is loaded
     */
    $(document).ready(function () {
      loadScriptSmowlCustom("https://resources.smowltech.net/lti/canvas/smowl_canvasv2.min.js", false);
      
      if (hasToEnableChatSmowl()) {
        if ((ENV.current_user && ENV.current_user.fake_student) || ENV.current_user_is_student) {
          loadScriptSmowlCustom("https://static.zdassets.com/ekr/snippet.js?key=35302ccf-258c-457c-837a-4130d445a1ec", "ze-snippet");
        }
      }
    });

    if (typeof checkIfIsSmowlExternalTool !== 'function') {
      function checkIfIsSmowlExternalTool() {
        const currentUrlChat = window.location.href;

        const regex = /.*courses\/\d+\/external_tools\/(\d+)/;

        let found = false;
        let m;

        if ((m = regex.exec(currentUrlChat)) !== null) {
          // The result can be accessed through the `m`-variable.
          m.forEach((match, groupIndex) => {
            console.log(" match ", match, "groupIndex", groupIndex);
            if (groupIndex == 1) {
              found = SMOWL_EXTERNAL_TOOLS_ID.includes(parseInt(value, 10));
            }
          });
        }    
        if (found) {
          let isFrame = false;
          try {
            isFrame = window.self !== window.top;
          } catch (e) {        
          }
          if (isFrame) {
            jQuery('#header').hide();
            jQuery('body:not(.no-headers) .ic-Layout-wrapper').css('margin-left', '0px');
            jQuery('#left-side').hide();
            jQuery('div.ic-app-nav-toggle-and-crumbs').hide();
            jQuery('body.course-menu-expanded div#main').attr('style', 'margin-left: 1px !important');
            return true;
          }
        }
        return false;
      }
    }

    if (typeof hasToEnableChatSmowl !== 'function') {
      function hasToEnableChatSmowl() {
        if (ENABLE_ZEND_DESK_CHAT) {
          if (ENV && ENV.LTI_TOOL_FORM_ID && jQuery('#tool_form_' + ENV.LTI_TOOL_FORM_ID).length == 1) {
            if (SMOWL_LTI_URL == jQuery('#tool_form_' + ENV.LTI_TOOL_FORM_ID).attr('action')) {
              return true;
            }
          }
          const currentUrlChat = window.location.href;
          if ( currentUrlChat.search(/.*courses\/\d+\/assignments/) >= 0
          || currentUrlChat.search(/.*courses\/\d+\/external_tools\/retrieve/) >= 0
          )  {
            return currentUrlChat.indexOf('smowl_bridge') !== -1;
          }  
        }
        return false;
      }
    }


    if (typeof loadScriptSmowlCustom !== 'function') {
      /**
       * Function to loaded external script
       */    
      function loadScriptSmowlCustom(url, id) {
        let script = document.createElement("script");
        script.type = "text/javascript";
        script.src = url;
        if (id) {
          script.id= id;
        }
        document.getElementsByTagName("head")[0].appendChild(script);
        return false;
      }
    }
  }
}