package view.unit
{
	import com.astar.expand.ItemTile;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * 地图单位基类
	 * @author Administrator
	 */	
	public class BasicUnit extends Sprite
	{
		/**交互事件*/		
		public static const INTERACTIVED:String = "interactived";
		/**动作帧索引*/		
		public static const ACTION_STAY_UP:int = 1;
		public static const ACTION_STAY_DOWN:int = 2;
		public static const ACTION_STAY_LEFT:int = 3;
		public static const ACTION_STAY_RIGHT:int = 4;
		public static const ACTION_MOVE_UP:int = 5;
		public static const ACTION_MOVE_DOWN:int = 6;
		public static const ACTION_MOVE_LEFT:int = 7;
		public static const ACTION_MOVE_RIGHT:int = 8;
		
		protected var action:MovieClip;
		
		public function BasicUnit()
		{
			this.buttonMode = true;
			this.useHandCursor = true;
			init();
		}
		
		protected function init():void
		{
		}
		
		
		protected var crtTile:ItemTile;
		public function setCrtTile(tile:ItemTile):void
		{
			if(crtTile && crtTile == tile)
				return;
			this.crtTile = tile;
			this.x = tile.rect.x;
			this.y = tile.rect.y;
		}
	}
}