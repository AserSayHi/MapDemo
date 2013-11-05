package view.component
{
	import com.astar.basic2d.BasicTile;
	import com.astar.basic2d.Map;
	import com.astar.basic2d.analyzers.WalkableAnalyzer;
	import com.astar.core.Astar;
	import com.astar.core.AstarEvent;
	import com.astar.core.IAstarTile;
	import com.astar.core.PathRequest;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import global.AssetsManager;
	import global.VO;

	/**
	 * 逻辑地图层
	 * @author Administrator
	 */	
	public class TileMap extends Sprite
	{
		private var map:Map;
		private var astar:Astar;
		private var req:PathRequest;
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
			AssetsManager.instance().zipArchive.getAsyncDisplayObject("item.png", function(obj:Bitmap):void{
				cache = obj.bitmapData;
				creatItems();
			});
		}
		private var cache:BitmapData;
		private function creatItems():void
		{
			var tile:BasicTile;
			var item:ItemRect;
			map = new Map(maxH, maxV);
			for(var y:Number = 0; y< maxV; y++)
			{
				for(var x:Number = 0; x< maxH; x++)
				{
					tile = new BasicTile(1, new Point(x,y), (dataMap[y][x]==0));
					map.setTile(tile);
					
					item = new ItemRect(new Bitmap(cache), tile);
					item.x = y%2*item.width/2 + x*item.width;
					item.y = y*item.height/2;
					this.addChild( item );
				}
			}
			
			//create the Astar instance and add the listeners
			astar = new Astar();
			astar.addEventListener(AstarEvent.PATH_FOUND, onPathFound);
			astar.addEventListener(AstarEvent.PATH_NOT_FOUND, onPathNotFound);
			
			//create a new PathRequest
			//			req = new PathRequest(IAstarTile(map.getTileAt(new Point(0, 0))), IAstarTile(map.getTileAt(new Point(5, 5))), map);
			
			//a general analyzer
			//			astar.addAnalyzer(new WalkableAnalyzer());
			//			astar.getPath(req);
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
		
		
		private function onPathFound(event : AstarEvent) : void
		{
			trace("Path was found: ");
			for(var i:int = 0; i<event.result.path.length;i++)
			{
				trace((event.result.path[i] as BasicTile).getPosition());
			}
		}
	}
}