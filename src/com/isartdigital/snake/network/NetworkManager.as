package src.com.isartdigital.snake.network 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import src.com.isartdigital.snake.ui.UIManager;
	/**
	 * ...
	 * @author Adrien Heisch
	 */
	public class NetworkManager 
	{
		
		static public var leaderboard: XML;
		
		static protected var leaderboardUrl: String = "http://dreamlo.com/lb/AGTzqLYc_k2pRH5Mld3m6AwKsOW_PDi0qp13QNPd3zWA/";
		
		static public function setUserScore(pUserName, pScore): void {
			var setScoreUrlLoader: URLLoader = new URLLoader();
			setScoreUrlLoader.addEventListener(Event.COMPLETE, getLeaderboard);
			setScoreUrlLoader.load(new URLRequest(leaderboardUrl + "add/" + pUserName + "/" + pScore + "/"));
		}
		
		static public function getLeaderboard(pEvent:Event): void {
			var getScoreUrlLoader: URLLoader = new URLLoader();
			getScoreUrlLoader.addEventListener(Event.COMPLETE, function(pEvent:Event):void {leaderboard =  XML(pEvent.currentTarget.data).leaderboard[0]; UIManager.leaderboardSetup(); });
			getScoreUrlLoader.load(new URLRequest(leaderboardUrl + "xml-get/"));
		}
		
	}

}