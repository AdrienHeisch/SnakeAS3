package src.com.isartdigital.snake.network 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import src.com.isartdigital.snake.ui.GameOverScreen;
	import src.com.isartdigital.snake.ui.Leaderboard;
	import src.com.isartdigital.snake.ui.UIManager;
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class NetworkManager 
	{
		
		static public var leaderboard: XML;
		
		static protected var leaderboardUrl: String = "http://dreamlo.com/lb/AGTzqLYc_k2pRH5Mld3m6AwKsOW_PDi0qp13QNPd3zWA/";
		
		static public function getLeaderboard(pGameOverScreen:GameOverScreen, pUserName:String, pScore:uint): void {
			var setScoreUrlLoader: URLLoader = new URLLoader();
			setScoreUrlLoader.addEventListener(Event.COMPLETE, function(pEvent:Event):void {leaderboard =  XML(pEvent.currentTarget.data).leaderboard[0]; pGameOverScreen.leaderboardSetup(); });
			setScoreUrlLoader.load(new URLRequest(leaderboardUrl + "add-xml/" + pUserName + "/" + String(pScore) + "/"));
		}
		
	}

}