using Toybox.WatchUi as Ui;
using Toybox.Application;
using Toybox.Application.Storage as Storage;
using Toybox.Application.Properties as Properties;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Sensor as Sensor;

const cAltMsg = "Above Sea Level";
const cHtMsg  = "Above Ground Level";

class SimplyHeightWidgetView extends Ui.View {
	hidden var mNotMetric = false;  // ie they are Sys.UNIT_METRIC by default
	hidden var mConvert = 1.0;
	hidden var mAGL = false;
	hidden var mTitle = "Altitude";
	hidden var mSubTitle = "MSL";
	hidden var mBase = 0;
    hidden var mAltMsg;
    hidden var mHtMsg;

    function initialize() {
    	var tmp;

		mNotMetric = Sys.getDeviceSettings().elevationUnits != Sys.UNIT_METRIC;
    	mConvert = mNotMetric ? 3.280839895 : 1.0;
        tmp = Storage.getValue("base");
        if (tmp == null) {
	        Storage.setValue("base", mBase);
    	} else {
    		mBase = tmp;
    	}
        tmp = Storage.getValue("AGL");
        if (tmp == null) {
	        Storage.setValue("AGL", mAGL);
    	} else {
    		mAGL = tmp;
    	}

// We know application uses Properties as this app is only for 2.4.0 and above
        tmp = Properties.getValue("altMsg");
	    mAltMsg = (tmp == null) ? cAltMsg : tmp;
       	tmp = Properties.getValue("htMsg");
	    mHtMsg  = (tmp == null) ? cHtMsg  : tmp;

        View.initialize();
    }

    function toggleZero() {
    	if (!mAGL) {
	    	var sensorInfo = Sensor.getInfo();
	    	if (sensorInfo.altitude != null) {
   				var alt = sensorInfo.altitude;
	    		mTitle = "Height ("+ (mNotMetric ? "ft" : "m") + ")";
	    		mSubTitle = mHtMsg; //"Above Ground Level";
   				mBase = Math.round(alt * mConvert);
		        View.findDrawableById("title").setText(mTitle);
		        View.findDrawableById("subtitle").setText(mSubTitle);
	   	    } else {
				View.findDrawableById("title").setText(mTitle + "\n(can't zero)");
		        View.findDrawableById("subtitle").setText("");
				View.findDrawableById("value").setText("0000");
        	}
        	mAGL = true;
        } else {
        	mBase = 0;
    		mTitle = "Altitude ("+ (mNotMetric ? "ft" : "m") + ")";
    		mSubTitle = mAltMsg; //"Above Sea Level";
	        View.findDrawableById("title").setText(mTitle);
	        View.findDrawableById("subtitle").setText(mSubTitle);
        	mAGL = false;
        }
//mBase = 0;
        Storage.setValue("AGL", mAGL);
        Storage.setValue("base", mBase);
    }

    // Load your resources here
    function onLayout(dc) {
//Sys.println("onLayout");
		View.setLayout(Rez.Layouts.MainLayout(dc));
    	if (!mAGL) {
    		mTitle = "Altitude (" + (mNotMetric ? "ft" : "m") + ")";
    		mSubTitle = mAltMsg; //"Above Sea Level";
    	} else {
    		mTitle = "Height (" + (mNotMetric ? "ft" : "m") + ")";
    		mSubTitle = mHtMsg; //"Above Ground Level";
    	}
        var tView = View.findDrawableById("title");
        var stView = View.findDrawableById("subtitle");
        tView.setText(mTitle);
        stView.setText(mSubTitle);
		stView.locY = tView.locY + dc.getFontHeight(Gfx.FONT_SMALL);
        View.findDrawableById("value").setText("0000");
    }
    
    // Update the view
    function onUpdate(dc) {
//Sys.println("Update");
	    var sensorInfo = Sensor.getInfo();
    	if (sensorInfo.altitude != null) {
   			var alt = sensorInfo.altitude;
   			alt = Math.round(alt * mConvert);
       		var val = ((alt - mBase).toNumber()).toString();
//agl = "612";
			View.findDrawableById("value").setText(val);
   	    } else {
			View.findDrawableById("title").setText(mTitle + "\nnot available");
			View.findDrawableById("subtitle").setText("");
			View.findDrawableById("value").setText("0000");
        }

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
}

(:glance)
class SimplyHeightWidgetGlanceView extends Ui.GlanceView {
	var centre=80;
	var vcentre=80;
	var appName = "Above Ground";

	function initialize() {
    	var temp;
		GlanceView.initialize();
        temp = Ui.loadResource( Rez.Strings.AppName );
        if (temp != null ) {appName = temp;}
	}
	
	function onLayout(dc) {

		var dim = dc.getTextDimensions(appName, Gfx.FONT_SMALL);
		centre = dim[0] / 2;
		vcentre = dim[1] - 15;
	}

	function onUpdate(dc) {
		dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_BLACK);
		dc.clear();
		dc.setColor(Graphics.COLOR_WHITE,Graphics.COLOR_TRANSPARENT);

		dc.drawText(0, 15, Graphics.FONT_SMALL,appName, Graphics.TEXT_JUSTIFY_LEFT);
	}
}
