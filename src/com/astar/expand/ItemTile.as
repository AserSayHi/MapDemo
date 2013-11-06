package com.astar.expand
{
	import com.astar.basic2d.BasicTile;
	
	import flash.geom.Point;
	
	import view.component.ItemRect;
	
	public class ItemTile extends BasicTile
	{
		private var _rect:ItemRect;
		public function ItemTile(cost:Number, position:Point, walkable:Boolean)
		{
			super(cost, position, walkable);
		}
		
		public function set rect(item:ItemRect):void
		{
			if(_rect && _rect == item)
				return;
			_rect = item;
		}
		
		public function get rect():ItemRect
		{
			return _rect;
		}
	}
}