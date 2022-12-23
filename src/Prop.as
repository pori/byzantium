package  
{
	
	public class Prop extends Basic
	{
		private var _rating:Number;
		private var _cost:Number;
		private var _duration:Number;
		
		public function Prop(Name:String, Description:String, Type:String, Price:Number, Rating:Number, Cost:Number=0, X:Number=0, Y:Number=0) 
		{
			super(X, Y, Name, Description, Type, Price);
			
			this._rating = Rating / 100;
			this._cost = Cost;
		}
		
		public function modify(who:Actor):void
		{
			switch (this._type)
			{
				case "healthUp":
					if (who.health < who.maxHealth && who.health > 0)
					{
						if (who.health + Math.floor(who.maxHealth * this._rating) < who.maxHealth)
							who.health += Math.floor(who.maxHealth * this._rating);
						else
							who.health = who.maxHealth;
					}
				case "healthDown":
					if (who.health > 0)
					{
						if (who.health - Math.floor(who.maxHealth * this._rating) > 0)
							who.health -= Math.floor(who.maxHealth * this._rating);
						else
							who.health = 0;
					}
				case "magicUp":
					if (who.magic < who.maxMagic)
					{
						if (who.magic + Math.floor(who.maxMagic * this._rating) < who.maxMagic)
							who.magic += Math.floor(who.maxMagic * this._rating);
						else
							who.magic = who.maxMagic;
					}
				case "offenseUp":
					if (who.offense < who.maxOffense)
					{
						if (who.offense + Math.floor(who.maxOffense * this._rating) < who.maxOffense)
							who.offense += Math.floor(who.maxOffense * this._rating);
						else
							who.offense = who.maxOffense;
					}
				case "offenseDown":
					if (who.offense > 0)
					{
						if (who.offense - Math.floor(who.maxOffense * this._rating) > 0)
							who.offense -= Math.floor(who.maxOffense * this._rating);
						else
							who.offense = 0;
					}
				case "defenseUp":
					if (who.defense < who.maxDefense)
					{
						if (who.defense + Math.floor(who.maxDefense * this._rating) < who.maxDefense)
							who.defense += Math.floor(who.maxDefense * this._rating);
						else
							who.magic = who.maxDefense;
					}
				case "defenseDown":
					if (who.defense > 0)
					{
						if (who.defense - Math.floor(who.maxDefense * this._rating) > 0)
							who.defense -= Math.floor(who.maxDefense * this._rating);
						else
							who.defense = 0;
					}
				case "accuracyUp":
					if (who.accuracy < who.maxAccuracy)
					{
						if (who.accuracy + Math.floor(who.maxAccuracy * this._rating) < who.maxAccuracy)
							who.accuracy += Math.floor(who.maxAccuracy * this._rating);
						else
							who.magic = who.maxDefense;
					}
				case "accuracyDown":
					if (who.accuracy > 0)
					{
						if (who.accuracy - Math.floor(who.maxAccuracy * this._rating) > 0)
							who.accuracy -= Math.floor(who.maxAccuracy * this._rating);
						else
							who.accuracy = 0;
					}
			}
		}
		
		public function get Rating():Number
		{
			return this._rating;
		}
		
		public function get Cost():Number
		{
			return this._cost;
		}
		
	}

}