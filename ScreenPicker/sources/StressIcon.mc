using Toybox.Graphics as Gfx;

module ScreenPicker {
	class StressIcon extends Icon {
		function initialize(icon) {
			icon[:font] = Gfx.FONT_MEDIUM;
			icon[:symbol] = "";
			
			Icon.initialize(icon);
		}
		
		function setNoStress() {
			me.setColor(Gfx.COLOR_DK_GREEN);
		}
		
		function setLowStress() {
			me.setColor(Gfx.COLOR_ORANGE);
		}
		
		function setHighStress() {
			me.setColor(Gfx.COLOR_DK_RED);
		}
	}
}