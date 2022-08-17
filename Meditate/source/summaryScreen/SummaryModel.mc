using Toybox.System;
using HrvAlgorithms.HrvTracking;

class SummaryModel {
	function initialize(activitySummary, hrvTracking) {
		me.elapsedTime = activitySummary.hrSummary.elapsedTimeSeconds; 
		me.maxHr = me.initializeHeartRate(activitySummary.hrSummary.maxHr);
		me.avgHr = me.initializeHeartRate(activitySummary.hrSummary.averageHr);
		me.minHr = me.initializeHeartRate(activitySummary.hrSummary.minHr);
		me.hrHistory = activitySummary.hrSummary.hrHistory;
		
		me.hrvTracking = hrvTracking;
	}
	
	private function initializeHeartRate(heartRate) {
		if (heartRate == null || heartRate == 0) {
			return me.InvalidHeartRate;
		}
		else {
			return heartRate;
		}
	}
		
	private function initializePercentageValue(stressScore) {
		if (stressScore == null) {
			return me.InvalidHeartRate;
		}
		else {
			return stressScore.format("%3.2f");
		}
	}
		
	private const InvalidHeartRate = "--";
	
	var elapsedTime;
	
	var maxHr;
	var avgHr;
	var minHr;	
	
	var hrvTracking;
	var hrHistory;
}