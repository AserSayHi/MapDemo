package view.unit
{
	import com.astar.core.IAstarTile;
	import com.astar.expand.ItemTile;
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import global.AssetsManager;

	/**
	 * 可移动的
	 * @author Administrator
	 */	
	public class Walker extends BasicUnit
	{
		/**
		 * 动作状态：0静止，1行走
		 */		
		private var state:int = 0;
		
		public function Walker()
		{
			super();
		}
		
		override protected function init():void
		{
			action = AssetsManager.instance().getResByName("role") as MovieClip;
			action.gotoAndStop(ACTION_STAY_LEFT_DOWN);
			this.addChild( action );
		}
		
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
			if(!timer)
				creatTimer();
			timer.start();
		}
		
		protected var path:Vector.<IAstarTile>;
		private var timer:Timer;
		private function creatTimer():void
		{
			timer = new Timer(50);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		/**
		 * 朝向:
		 * 1:	左上
		 * 2:	左下
		 * 3:	右上
		 * 4:	右下
		 */		
		private var direction:int = 0;
		
		protected function onTimer(event:TimerEvent):void
		{
			var tile:ItemTile = path[0] as ItemTile;
			
			//确定方向
			var tp:Point = tile.getPosition();
			var cp:Point = crtTile.getPosition();
			if(tp.x == cp.x)
			{
				if(tp.y > cp.y)
					direction = 2;
				else
					direction = 3;
			}else if(tp.y == cp.y)
			{
				if(tp.x > cp.x)
					direction = 4;
				else
					direction = 1;
			}
			if(action.currentFrame != direction+4)
				action.gotoAndStop( 4+direction );
			
			
			const X:int = tile.rect.x;
			const Y:int = tile.rect.y;
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
					action.gotoAndStop(direction);
				}
			}
		}
		
		public function getCrtTile():ItemTile
		{
			return crtTile;
		}
		
		public function pauseMove():void
		{
			if(this.path)
			{
				timer.reset();
				if(!(crtTile.rect.x == x &&　crtTile.rect.y == y))
					this.setCrtTile(this.path[0] as ItemTile);
			}
		}
		
		/**
		 * @return 
		 */		
		public function isCrtPathEnd(tile:IAstarTile):Boolean
		{
			if(path && path.length>0 && tile == path[path.length-1])
				return true
			return false;
		}
	}
}