using Toybox.Application as App;

class SimplyHeightWidgetApp extends App.AppBase {
	hidden var HeightView;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        HeightView = new SimplyHeightWidgetView();
        return [ HeightView, new SimplyHeightWidgetDelegate(HeightView) ];
    }

(:glance)
    function getGlanceView() {
        return [ new SimplyHeightWidgetGlanceView() ];
    }

}