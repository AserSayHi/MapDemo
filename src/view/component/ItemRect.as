package view.component
{
	import com.astar.basic2d.BasicTile;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class ItemRect extends Sprite
	{
		private var bmp:Bitmap;
		public function ItemRect(bitmap:Bitmap, tile:BasicTile)
		{
			this.tile = tile;
			this.bmp = bitmap;
			this.addChild( bmp );
			bmp.alpha = .4;
			bmp.x = -bmp.width >> 1;
			bmp.y = -bmp.height >>　1;
			
			this.graphics.beginFill(0xffffff);
			this.graphics.drawCircle(0,0,2);
			this.graphics.endFill();
		}
		
		private var tile:BasicTile;
		
		public function getTile():BasicTile
		{
			return tile;
		}
	}
}