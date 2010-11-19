

if ("undefined" == typeof(hongxingextension)) {  

	var hongxingextension = {
	
	  onLoad: function() {
		// initialization code
		this.initialized = true;
		//this.bundlestrings = document.getElementById("hongxingextension-strings-bundle");
		
		document.getElementById("contentAreaContextMenu")
			  .addEventListener("popupshowing", function (e){ hongxingextension.onshowFirefoxContextMenu(e); }, false);
	  },
	  
	  onshowFirefoxContextMenu : function(event) {
			// ºì7EA2ÐÓ674Fä¯6D4FÀÀ89C8   ºì7EA2ÐÓ674FËÑ641CË÷7D22
			// show or hide the menuitem based on what the context menu is on
			//document.getElementById("context-hongxingextension").hidden = gContextMenu.onImage;
			var bundlestrings = document.getElementById("hongxingextension-strings-bundle");
			if (gContextMenu.isTextSelected){
				var selectText = this.GetText();
				if (selectText.length>15)
					selectText = selectText.substring(0,15) + "...";	
					
				document.getElementById("context-hongxingextension").label = 
						bundlestrings.getString('hongxingextensionContext_label_search') +" \"" + selectText + "\" " ;			
				
			}else{				
				document.getElementById("context-hongxingextension").label = 
						bundlestrings.getString('hongxingextensionContext_label_load') ;
				
			}
			
		}  ,
		
	  GetLink: function(){
			if (!gContextMenu.onLink && !gContextMenu.onImage)	 
				return "";

			var strUrl = "";
			if (gContextMenu.onLink && (-1 == gContextMenu.link.toString().indexOf("javascript:")))	{
				strUrl = gContextMenu.link.toString();	}
			else{
				strUrl = gContextMenu.target.src;	}
			return strUrl;
		},
		
	  GetText: function () {
			var focusedWindow = document.commandDispatcher.focusedWindow; 
			var winWrapper = new XPCNativeWrapper(focusedWindow, 'getSelection()');
			var searchStr = winWrapper.getSelection().toString();
			return searchStr;
		},
		
	  onMenuItemCommand: function(e) {
		var gtext = this.GetText();
		var glink = this.GetLink();
		
		var q = document.getElementById('content').currentURI.spec ;
		if (glink!='' ){
			q= glink;
		}else if (gtext!=''){
			q= gtext;
		}
		//alert(gtext);	alert(glink );alert(q);		
		var content ='q='+ encodeURIComponent(q);
		//alert(content);
		var postData = Components.classes['@mozilla.org/io/string-input-stream;1'].createInstance(Components.interfaces.nsIStringInputStream);  
		content = 'Content-Type: application/x-www-form-urlencoded\n'+
				'Content-Length: '+content.length+'\n\n'+
				content;  		
		postData.setData(content, content.length);  
		var flags = Components.interfaces.nsIWebNavigation.LOAD_FLAGS_NONE;  
		 
		//browser.loadURI('http://www.hole-on-the-wall.info/');
		var ProxyUrl = 'http://fwall-w.appspot.com/';
		var browser = document.getElementById('content');  
		var tab = browser.addTab(ProxyUrl);
		browser.selectedTab = tab;
		browser.loadURIWithFlags(ProxyUrl, flags, null, null, postData);
		//alert('ok2');  
	  }  
	 
		/*
	  onToolbarButtonCommand: function(e) {
		// just reuse the function above.  you can change this, obviously!
		hongxingextension.onMenuItemCommand(e);
		
	  },
	  */
	
	};
	
	window.addEventListener("load", hongxingextension.onLoad, false);
};  

