package view.npc
{
	import com.astar.core.IAstarTile;
	import com.astar.expand.ItemTile;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * 可移动的
	 * @author Administrator
	 */	
	public class Walker extends BasicNpc
	{
		public function Walker()
		{
			super();
		}
		
//		private const velocity:int = 16;
		private var vx:int;
		private var vy:int;
		/**
		 * 沿指定路线移动
		 * @param path
		 */		
		public function startMove(path:Vector.<IAstarTile>):void
		{
			this.path = path;
			this.path.splice(0,1);
			action.gotoAndStop( ACTION_MOVE );
			
			if(!timer)
				creatTimer();
			timer.start();
		}
		
		private var path:Vector.<IAstarTile>;
		private var timer:Timer;
		private function creatTimer():void
		{
			timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			var tile:ItemTile = path[0] as ItemTile;
			const X:int = tile.rect.x;
			const Y:int = tile.rect.y;
//			var r:Number = Math.atan2(Y-y, X-x)/* * Math.PI/180*/;
//			trace(r);
			vx = X - crtTile.rect.x >> 1;
			vy = Y - crtTile.rect.y >> 1;
			this.x += vx;
			this.y += vy;
			if(this.x == X && this.y == Y)
			{
				this.crtTile = path.shift() as ItemTile;
				if(path.length == 0)
				{
					timer.reset();
					action.gotoAndStop(ACTION_STAY);
				}
			}
		}
	}
}