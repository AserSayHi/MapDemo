package view.model
{
	import flash.geom.Point;

	/**
	 * 货架数据
	 * @author Administrator
	 */	
	public class ShelfVO
	{
		/**
		 * @param position		货架所在行列
		 * @param position_2	点击货架时npc的移动路径终点行列位置
		 */		
		public function ShelfVO(position:Point, target:Point)
		{
			_position = position;
			_target = target;
		}
		
		private var _position:Point;
		private var _target:Point;
		
		public function getPosition():Point
		{
			return _position;
		}
		public function getTarget():Point
		{
			return _target;
		}
	}
}