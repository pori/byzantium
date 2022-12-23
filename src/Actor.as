package  
{
	import org.flixel.FlxObject;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	public class Actor extends Basic
	{
		private var _maxHealth:Number;
		private var _maxMagic:Number;
		private var _maxOffense:Number;
		private var _maxDefense:Number;
		private var _maxAccuracy:Number;
		private var _level:Number;
		private var _exp:Number;
		private var _nextLevel:Number;
		private var _range:Number;
		//private var _weapon:Prop;
		//private var _armor:Prop;
		private var _accessory:Prop;
		
		public var clicked:Boolean;
		public var moved:Boolean;
		public var hovering:Boolean;
		
		public var magic:Number;
		public var offense:Number;
		public var defense:Number;
		public var accuracy:Number;
		//public var spells:FlxGroup;
		//public var inventory:FlxGroup;
		
		public function Actor(X:Number, Y:Number, Name:String, Description:String, Type:String, Price:Number, theHealth:Number, 
			theMagic:Number, theLevel:Number, theRange:Number, theOffense:Number, theDefense:Number, theAccuracy:Number) 
		{
			super(X, Y, Name, Description, Type, Price);

			this._maxHealth = theHealth;
			this._maxMagic = theMagic;
			this._maxOffense = theOffense;
			this._maxDefense = theDefense;
			this._maxAccuracy = theAccuracy;
			this._level = theLevel;
			this._range = theRange;
			
			this.health = this._maxHealth;
			this.magic = this._maxMagic;
			this.offense = this._maxOffense;
			this.defense = this._maxDefense;
			this.accuracy = this._maxAccuracy;
			
			//this._weapon = new Prop("None", "What part of \"None\" do you not understand?", "offenseUp", 0, 1);
			
			this._exp = 0;
			this._nextLevel = 0;
	
			this.clicked = false;
			this.moved = false;
			this.hovering = false;
		}
		
		public function checkLevel(theEXP:Number):Number
		{
			this._nextLevel = 0;
			for (var i:uint; i < this._level; i++)
				this._nextLevel += i + 1;
				
			this._exp += Math.sqrt(theEXP);
			
			if (this._exp >= this._nextLevel)
			{
				this._level += 1;
				
				this._maxHealth *=
				this._maxMagic *= 
				this._maxOffense *= 
				this._maxDefense *= this._level;
				this._maxAccuracy += 1;
				
				this.health = this._maxHealth;
				this.magic = this._maxMagic;
				this.offense = this._maxOffense;
				this.defense = this._maxDefense;
				this.accuracy = this._maxAccuracy;
			}	
			
			return _level;
		}
		
		public function attack(target:Actor):String
		{
			var impact:Number = Math.floor(Math.random() * this.offense + 1);
			var resistance:Number = Math.floor(Math.random() * target.defense);
			var swing:Number = Math.floor(Math.random() * 100 + 1);
			
			var counterImpact:Number = Math.floor(Math.random() * target.offense + 1);
			var counterResistence:Number = Math.floor(Math.random() * this.defense);
			
			var result:String = "";
			
			if (swing < this.accuracy)
			{
				if (impact > resistance)
				{
					if (target.health - (impact - resistance) > 0)
					{
						target.hurt(impact - resistance);
						result = "Strike.";
					}
					else 
					{
						target.health = 0;
						result = "Fatal strike!";
					}
				}
				else
				{
					if (swing > target.accuracy)
					{
						if (counterImpact > counterResistence)
							if (this.health - (counterImpact - counterResistence) > 0)
							{
								this.hurt(counterImpact - counterResistence);
								result = "Counter!"
							}
							else
							{
								this.health = 0;
								result = "Fatal counter.";
							}
					}
					else 
						result = "Blocked.";
				}
						
			}
			else
				result = "Missed.";
				
			return result;
		}
		
		public function defend():Number
		{
			this.defense *= 2;
			
			return this.defense;
		}
		
		public function revert():Number
		{
			this.defense = this._maxDefense;
			
			return this.defense;
		}
		
		/*public function equipWeapon(which:Prop):Number
		{
			if (which.Type == "weapon")
			{
				this._weapon = which;
				this._maxOffense *= this._weapon.Rating;
			}
			
			return this._maxOffense;
		}*/
		
		/*public function equipArmor(which:Prop):Number
		{
			if (which.Type == "armor")
			{
				this._armor = which;
				this._maxDefense *= this._armor.Rating;
			}
		}*/
		
		//useAbility()
		//useItem()
		
		public function get Level():Number
		{
			return this._level;
		}
		
		public function get EXP():Number
		{
			return this._exp;
		}
		
		public function get Range():Number
		{
			return this._range;
		}
		
		public function get maxHealth():Number
		{
			return this._maxHealth;
		}
		
		public function get maxMagic():Number
		{
			return this._maxMagic;
		}
		
		public function get maxOffense():Number
		{
			return this._maxOffense;
		}
		
		public function get maxDefense():Number
		{
			return this._maxDefense;
		}
		
		public function get maxAccuracy():Number
		{
			return this._maxAccuracy;
		}
		
	}

}