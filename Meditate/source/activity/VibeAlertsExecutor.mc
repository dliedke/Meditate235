using Toybox.Attention;

class VibeAlertsExecutor {
	function initialize(meditateModel) {
		me.mMeditateModel = meditateModel;
		me.mRepeatIntervalAlerts = me.mMeditateModel.getRepeatIntervalAlerts();	
		me.mIsFinalAlertPending = true;
	}
	
	private var mIsFinalAlertPending;
	private var mMeditateModel;
	private var mRepeatIntervalAlerts;

	function firePendingAlerts() {
		if (me.mIsFinalAlertPending == true) {
			me.fireIfRequiredFinalAlert();
			me.fireIfRequiredRepeatIntervalAlerts();
		}
	}
	
	private function fireIfRequiredFinalAlert() {

	    if (me.mMeditateModel.elapsedTime >= me.mMeditateModel.getSessionTime()) {	    	
		
			// Vibrate long continuous
			Attention.vibrate(getLongContinuous());
			
			// Play sound in the end
			playFinalTone();

			me.mIsFinalAlertPending = false;
	    }
	}

	private function fireIfRequiredRepeatIntervalAlerts() {
		for (var i = 0; i < me.mRepeatIntervalAlerts.size(); i++) {
			if (me.mRepeatIntervalAlerts[i].time > 0 && me.mMeditateModel.elapsedTime % me.mRepeatIntervalAlerts[i].time == 0) {
	    		
				// Vibrate blip
				Attention.vibrate(getBlip());
	    	}	
		}
	}

	private static function getLongContinuous() {
		return [
			new Attention.VibeProfile(100, 4500)
		];
	}

	private static function playFinalTone() {

		Attention.playTone (Attention.TONE_START);
	}

	private static function getBlip() {
		return [
	        new Attention.VibeProfile(100, 50)
		];
	}
}