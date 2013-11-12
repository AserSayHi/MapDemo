package view.screen
{
	import com.astar.expand.ItemTile;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import global.AssetsManager;
	
	import view.component.LogicalMap;
	import view.unit.Walker;

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
		
		private function init():void
		{
			initMapLayer();
			initUnitViewLayer();
		}
		
		private function initMapLayer():void
		{
			bg = AssetsManager.instance().getResByName("background") as Sprite;
			this.addChild( bg );
			bg.addEventListener(MouseEvent.CLICK, onClick);
			tileMap = new LogicalMap();
			this.addChild( tileMap );
//			tileMap.visible = false;
			tileMap.mouseEnabled = tileMap.mouseChildren = false;
		}
		
		private var container:Sprite;
		private var role:Walker;
		private function initUnitViewLayer():void
		{
			container = new Sprite();
			this.addChild( container );
			
			//货架
			shelfManager = new ShelfManager();
			shelfManager.creatShelf(container, tileMap);
			
//			role = new Walker();
//			container.addChild( role );
//			role.setCrtTile( tileMap.getTileByPosition(new Point(3,4)) );
		}
		
		private var shelfManager:ShelfManager;
		private var workerManager:WorkerManager;
		private var shopperManager:ShopperManager;
		
		private var mouse:Point;
		protected function onClick(event:MouseEvent):void
		{
			return;
			mouse = new Point(stage.mouseX, stage.mouseY);
			if(!tileMap.hitTestPoint(mouse.x, mouse.y, true))		//点击为行走区域外
				return;
			var target:ItemTile = tileMap.getTileByMousePlace(mouse);
			if(target)
				tileMap.moveBody(role, target);
		}
		
		
	}
}