module HrvAlgorithms {
	class HrvAndStressActivity extends HrActivity {
		function initialize(fitSession, hrvTracking, heartbeatIntervalsSensor) {
			me.mHrvTracking = hrvTracking;
			me.mHeartbeatIntervalsSensor = heartbeatIntervalsSensor;
			HrActivity.initialize(fitSession);
		}
		
		private var mHrvTracking;
		private var mHeartbeatIntervalsSensor;
		
		private var mHrvMonitor;
		private var mStressMonitor;
		
		private function isHrvOn() {
			return me.mHrvTracking != HrvTracking.Off;
		}
		
		protected function onBeforeStart(fitSession) {
			
		}
		
		function onOneSecBeatToBeatIntervals(heartBeatIntervals) {
			
		}
		
		protected function onBeforeStop() {
			
		}
		
		private var mHrvSuccessive;
		
		protected function onRefreshHrActivityStats(activityInfo, minHr) {	
			    	
    		me.onRefreshHrvActivityStats(activityInfo, minHr, me.mHrvSuccessive);
		}
		
		protected function onRefreshHrvActivityStats(activityInfo, minHr, hrvSuccessive) {
		}
		
		function calculateSummaryFields() {	
			var hrSummary = HrActivity.calculateSummaryFields();	
			var activitySummary = new ActivitySummary();
			activitySummary.hrSummary = hrSummary;
			
			return activitySummary;
		}
	}	
}