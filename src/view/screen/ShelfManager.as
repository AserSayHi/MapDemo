package view.screen
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import global.VO;
	
	import view.component.LogicalMap;
	import view.model.ShelfVO;
	import view.unit.Shelf;

	/**
	 * 货架管理器
	 * @author Administrator
	 */	
	public class ShelfManager
	{
		public function ShelfManager()
		{
			init();
		}
		
		private function init():void
		{
			parseShelfVO();
		}
		
		private var datas:Vector.<ShelfVO>;
		private function parseShelfVO():void
		{
			var str:String;
			var arr:Array
			var p1:Point;
			var p2:Point;
			var xml:XMLList = VO.instance().mapXML.shelf;
			datas = new Vector.<ShelfVO>();
			for(var i:int = 1;i<int.MAX_VALUE;i++)
			{
				if(!xml.hasOwnProperty("s"+i))
					break;
				str = xml["s"+i].toString();
				arr = str.split("|")[0].split(",");
				p1 = new Point(arr[0], arr[1]);
				arr = str.split("|")[1].split(",");
				p2 = new Point( arr[0], arr[1] );
				var vo:ShelfVO = new ShelfVO(p1, p2);
				datas.push( vo );
			}
		}
		
		private var container:Sprite;
		private var map:LogicalMap;
		private var vecShelf:Array;
		public function creatShelf(container:Sprite, tileMap:LogicalMap):void
		{
			vecShelf = [];
			this.container = container;
			this.map = tileMap;
			var shelf:Shelf;
			var vo:ShelfVO;
			for(var i:int = datas.length-1;i>=0;i--)
			{
				vo = datas[i];
				shelf = new Shelf(vo);
				shelf.setCrtTile( map.getTileByPosition( vo.getPosition() ) );
				shelf.setPathEndTile( map.getTileByPosition( vo.getTarget() ) );
				shelf.addEventListener(MouseEvent.CLICK, onClick);
				vecShelf[i] = shelf;
			}
			
			vecShelf.sortOn("y");		//按y坐标大小排序
			for(i = 0;i<vecShelf.length;i++)
			{
				container.addChild( vecShelf[i] );
			}
		}
		
		protected function onClick(e:MouseEvent):void
		{
		}
	}
}