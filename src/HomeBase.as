package  
{
	import org.flixel.FlxObject;
	import org.flixel.FlxState;
	import org.flixel.FlxGroup;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	
	public class HomeBase 
	{
		private const _TILE:Number = 8;
		
		private var _cursor:FlxObject;
		private var _menu:FlxGroup;
		
		private var _reserves:FlxGroup;
		private var _props:FlxGroup;
		
		private var _saleActors:FlxGroup;
		private var _saleProps:FlxGroup;
		private var _money:Number;
		
		public function HomeBase()
		{
			
		}
		
		override public function create():void 
		{
			FlxG.bgColor = 0xffaaaaaa;
			FlxG.mouse.show();
			
			_cursor = new FlxObject(0, 0, _TILE, _TILE);
			add(_cursor);
			
			_saleActors = new FlxGroup();
			_saleProps = new FlxGroup();
			_money = 0;
		}
		
		override public function update():void
		{
			_cursor.x = Math.floor(FlxG.mouse.x / _TILE) * _TILE;
			_cursor.y = Math.floor(FlxG.mouse.y / _TILE) * _TILE;
			
			super.update();
		}
		
		public function buyActor(n:Actor):FlxGroup
		{
			_reserves.members.push(n);
			_money -= n.Price;
			
			return _reserves;
		}
		
		public function buyProp(n:Actor):FlxGroup
		{
			_props.members.push(n);
			_money -= n.Price;
			
			return _props;
		}
		
		public function sellProp(n:Number):FlxGroup
		{
			_money += _props.members[n].Price;
			_props.members.pop(n);
			
			return _props;
		}
		
		/*public static function updateHome(Reserves:FlxGroup, Items:FlxGroup, Money:Number):void
		{
			for (var i:uint; i < Reserves.length; i++)
			{
				for (var ii:uint; ii < this._saleActors.length; ii++)
				{
					if (Reserves[i] != this._saleActors[ii])
					{
						this._saleActors.members.push(Reserves[i]);
					}
				}
			}
			
			for (var j:uint; j < Items.length; j++)
			{
				for (var jj:uint; jj < this._saleProps.length; jj++)
				{
					if (Items[j] != this._saleActors[jj])
					{
						this._saleProps.members.push(Items[j]);
					}
				}
			}
			
			this._money = Money
		}*/
		
	}

}