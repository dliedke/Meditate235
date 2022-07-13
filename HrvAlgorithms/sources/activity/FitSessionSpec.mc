using Toybox.ActivityRecording;

module HrvAlgorithms {
	class FitSessionSpec {
		
		static function createCardio(sessionName) {
			return {
                 :name => sessionName,                              
                 :sport => ActivityRecording.SPORT_TRAINING,      
                 :subSport => ActivityRecording.SUB_SPORT_GENERIC
                };
		}
	}
}