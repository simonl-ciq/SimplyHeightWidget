using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Timer;

/*
	var myTimer;
	var myCount;
	
    myTimer = new Timer.Timer();
    
	function timerCallback() {
    	myCount += 1;
	    if (myCount >= 10) {
	    	myTimer.stop();
//	Sys.println("long press");
    		toggleIt();
    	}
	}

    function onKeyPressed(evt) {
	    var key = evt.getKey();
//Sys.println("key " + key);
    	if (key != 4) {return false;}
    	if (myCount == 0) {
	    	myTimer.start(method(:timerCallback), 100, true);
        	return true;
    	}
    	return false;
    }

    function onKeyReleased(evt) {
	    var key = evt.getKey();
    	if (key != 4) {return false;}
    	myTimer.stop();
    	myCount = 0;
        return true;
    }

    function zeroIt() {
//       	Sys.println("zeroIt");
        SHWview.updateZero();
        // and force a redraw
        Ui.requestUpdate();
        return true;
    }

    function resetIt() {
//       	Sys.println("resetIt");
        SHWview.resetZero();
        // and force a redraw
        Ui.requestUpdate();
        return true;
    }
*/

class SimplyHeightWidgetDelegate extends Ui.BehaviorDelegate {
    /* Initialize and get a reference to the view, so that
     * user iterations can call methods in the main view. */
    var SHWview;

    function initialize(view) {
        Ui.BehaviorDelegate.initialize();
        SHWview = view;
    }

    function onSelect() {
//		Sys.println("Select");
        // force a redraw
        updateIt();
        return true;
    }

    // Menu button press.
    function onMenu() {
//		Sys.println("Menu");
        toggleIt();
        return true;
    }

    function updateIt() {
       	//		Sys.println("updateIt");
        // force a redraw
        Ui.requestUpdate();
        return true;
    }

    function toggleIt() {
//		Sys.println("toggleIt");
        SHWview.toggleZero();
        // and force a redraw
        Ui.requestUpdate();
        return true;
    }
}
