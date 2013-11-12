package view.unit
{
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
			this.vo = vo;
			super();
		}
		
		private var vo:ShelfVO;
		
		override protected function init():void
		{
			action = AssetsManager.instance().getResByName("shelf_"+vo.getIcon()) as MovieClip;
			this.addChild( action );
		}
		
	}
}