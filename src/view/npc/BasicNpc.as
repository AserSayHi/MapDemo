package view.npc
{
	import com.astar.expand.ItemTile;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import global.AssetsManager;

	/**
	 * 人物基础类
	 * @author Administrator
	 */	
	public class BasicNpc extends Sprite
	{
		/**交互事件*/		
		public static const INTERACTIVED:String = "interactived";
		/**动作帧索引*/		
		public static const ACTION_STAY:int = 1;
		public static const ACTION_MOVE:int = 2;
		
		protected var action:MovieClip;
		
		public function BasicNpc()
		{
			action = AssetsManager.instance().getResByName("role") as MovieClip;
			action.gotoAndStop(ACTION_STAY);
			this.addChild( action );
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			dispatchEvent(new Event(INTERACTIVED));
		}
		
		protected var crtTile:ItemTile;
		public function getCrtTile():ItemTile
		{
			return crtTile;
		}
		
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