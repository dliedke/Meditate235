using Toybox.ActivityRecording;

module HrvAlgorithms {
	class FitSessionSpec {
		
		private static const SPORT_MEDITATION = 67;

		static function createMeditation(sessionName) {
			return {
                 :name => sessionName,                              
                 :sport => SPORT_MEDITATION
                };
		}
	}
}