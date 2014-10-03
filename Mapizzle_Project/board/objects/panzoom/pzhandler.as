package board.objects.panzoom
{
	import flash.geom.Point;
	
	public class pzhandler
	{
		public var bWidth:Number;
		public var bHeight:Number; 
		public var scale:Number;
		public var responsiveness:Number;
		public var old_center:Point;
		public var new_center:Point;
		
		public var old_xmin:Number, old_xmax:Number, old_ymin:Number, old_ymax:Number;
		public var new_xmin:Number, new_xmax:Number, new_ymin:Number, new_ymax:Number;
		
		public var nXSize:Number, nYSize:Number;
		public var nXmin:Number, nXmax:Number, nYmin:Number, nYmax:Number;
		
		public function pzhandler()
		{
			// bWidth = this.parent.stage.width;
			// bHeight = this.parent.stage.height;
			 scale = 0.8;
			 responsiveness = .125;
		}
		
		public function xfromPix(a:Number): Number {
			var xconv:Number;
			
				xconv=nXSize/(nXmax-nXmin);
				return a/xconv+nXmin;
			
		}
		
		public function yfromPix(a:Number): Number {
			var yconv:Number;
			
				yconv=nYSize/(nYmax-nYmin);
				return nYmax-a/yconv;	
				
			
		}
		
		public function xtoPix(a:Number): Number {
			var xconv:Number;
			
				xconv=nXSize/(nXmax-nXmin);
				return (a-nXmin)*xconv;
			
		}
		
		public function ytoPix(a:Number): Number {
			var yconv:Number;
			
				yconv=nYSize/(nYmax-nYmin);
				return nYmax*yconv-a*yconv;
			
		}
	}
}