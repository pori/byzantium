package  
{
	import flash.utils.Dictionary;
	import org.flixel.FlxSprite;
	
	public class CityState extends Basic
	{
		public var favorability:Number;
		public var alligience:String;
		private var _enemy:String;
		private var _tolerance:Number;
		private var _rewards:Array;
		
		public function CityState(Name:String, Description:String, Alligience:String, Price:Number, Enemy:String, Tolerance:Number, Rewards:Array, X:Number=0, Y:Number=0) 
		{
			super(X, Y, Name, Description, Alligience, Price);
			
			this.favorability = 0;
			this._enemy = Enemy;
			this._tolerance = Tolerance;
			this._rewards = Rewards;
		}
		
		public function get Enemy():String
		{
			return this._enemy;
		}
		
		public function get Tolerance():void
		{
			return this._tolerance;
		}
		
		public function get Rewards():Array
		{
			return this._rewards;
		}
		
		public function set Type(n:String):void
		{
			this._type = n;
		}
		
		public function set Price(n:Number):void
		{
			this._price = n;
		}
	}

}