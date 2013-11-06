package view.screen
{
	import com.astar.expand.ItemTile;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import global.AssetsManager;
	
	import view.component.TileMap;
	import view.npc.BasicNpc;

	/**
	 * 主场景
	 * @author Administrator
	 */	
	public class MainScreen extends Sprite
	{
		private var bg:Sprite;
		public function MainScreen()
		{
			bg = AssetsManager.instance().getResByName("background") as Sprite;
			this.addChild( bg );
			init();
		}
		
		/**
		 * 地图逻辑格
		 */		
		private var tileMap:TileMap;
		
		private function init():void
		{
			tileMap = new TileMap();
			this.addChild( tileMap );
//			tileMap.visible = false;
			initRole();
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private var mouse:Point;
		protected function onClick(event:MouseEvent):void
		{
			mouse = new Point(stage.mouseX, stage.mouseY);
			if(!tileMap.hitTestPoint(mouse.x, mouse.y, true))		//点击为行走区域外
				return;
			trace("hit");
			var target:ItemTile = tileMap.getTargetTileByPosition(mouse);
			tileMap.moveBody(role, target);
		}
		
		private var role:BasicNpc;
		private function initRole():void
		{
			role = new BasicNpc();
			this.addChild( role );
			role.setCrtTile( tileMap.getTileByPosition(new Point(0,0)) );
		}
	}
}