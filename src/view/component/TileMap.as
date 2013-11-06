package view.component
{
	import com.astar.basic2d.BasicTile;
	import com.astar.basic2d.Map;
	import com.astar.basic2d.analyzers.WalkableAnalyzer;
	import com.astar.core.Astar;
	import com.astar.core.AstarEvent;
	import com.astar.core.AstarPath;
	import com.astar.core.IAstarTile;
	import com.astar.core.PathRequest;
	import com.astar.expand.ItemTile;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import global.VO;
	
	import view.npc.BasicNpc;

	/**
	 * 逻辑地图层
	 * @author Administrator
	 */	
	public class TileMap extends Sprite
	{
		private var dataMap:Array;
		private var maxH:uint;
		private var maxV:uint;
		
		public function TileMap()
		{
			initMap();
		}
		
		private function initMap():void
		{
			//解析xml配置数据
			parseMapXml();
			creatMap();
			initAstar();
		}
		
		
		private var astar:Astar;
		private var req:PathRequest;
		private function initAstar():void
		{
			//create the Astar instance and add the listeners
			astar = new Astar();
			astar.addEventListener(AstarEvent.PATH_FOUND, onPathFound);
			astar.addEventListener(AstarEvent.PATH_NOT_FOUND, onPathNotFound);
		}
		
		private const positionX:uint = 512;
		private const positionY:uint = 208;
		private var map:Map;
		private function creatMap():void
		{
			var tile:ItemTile;
			var item:ItemRect;
			map = new Map(maxH, maxV);
			for(var y:Number = 0; y< maxV; y++)
			{
				for(var x:Number = 0; x< maxH; x++)
				{
					tile = new ItemTile(1, new Point(x,y), (dataMap[y][x]==0));
					map.setTile(tile);
					item = new ItemRect(tile);
					item.setPositionText(x, y);
					item.x = positionX - y*item.width/2 + x*item.width/2;
					item.y = positionY + y*item.height/2 + x*item.height/2;
					this.addChild( item );
				}
			}
		}
		
		private function parseMapXml():void
		{
			//解析地图通行数据
			var source:String = VO.instance().mapXML.tiles.toString();
			const max:uint = source.length;
			var char:String;
			var arr:Array = [];
			dataMap = [];
			for(var i:int = 0;i<max;i++)
			{
				char = source.charAt(i);
				if(char == "|")
					continue;
				if(char == "●")		//换行
				{
					dataMap.push( arr );
					arr = [];
				}
				else if(char == "0"||char=="1")
				{
					arr.push(uint(char));
				}
			}
			maxH = arr.length;
			maxV = dataMap.length;
			dataMap.push( arr );
		}
		
		private function onPathNotFound(event : AstarEvent) : void
		{
			trace("path not found");
		}
		
		private var path:AstarPath;
		private function onPathFound(event : AstarEvent) : void
		{
			trace("Path was found: ");
			path = event.result;
			for(var i:int = 0; i<event.result.path.length;i++)
			{
				trace((path.path[i] as ItemTile).getPosition());
			}
		}
		
		public function getTileByPosition(point:Point):ItemTile
		{
			return map.getTileAt(point) as ItemTile;
		}
		
		public function getPath():Vector.<Point>
		{
			return null;
		}
		
		public function moveBody(npc:BasicNpc, target:ItemTile):void
		{
			if(!target.getWalkable())
				return;
			//create a new PathRequest
			req = new PathRequest(npc.getCrtTile(), target, map);
			
			//a general analyzer
			astar.addAnalyzer(new WalkableAnalyzer());
			astar.getPath(req);
		}
		
		/**
		 * 通过坐标找到其相对应tile对象
		 * @param point
		 * @return 
		 */		
		public function getTargetTileByPosition(point:Point):ItemTile
		{
			var p:Point = new Point();
			var tile:ItemTile;
			for(var y:int=0;y<maxV;y++)
			{
				for(var x:int = 0;x<maxH;x++)
				{
					p.x = x;
					p.y = y;
					tile = map.getTileAt(p) as ItemTile;
					if(tile.rect.hitTestPoint(point.x, point.y, true))
						return tile;
				}
			}
			return null;
		}
	}
}