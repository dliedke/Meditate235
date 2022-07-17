using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using HrvAlgorithms.HrvTracking;

class SessionPickerDelegate extends ScreenPicker.ScreenPickerDelegate {
	private var mSessionStorage;
	private var mSelectedSessionDetails;
	private var mSummaryRollupModel;
	
	function initialize(sessionStorage, heartbeatIntervalsSensor) {
		ScreenPickerDelegate.initialize(sessionStorage.getSelectedSessionIndex(), sessionStorage.getSessionsCount());	
		me.mSessionStorage = sessionStorage;
		me.mSummaryRollupModel = new SummaryRollupModel();
		me.mSelectedSessionDetails = new ScreenPicker.DetailsModel();	
		me.mLastHrvTracking = null;		
		me.initializeHeartbeatIntervalsSensor(heartbeatIntervalsSensor);
        
		me.globalSettingsIconsYOffset = App.getApp().getProperty("globalSettingsIconsYOffset");
		me.sessionDetailsIconsXPos = App.getApp().getProperty("sessionDetailsIconsXPos");
		me.sessionDetailsValueXPos = App.getApp().getProperty("sessionDetailsValueXPos");
		me.globalSettingsIconsXPos = App.getApp().getProperty("globalSettingsIconsXPos");
		me.sessionDetailsAlertsLineYOffset = App.getApp().getProperty("sessionDetailsAlertsLineYOffset");
		me.sessionDetailsYOffset = App.getApp().getProperty("sessionDetailsYOffset");
		
		me.setSelectedSessionDetails();
	}
	
	private function initializeHeartbeatIntervalsSensor(heartbeatIntervalsSensor) {
		me.mHeartbeatIntervalsSensor = heartbeatIntervalsSensor;
		me.mNoHrvSeconds = MinSecondsNoHrvDetected;
	}
	
	function setTestModeHeartbeatIntervalsSensor(hrvTracking) {	
		if (hrvTracking == me.mLastHrvTracking) {
	        	me.mHeartbeatIntervalsSensor.setOneSecBeatToBeatIntervalsSensorListener(null);
		}
		else {		
				me.mHeartbeatIntervalsSensor.stop();
	        	me.mHeartbeatIntervalsSensor.setOneSecBeatToBeatIntervalsSensorListener(null);
        }
        me.mLastHrvTracking = hrvTracking;
	}
	
	private var mHeartbeatIntervalsSensor;
	private var mLastHrvTracking;
	private var globalSettingsIconsYOffset;
	private var sessionDetailsIconsXPos;
	private var sessionDetailsValueXPos;
	private var globalSettingsIconsXPos;
	private var sessionDetailsAlertsLineYOffset;
	private var sessionDetailsYOffset;
		
    function onMenu() {
		
    }
    
    private const RollupExitOption = :exitApp;
    
    function onBack() {         	
    	if (me.mSummaryRollupModel.getSummaries().size() > 0) {
    		var summaries = me.mSummaryRollupModel.getSummaries();
    		
    		var summaryRollupMenu = new Ui.Menu();
			summaryRollupMenu.setTitle(Ui.loadResource(Rez.Strings.summaryRollupMenu_title));
			summaryRollupMenu.addItem(Ui.loadResource(Rez.Strings.summaryRollupMenuOption_exit), RollupExitOption);
			for (var i = 0; i < summaries.size(); i++) {
    			summaryRollupMenu.addItem(TimeFormatter.format(summaries[i].elapsedTime), i);
    		}			
			var summaryRollupMenuDelegate = new MenuOptionsDelegate(method(:onSummaryRollupMenuOption));
			Ui.pushView(summaryRollupMenu, summaryRollupMenuDelegate, Ui.SLIDE_LEFT);	
			return true;
    	}
    	else {    	
			me.mHeartbeatIntervalsSensor.stop();  			
    		me.mHeartbeatIntervalsSensor.disableHrSensor(); 
    		return false;
    	}
    }
    
    function onSummaryRollupMenuOption(option) {
    	if (option == RollupExitOption) {   
    		me.mHeartbeatIntervalsSensor.stop();
    		me.mHeartbeatIntervalsSensor.disableHrSensor(); 		
    		System.exit();
    	}
    	else {
	    	var summaryIndex = option;
	    	var summaryModel = me.mSummaryRollupModel.getSummary(summaryIndex);
	    	var summaryViewDelegate = new SummaryViewDelegate(summaryModel, null);
	    	Ui.pushView(summaryViewDelegate.createScreenPickerView(), summaryViewDelegate, Ui.SLIDE_LEFT); 
    	}
    }
    	
	private function startActivity() {
    	var selectedSession = me.mSessionStorage.loadSelectedSession();
    	var meditateModel = new MeditateModel(selectedSession);      	  
        var meditateView = new MeditateView(meditateModel);
        me.mHeartbeatIntervalsSensor.setOneSecBeatToBeatIntervalsSensorListener(null);
        var mediateDelegate = new MeditateDelegate(meditateModel, me.mSummaryRollupModel, me.mHeartbeatIntervalsSensor, me);
		Ui.switchToView(meditateView, mediateDelegate, Ui.SLIDE_LEFT);
	}
	
    function onKey(keyEvent) {
    	if (keyEvent.getKey() == Ui.KEY_ENTER) {
	    	me.startActivity();
	    	return true;
	  	}
	  	return false;
    }
	
	private function setSelectedSessionDetails() {
		me.mSessionStorage.selectSession(me.mSelectedPageIndex);
		var session = me.mSessionStorage.loadSelectedSession();			
		me.updateSelectedSessionDetails(session);
	}
	
	private var mSuccessiveEmptyHeartbeatIntervalsCount;
	
	private var mNoHrvSeconds;
	private const MinSecondsNoHrvDetected = 3;
	
	function onHeartbeatIntervalsListener(heartBeatIntervals) {
		if (heartBeatIntervals.size() == 0) {
			me.mNoHrvSeconds++;
		}
		else {
			me.mNoHrvSeconds = 0;
		}
	}
	
	private function setInitialHrvStatus(hrvStatusLine, session) {
			hrvStatusLine.value.text = "";		
	}
	
	function addSummary(summaryModel) {
		me.mSummaryRollupModel.addSummary(summaryModel);
	}
	
	function updateSelectedSessionDetails(session) {		
		me.setTestModeHeartbeatIntervalsSensor(session.hrvTracking);
			
		var details = me.mSelectedSessionDetails;
				
        details.color = Gfx.COLOR_WHITE;
        details.backgroundColor = Gfx.COLOR_BLACK;
        var activityTypeText;
        activityTypeText = "Meditate";
        details.title = activityTypeText + " " + (me.mSelectedPageIndex + 1);
        details.titleColor = session.color;
        
        if (session.time > 59)	{
        	details.detailLines[1].value.text = "    " + TimeFormatter.formatMinutes(session.time);
		} else {
			details.detailLines[1].value.text = "    " + TimeFormatter.formatSeconds(session.time);
		}
		
        details.setAllIconsXPos(me.sessionDetailsIconsXPos);
        details.setAllValuesXPos(me.sessionDetailsValueXPos);
		details.setAllLinesYOffset(me.sessionDetailsYOffset);
	}		
	
	function createScreenPickerView() {
		me.setSelectedSessionDetails();
		return new ScreenPicker.ScreenPickerDetailsView(me.mSelectedSessionDetails);
	}
}