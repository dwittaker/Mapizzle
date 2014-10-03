package board.objects.controls
{
	public class ShapePoint
	{
		public var pointnum:int;
		public var pointX:Number;
		public var pointY:Number;
		public var nodename:String;
		
		public function ShapePoint(pnum:int,X:Number,Y:Number, Nm:String )
		{
			pointnum = pnum;
			pointX = X;
			pointY = Y;	
			nodename = Nm;
		}
	}
}