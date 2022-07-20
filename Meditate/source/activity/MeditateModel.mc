using Toybox.Application as App;
using HrvAlgorithms.HrvTracking;

class MeditateModel {
	function initialize(sessionModel) {
		me.mSession = sessionModel;
		me.elapsedTime = 0;
		me.minHr = null;
		me.currentHr = null;
		me.hrvSuccessive = null;
		me.isTimerRunning = false;
	}
	
	private var mSession;

	var currentHr;
	var minHr;
	var elapsedTime;
	var hrvSuccessive;
	var isTimerRunning;
	
	function isHrvOn() {
		return false;
	}
	
	function getHrvTracking() {
		return me.mSession.hrvTracking;
	}
		
	function getSessionTime() {
		return me.mSession.time;
	}
	
	function getColor() {
		return me.mSession.color;
	}
	
	function getVibePattern() {
		return me.mSession.vibePattern;
	}
	
	function getActivityType() {
		return me.mSession.activityType;
	}

	function getRepeatIntervalAlerts() {
		var result = {};
		var intervalAlerts = new IntervalAlerts();
		intervalAlerts.addNew();
		result.put(0,intervalAlerts.get(0));
		return result;
	}
}