package board.utilities.general
{
	import board.objects.controls.ShapePoint;

	public class utils
	{
		
		
		public function utils()
		{
		}
		
		
		
		public  function makeDarkVersion(color:uint, intensity:int = 20):uint
		{
			var c:Object = hexToRGB(color);
			for (var key:String in c)
			{
				c[key] +=  intensity;
				c[key] = Math.min(c[key],255);// -- make sure below 255
				c[key] = Math.max(c[key],0);// -- make sure above 0
			}
			return convertToHex(c.r,c.g,c.b);
		}
		
		public  function hexToRGB(hex:uint):Object
		{
			var c:Object = {};
			
			c.a = hex >> 24 & 0xFF;
			c.r = hex >> 16 & 0xFF;
			c.g = hex >> 8 & 0xFF;
			c.b = hex & 0xFF;
			
			return c;
		}
		
		public  function convertToHex(r:uint, g:uint, b:uint):uint
		{
			var colorHexString:uint = (r << 16) | (g << 8) | b;
			return colorHexString;
		}
		
		public  function dtformat(dt:Date):String
		{
			
			return String(dt.getFullYear()) + String(zeroPad(dt.getMonth()+1,2)) +   String(zeroPad(dt.getDate(),2)) +  String(zeroPad(dt.getHours(),2)) + String(zeroPad(dt.getMinutes(),2)) +   String(zeroPad(dt.getSeconds(),2)) + String(zeroPad(dt.getMilliseconds(),3)); 
		}
		
		public  function zeroPad(number:int, width:int):String {
			var ret:String = ""+number;
			while( ret.length < width )
				ret="0" + ret;
			return ret;
		}
		
 		public function getshapepoint(shparray:Array,nodenm:String):ShapePoint
		{
		var len:int;
		var i:int;
		len = shparray.length;
		for (i=0;i< len;i++)
		{
			var shppnt:ShapePoint = shparray[i] as ShapePoint;
			if (shppnt.nodename == nodenm)
			{
				return shppnt;	
			}
		}
			
		return null;	
		}
		
		public function afterFirst(p_string:String, p_char:String):String {
			if (p_string == null) { return ''; }
			var idx:int = p_string.indexOf(p_char);
			if (idx == -1) { return ''; }
			idx += p_char.length;
			return p_string.substr(idx);
		}
		
		public function beforeLast(p_string:String, p_char:String):String {
			if (p_string == null) { return ''; }
			var idx:int = p_string.lastIndexOf(p_char);
			if (idx == -1) { return ''; }
			return p_string.substr(0, idx);
		}
	}
}