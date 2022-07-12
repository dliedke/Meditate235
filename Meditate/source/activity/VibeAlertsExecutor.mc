class VibeAlertsExecutor {
	function initialize(meditateModel) {
		me.mMeditateModel = meditateModel;
		me.mIsFinalAlertPending = true;
	}
	
	private var mIsFinalAlertPending;
	private var mMeditateModel;
	
	function firePendingAlerts() {
		if (me.mIsFinalAlertPending == true) {
			me.fireIfRequiredFinalAlert();
		}
	}
	
	private function fireIfRequiredFinalAlert() {
	    if (me.mMeditateModel.elapsedTime >= me.mMeditateModel.getSessionTime()) {	    	
			Vibe.vibrate(me.mMeditateModel.getVibePattern());
			me.mIsFinalAlertPending = false;
	    }
	}
}