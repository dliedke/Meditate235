using Toybox.Attention;

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
		
			// Vibrate
			Attention.vibrate(getLongContinuous());
		
			me.mIsFinalAlertPending = false;
	    }
	}

	private static function getLongContinuous() {
		return [
			new Attention.VibeProfile(100, 3000)
		];
	}
}