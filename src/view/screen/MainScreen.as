package view.screen
{
	import com.astar.expand.ItemTile;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import global.AssetsManager;
	
	import view.component.LogicalMap;
	import view.npc.Walker;

	/**
	 * 主场景
	 * @author Administrator
	 */	
	public class MainScreen extends Sprite
	{
		private var bg:Sprite;
		public function MainScreen()
		{
			init();
		}
		
		/**
		 * 地图逻辑格
		 */		
		private var tileMap:LogicalMap;
		private var role:Walker;
		
		private function init():void
		{
			bg = AssetsManager.instance().getResByName("background") as Sprite;
			this.addChild( bg );
			bg.mouseEnabled = false;
			
			tileMap = new LogicalMap();
			this.addChild( tileMap );
//			tileMap.visible = false;
			//creat role
			role = new Walker();
			this.addChild( role );
			role.setCrtTile( tileMap.getTileByPosition(new Point(0,0)) );
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private var mouse:Point;
		protected function onClick(event:MouseEvent):void
		{
			mouse = new Point(stage.mouseX, stage.mouseY);
			if(!tileMap.hitTestPoint(mouse.x, mouse.y, true))		//点击为行走区域外
				return;
			var target:ItemTile = tileMap.getTargetTileByPosition(mouse);
			tileMap.moveBody(role, target);
		}
	}
}