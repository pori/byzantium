package  
{
	import org.flixel.FlxSprite;
	
	public class Basic extends FlxSprite
	{
		protected var _name:String;
		protected var _description:String;
		protected var _type:String;
		protected var _price:Number
		
		public function Basic(X:Number, Y:Number, Name:String, Description:String, Type:String, Price:Number) 
		{
			this.x = X;
			this.y = Y;
			this._name = Name;
			this._description = Description;
			this._type = Type;
			this._price = Price
		}
		
		public function get Name():String
		{
			return this._name;
		}
		
		public function get Description():String
		{
			return this._description;
		}
		
		public function get Type():String
		{
			return this._type;
		}
		
		public function get Price():Number
		{
			return this._price;
		}
		
	}

}