package view
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import global.AssetsManager;
	
	import view.component.TileMap;

	/**
	 * 主场景
	 * @author Administrator
	 */	
	public class MainScreen extends Sprite
	{
		private var bg:Bitmap;
		public function MainScreen()
		{
			AssetsManager.instance().zipArchive.getAsyncDisplayObject("bg.jpg", function(btm:DisplayObject):void{
				bg=btm as Bitmap;
				addChild( bg );
				
				init();
			});
		}
		
		/**
		 * 地图逻辑格
		 */		
		private var tileMap:TileMap;
		private function init():void
		{
			tileMap = new TileMap();
			this.addChild( tileMap );
		}
	}
}