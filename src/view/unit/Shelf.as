package view.unit
{
	import com.astar.expand.ItemTile;
	
	import flash.display.MovieClip;
	
	import global.AssetsManager;
	
	import view.model.ShelfVO;

	public class Shelf extends BasicUnit
	{
		/**
		 * 货架
		 */		
		public function Shelf(vo:ShelfVO)
		{
			super();
			this.vo = vo;
		}
		
		private var vo:ShelfVO;
		
		override protected function init():void
		{
			action = AssetsManager.instance().getResByName("shelf") as MovieClip;
			action.gotoAndStop(ACTION_STAY_LEFT);
			this.addChild( action );
		}
		
		protected var pathEnd:ItemTile;
		public function setPathEndTile(tile:ItemTile):void
		{
			if(pathEnd && pathEnd == tile)
				return;
			pathEnd = tile;
		}
	}
}