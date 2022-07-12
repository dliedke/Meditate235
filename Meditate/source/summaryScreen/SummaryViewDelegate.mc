using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.Lang;
using HrvAlgorithms.HrvTracking;

class SummaryViewDelegate extends ScreenPicker.ScreenPickerDelegate {
	private var mSummaryModel;
	private var mDiscardDanglingActivity;
	private var mSummaryLinesYOffset;
	private var mPagesCount;

	function initialize(summaryModel, discardDanglingActivity) {		
		me.mPagesCount = 1;
		
        ScreenPickerDelegate.initialize(0, me.mPagesCount);
        me.mSummaryModel = summaryModel;
        me.mDiscardDanglingActivity = discardDanglingActivity;
        me.mSummaryLinesYOffset = App.getApp().getProperty("summaryLinesYOffset");
	}
	
	function onBack() {
		if (me.mDiscardDanglingActivity != null) {
			me.mDiscardDanglingActivity.invoke();
		}
		
		return false;
	}
	
	function createScreenPickerView() {
		var details;
		details = me.createDetailsPageHr();
		return new ScreenPicker.ScreenPickerDetailsView(details);
	}	
				
	private function formatHr(hr) {
		return hr + " bpm";
	}
	
	private function createDetailsPageHr() {

		var details = new ScreenPicker.DetailsModel();
		details.color = Gfx.COLOR_BLACK;
        details.backgroundColor = Gfx.COLOR_WHITE;
        details.title = "Summary HR";
        details.titleColor = Gfx.COLOR_BLACK;

        details.detailLines[1].value.color = Gfx.COLOR_BLACK;
        details.detailLines[1].value.text = "                          " + TimeFormatter.format(me.mSummaryModel.elapsedTime);
     
        details.detailLines[2].value.color = Gfx.COLOR_BLACK;
        details.detailLines[2].value.text = "                     Min: " + me.formatHr(me.mSummaryModel.minHr);
        
        details.detailLines[3].value.color = Gfx.COLOR_BLACK;  
        details.detailLines[3].value.text = "                     Avg: " + me.formatHr(me.mSummaryModel.avgHr);
        
        details.detailLines[4].value.color = Gfx.COLOR_BLACK; 
        details.detailLines[4].value.text = "                     Max: " +me.formatHr(me.mSummaryModel.maxHr);
		
        return details;
	}
}