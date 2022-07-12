using Toybox.Application as App;
using HrvAlgorithms.HrvTracking;

class MeditateModel {
	function initialize(sessionModel) {
		me.mSession = sessionModel;
		me.elapsedTime = 0;
		me.minHr = null;
		me.currentHr = null;
		me.hrvSuccessive = null;
	}
	
	private var mSession;

	var currentHr;
	var minHr;
	var elapsedTime;
	var hrvSuccessive;
	
	function isHrvOn() {
		return me.mSession.hrvTracking != HrvTracking.Off;
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
}