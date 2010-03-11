const nsISupports = Components.interfaces.nsISupports;
const nsIDOMEventTarget = Components.interfaces.nsIDOMEventTarget;

// You can change these if you like
const CLASS_ID = Components.ID("7a44e0ce-757a-4f65-93aa-b05a377558a7");
const CLASS_NAME = "c-speeddial";
const CONTRACT_ID = "@uworks.net/speeddialcache;1";
const INTERFACE = Components.interfaces.nsISupports;

// This is your constructor.
// You can do stuff here.
function SpeedDialCache() {
  // you can cheat and use this
  // while testing without
  // writing your own interface
  this.wrappedJSObject = this;
}

// This is the implementation of your component.
SpeedDialCache.prototype = {
  imageArray: new Array(),
  hiddenWindow: null,
  currentInstances: 0,

  // for nsISupports
  QueryInterface: function(aIID)
  {
    // add any other interfaces you support here
    if (!aIID.equals(INTERFACE) && !aIID.equals(nsISupports))
        throw Components.results.NS_ERROR_NO_INTERFACE;
    return this;
  },

  getImage: function(targetDial)
  {
    if ((targetDial >= this.imageArray.length) || (!this.imageArray[targetDial])) {
      return null;
    } else {
      return this.imageArray[targetDial];
    }
  },
  
  hasImage: function(targetDial)
  {
    return ((targetDial < this.imageArray.length) && (this.imageArray[targetDial]));
  },

  setImage: function(targetImageURL, targetDial) {
    if (targetImageURL == null) {
      this.imageArray[targetDial] = null;
    } else {
      if (this.hiddenWindow == null) {
        this.hiddenWindow = Components.classes["@mozilla.org/appshell/appShellService;1"]
           .getService(Components.interfaces.nsIAppShellService)
           .hiddenDOMWindow;
         this.hiddenWindow.Components.classes["@mozilla.org/moz/jssubscript-loader;1"]
           .getService(Components.interfaces.mozIJSSubScriptLoader)
           .loadSubScript("chrome://speeddial/content/hiddenWindow.js");
      }
      var newImage = this.hiddenWindow.speedDialCreateImage();
      newImage.imageLoaded = false;
      newImage.addEventListener("load", function(event) {
        if (event.currentTarget.notifyDials != null) {
          for (var c=0; c<event.currentTarget.notifyDials.length; c++) {
            try {
              event.currentTarget.notifyDials[c].imageLoadComplete(event);
            } catch (e) {
              Components.utils.reportError("Error calling imageLoadComplete: " + e);
            }
          }
          event.currentTarget.notifyDials.length = 0;
          event.currentTarget.notifyDials = null;
        }
        event.currentTarget.imageLoaded = true;
      }, true);
      
      if (this.imageArray[targetDial]) {
        if (this.imageArray[targetDial].notifyDials) {
          newImage.notifyDials = this.imageArray[targetDial].notifyDials;
          this.imageArray[targetDial].notifyDials = null;
        }
        if ((this.imageArray[targetDial].imageLoaded) ||
            (this.imageArray[targetDial].width != 0)) {
          newImage.prevWidth = this.imageArray[targetDial].width;
          newImage.prevHeight = this.imageArray[targetDial].height;
        } else {
          newImage.prevWidth = this.imageArray[targetDial].prevWidth;
          newImage.prevHeight = this.imageArray[targetDial].prevHeight;
        }
      }
      
      newImage.src = targetImageURL;
      
      this.imageArray[targetDial] = newImage;
    }
  },

  setImageObject: function(targetImage, targetDial) {
    this.imageArray[targetDial] = targetImage;
  },

  getNumberInstances: function() {
    return this.currentInstances;
  },

  addInstance: function() {
    this.currentInstances++;
  },

  removeInstance: function() {
    this.currentInstances--;
  }
}

//=================================================
// Note: You probably don't want to edit anything
// below this unless you know what you're doing.
//
// Factory
var SpeedDialCacheFactory = {
  singleton: null,
  createInstance: function (aOuter, aIID)
  {
    if (aOuter != null)
      throw Components.results.NS_ERROR_NO_AGGREGATION;
    if (this.singleton == null)
      this.singleton = new SpeedDialCache();
    return this.singleton.QueryInterface(aIID);
  }
};

// Module
var SpeedDialCacheModule = {
  registerSelf: function(aCompMgr, aFileSpec, aLocation, aType)
  {
    aCompMgr = aCompMgr.QueryInterface(Components.interfaces.nsIComponentRegistrar);
    aCompMgr.registerFactoryLocation(CLASS_ID, CLASS_NAME, CONTRACT_ID, aFileSpec, aLocation, aType);
  },

  unregisterSelf: function(aCompMgr, aLocation, aType)
  {
    aCompMgr = aCompMgr.QueryInterface(Components.interfaces.nsIComponentRegistrar);
    aCompMgr.unregisterFactoryLocation(CLASS_ID, aLocation);        
  },
  
  getClassObject: function(aCompMgr, aCID, aIID)
  {
    if (!aIID.equals(Components.interfaces.nsIFactory))
      throw Components.results.NS_ERROR_NOT_IMPLEMENTED;

    if (aCID.equals(CLASS_ID))
      return SpeedDialCacheFactory;

    throw Components.results.NS_ERROR_NO_INTERFACE;
  },

  canUnload: function(aCompMgr) { return true; }
};

//module initialization
function NSGetModule(aCompMgr, aFileSpec) { return SpeedDialCacheModule; }