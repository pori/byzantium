package  
{
	import org.flixel.FlxObject;
	import org.flixel.FlxState;
	import org.flixel.FlxGroup;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxTilemap;
	
	public class OverWorld extends FlxState
	{
		private const _TILE:Number = 8;
		private var _flags:uint;
		
		private var _cursor:FlxObject;
		private var _menu:FlxGroup;
		
		private var _activeTeam:FlxGroup;
		private var _reserves:FlxGroup;
		private var _props:FlxGroup;
		public var _money:Number;
		
		private var _enemyTeam:FlxGroup;
		private var _map:FlxTilemap;
		
		private var _states:FlxGroup;
		
		public function OverWorld()
		{
			
		}
		
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			FlxG.mouse.show();
			
			_flags = 0;
			
			_cursor = new FlxObject(0, 0, _TILE, _TILE);
			add(_cursor);
			
			_menu = new FlxGroup();
			add(_menu);
			
			_states = new FlxGroup();
			add(_states);
			
			_activeTeam = new FlxGroup();
			_reserves = new FlxGroup();
			_props = new FlxGroup();
			_money = 0;
			
			_enemyTeam = new FlxGroup();
			_map = new FlxTilemap();
			
			_states = new FlxGroup();
			add(_states);
		}
		
		override public function update():void
		{
			_cursor.x = Math.floor(FlxG.mouse.x / _TILE) * _TILE;
			_cursor.y = Math.floor(FlxG.mouse.y / _TILE) * _TILE;
			
			super.update();
		}
		
		//menu
		//scene
		
		private function _checkFavorability(State:CityState):void
		{
			for (var i:uint; i < _states.length; i++)
			{
				if (_states[i].Name == State.Enemy)
				{
					if (State.Tolerance > _states[i].Favorability)
					{
						if (State.Type == "ally")
						{
							State.favorability += 1;
							for (var ii:uint; ii < State.Rewards[State.favorability - 1].length; ii++)
							{
								if (State.Rewards[State.favorability - 1][i] is Actor)
									_reserves.members.push(State.Rewards[State.favorability - 1][i]);
								else if (State.Rewards[State.favorability - 1][i] is Prop)
									_props.members.push(State.Rewards[State.favorability - 1][i]);
								else if (State.Rewards[State.favorability - 1][i] is Number)
									_money += State.Rewards[State.favorability - 1][i];
							}
						}
						else if (State.Type == "enemy")
							State.Type = "ally";
						else if (State.Type == "neutral")
							State.Type = "ally";
					}
					else
						State.Type = "enemy";
				}
			}
		}
		
		/*public static function updateWorld(Reserves:FlxGroup, Items:FlxGroup, Money:Number):void
		{
			this._reserves = Reserves;
			this._props = Items;
			this._money = Money;
		}*/
		
	}

}