package src.com.isartdigital.snake.ui 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import src.com.isartdigital.snake.Main;
	import src.com.isartdigital.snake.network.NetworkManager;
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class Leaderboard extends MovieClip
	{
		static protected const LINES: uint = 10;
		
		protected var scoreList: Vector.<TextField> = new Vector.<TextField>();
		protected var nameList: Vector.<TextField> = new Vector.<TextField>();
		protected var rankList: Vector.<TextField> = new Vector.<TextField>();
		
		protected var xml: XML;
		protected var length: uint;
		protected var page: uint;
		
		public var btnPrev: SimpleButton;
		public var btnNext: SimpleButton;
		
		public function Leaderboard()
		{
			super();
			
			
			
			var lTextField: TextField;
			for (var i = numChildren - 1; i >= 0; i --) {
				if (getChildAt(i) is TextField) {
					lTextField = TextField(getChildAt(i));
					if (lTextField.name == "txtScore") scoreList.push(lTextField);
					else if (lTextField.name == "txtName") nameList.push(lTextField);
					else if (lTextField.name == "txtRank") rankList.push(lTextField);
				}
			}
			
			scoreList.reverse();
			nameList.reverse();
			rankList.reverse();
			
			xml = NetworkManager.leaderboard;
			length = xml.child("entry").length();
			page = 0;
			
			if (xml.child("*").length() > 10) {
				btnPrev.addEventListener(MouseEvent.CLICK, prevPage);
				btnNext.addEventListener(MouseEvent.CLICK, nextPage);
			} else {
				btnPrev.visible = false;
				btnNext.visible = false;
			}
			
			refresh();
		}
		
		protected function refresh(): void {
			var localName: String = String(Main.getInstance().sharedData.data.username).slice(1);
			var startIndex: uint = page * LINES;
			var endIndex: uint = startIndex + LINES; 3
			var lIndex: uint;
			for (var i = startIndex; i < endIndex; i++) {
				lIndex = i % LINES;
				if (i < length) {
					rankList[lIndex].text = i + 1;
					nameList[lIndex].text = xml.entry[i].name[0].toString();
					if (nameList[lIndex].text == localName) nameList[lIndex].textColor = 0xFF0000;
					else nameList[lIndex].textColor = 0x000000;
					scoreList[lIndex].text = xml.entry[i].score[0].toString();
				} else {
					rankList[lIndex].text = "";
					nameList[lIndex].text = "";
					scoreList[lIndex].text = "";
				}
			}
		}
		
		protected function prevPage(pEvent:Event): void {
			if (page > 0) {
				page--;
				refresh()
			}
		}
		
		protected function nextPage(pEvent:Event): void {
			if (page < Math.floor(length / LINES)) {
				page++;
				refresh()
			}
		}
		
	}

}