package  
{
	import flash.utils.Dictionary;
	import org.flixel.*;
	import org.flixel.plugin.TimerManager;
	
	public class Demo9 extends FlxState
	{
		private var _room:FlxTilemap;
		private var _target:FlxPoint;
		private var _grid:FlxGroup;
		
		private var _turn:Number;
		private var _turns:Number;
		private var _player:FlxGroup;
		private var _enemy:FlxGroup;
		private var _other:FlxGroup;
		
		private var _cursor:FlxObject;
		private var _playerIdentifier:FlxText;
		private var _enemyIdentifier:FlxText;
		private var _menu:FlxGroup;
		private var _subMenu:FlxGroup;
		private var _mainTextBox:FlxSprite;
		private var _mainText:FlxText;
		
		private const _TILE:uint = 8;
		private const _TEAMMAX:uint = 10;
		private var _selected:Number;
		private var _who:Number;
		private var _display:Boolean;
		private var _talking:Boolean;
		private var _choiceTime:Boolean;
		private var _fighting:Boolean;
		
		private var _tmp:uint;
		private var _conversation:Array;
		private var _dialogue:Dictionary;
		
		public function Demo9() //battle
		{
			
		}
		
		override public function create():void
		{
			FlxG.bgColor = 0xffaaaaaa;
			FlxG.mouse.show();
			
			_room = new FlxTilemap();
			var data:Array = new Array(1200);
			for (var i:uint; i < data.length; i++)
				data[i] = 0;
			_room.loadMap(FlxTilemap.arrayToCSV(data, 40), FlxTilemap.ImgAuto, _TILE, _TILE, FlxTilemap.AUTO);
			add(_room);
			
			_grid = new FlxGroup();
			add(_grid);
			
			_target = new FlxPoint();
			_turn = 0;
			_selected = 0;
			_who = 0;
			_display = false;
			_talking = false;
			_fighting = false;
			
			_tmp = 0;
			_conversation = ["Did you hear about the stonemason’s son?",
				"He was a chip off the old block.",
				"Har! Har! Har!"];
			_dialogue = new Dictionary();
			
			_player = new FlxGroup();
			for (var j:uint; j < _TEAMMAX; j++)
				_player.add(new Actor(FlxG.width - _TILE - j * _TILE, j * _TILE, "Argon Knight", "They're pretty noble.", "swordsman", 0,
				10, 5, 1, 10, 10, 5, 75).makeGraphic(_TILE, _TILE, FlxG.RED));
			add(_player);
			
			_enemy = new FlxGroup();
			for (var k:uint; k < _TEAMMAX; k++)
				_enemy.add(new Actor(k * _TILE, k * _TILE, "Rude Knight", "Has a tendency to talk over people.", "swordsman", 0,
				10, 5, 1, 10, 10, 5, 75).makeGraphic(_TILE, _TILE, FlxG.BLUE));
			add(_enemy);
			
			var tmp:Actor;
			for each (tmp in _player.members)
				_dialogue[tmp.Name] = ["We can't talk now! We're in a war!"];
			for each (tmp in _enemy.members)
				_dialogue[tmp.Name] = _conversation;
			
			_cursor = new FlxObject(0, 0, _TILE, _TILE);
			add(_cursor);
			
			_playerIdentifier = new FlxText(0, 0, 100, "");
			_playerIdentifier.size = _TILE;
			_playerIdentifier.visible = false;
			add(_playerIdentifier);
			
			_enemyIdentifier = new FlxText(0, 0, 100, "");
			_enemyIdentifier.size = _TILE;
			_enemyIdentifier.visible = false;
			add(_enemyIdentifier);
			
			_menu = new FlxGroup();
			add(_menu);
			
			_subMenu = new FlxGroup();
			add(_subMenu);
			
			_mainTextBox = new FlxSprite(_TILE, FlxG.height - FlxG.height / 4 - _TILE)
				.makeGraphic(FlxG.width - _TILE * 2, FlxG.height / 4, FlxG.BLACK);
			_mainTextBox.visible = false;
			add(_mainTextBox);
				
			_mainText = new FlxText(_mainTextBox.x + _TILE, _mainTextBox.y, FlxG.width - _TILE, "");
			_mainText.visible = false;
			add(_mainText);
		}
		
		override public function update():void
		{
			_cursor.x = Math.floor(FlxG.mouse.x / _TILE) * _TILE;
			_cursor.y = Math.floor(FlxG.mouse.y / _TILE) * _TILE;
			
			for (var i:uint; i < _player.length; i++)
			{
				if (_cursor.overlaps(_player.members[i]))
				{
					_player.members[i].hovering = true;
					_who = i;
				}
				else
					_player.members[i].hovering = false;
					
				if (_cursor.overlaps(_player.members[_who]))
				{
					_playerIdentifier.text = _player.members[_who].Name;
					_playerIdentifier.x = _player.members[_who].x - (_playerIdentifier.width / 3);
					_playerIdentifier.y = _player.members[_who].y - (_player.members[_who].height * 2);
					_playerIdentifier.visible = true;
				}
				else 
					_playerIdentifier.visible = false;
				
				if (_player.members[_selected].pathSpeed == 0 && _display == false && _talking == false)
				{
					if (FlxG.mouse.justPressed())
					{
						if (_player.members[i].hovering)
						{
							if (_selected == i)
							{
								if (_player.members[_selected].clicked == false && _player.members[_selected].moved == false)
								{
									_player.members[_selected].clicked = true;
									_drawGrid();
									
								}
								else if (_player.members[_selected].clicked)
								{
									_player.members[_selected].clicked = false;
									_grid.clear();
									
								}
							}
							else if (_selected != i)
							{
								_player.members[_selected].clicked = false;
								_grid.clear()
								
								_selected = i;
								_player.members[_selected].clicked = true;
								if (_player.members[_selected].moved == false)
									_drawGrid();
							}
						}
						else if (_selected == i)
						{
							if (_player.members[_selected].clicked == true && _player.members[_selected].moved == false)
							{
								if (_player.members[_who].hovering == false && _enemy.members[_who].hovering == false) 
								{
									if (_cursor.x > _player.members[_selected].x - (_TILE * _player.members[_selected].Range / 2) 
										&& _cursor.x < _player.members[_selected].x + (_TILE * _player.members[_selected].Range / 2))
									{
										if (_cursor.y > _player.members[_selected].y - (_TILE * _player.members[_selected].Range / 2) 
											&& _cursor.y < _player.members[_selected].y + (_TILE * _player.members[_selected].Range / 2))
										{
											_player.members[_selected].clicked = false;
											_player.members[_selected].moved = true;
											_grid.clear();
											_find()
										}
										/*else
										{
											_grid.clear()
											_player.members[_selected].clicked = false;
										}*/
									}
									/*else
									{
										_grid.clear()
										_player.members[_selected].clicked = false;
									}*/
								}
							}
								
								
						}
					}
					else if (_player.members[_selected].moved == true)
					{
						_stop();
						_player.members[_selected].moved = false; //kill this eventually
					}
				}
			}
			
			for (var j:uint; j < _enemy.length; j++)
			{
				if (_cursor.overlaps(_enemy.members[j]))
				{
					_enemy.members[j].hovering = true;
					_who = j;
				}
				else 
					_enemy.members[j].hovering = false;
					
				if (_cursor.overlaps(_enemy.members[_who]))
				{
					_enemyIdentifier.text = _enemy.members[_who].Name;
					_enemyIdentifier.x = _enemy.members[_who].x - (_enemyIdentifier.width / 3);
					_enemyIdentifier.y = _enemy.members[_who].y - (_enemy.members[_who].height * 2);
					_enemyIdentifier.visible = true;
				}
				else 
					_enemyIdentifier.visible = false;
			}
			
			if (FlxG.mouse.justPressed() && _display == false && _talking == false)
			{
				if (_cursor.x > _player.members[_selected].x - _player.members[_selected].width * 2
					&& _cursor.x < _player.members[_selected].x + _player.members[_selected].width * 2)
				{
					if (_cursor.y > _player.members[_selected].y - _player.members[_selected].height * 2
						&& _cursor.y < _player.members[_selected].y + _player.members[_selected].height * 2)
					{ 
						if (_enemy.members[_who].hovering == true)
						{
							_fight(_player.members[_selected], _enemy.members[_who]);
						}
					}
				}
			}
			
			if (_display == true)
			{
				if (FlxG.mouse.justPressed())
				{
					_subMenu.clear();
					_display = false;
				}
			}
			
			if (_talking == true)
			{	
				if (FlxG.mouse.justPressed())
				{
					if (_player.members[_who].hovering == true)
					{
						if (_tmp < _dialogue[_player.members[_who].Name].length)
						{
							_mainText.text = _dialogue[_player.members[_who].Name][_tmp];
							_tmp++
						}
					}
					else if (_enemy.members[_who].hovering == true)
					{
						if (_tmp < _dialogue[_enemy.members[_who].Name].length)
						{
							_mainText.text = _dialogue[_enemy.members[_who].Name][_tmp];
							_tmp++
						}
					}
					else
					{
						_player.members[_selected].clicked = false;
						_talking = false;
					}
				}
			}
			
			if (_player.members[_selected].clicked == true && _mainTextBox.visible == false && _mainText.visible == false)
			{
				_menu.add(new FlxButton(_TILE, _TILE, "Inventory"));
				_menu.add(new FlxButton(_TILE, _TILE + _TILE * 2, "Spells"));
				_menu.add(new FlxButton(_TILE, _TILE + _TILE * 4, "Status", _status));
				_menu.add(new FlxButton(_TILE, _TILE + _TILE * 6, "Talk", _talk));
				
				_mainTextBox.visible = true;
				_mainText.visible = true;
				_mainText.text = _player.members[_selected].Name + ":\n\n" + _player.members[_selected].Description;
			}
			else if (_player.members[_selected].clicked == false)
			{
				_grid.clear();
				_menu.clear();
				_mainTextBox.visible = false;
				_mainText.visible = false;
				_mainText.text = "";
			}
				
			super.update();
		}
		
		override public function draw():void
		{
			_cursor.drawDebug();
			
			if (_player.members[_selected].path != null)
				_player.members[_selected].path.drawDebug();
			
			super.draw();
		}
		
		private function _find():void
		{
			var target:FlxPath = _room.findPath(new FlxPoint(_player.members[_selected].x + _TILE / 2, _player.members[_selected].y + _TILE / 2),
				new FlxPoint(_cursor.x + _TILE / 2, _cursor.y + _TILE / 2), false);
				
			_target = target.tail();
			
			_player.members[_selected].followPath(target);
		}
		
		private function _stop():void
		{
			//stop
			_player.members[_selected].stopFollowingPath(true);
			_player.members[_selected].velocity.x = _player.members[_selected].velocity.y = 0;
			
			//snap to the grid
			_player.members[_selected].x = _target.x - _TILE / 2;
			_player.members[_selected].y = _target.y - _TILE / 2;
		}
		
		private function _drawGrid():void
		{
			for (var i:uint; i < _player.members[_selected].Range; i++)
			{
				//vertical
				_grid.add(new FlxSprite(_player.members[_selected].x - (_TILE * _player.members[_selected].Range / 2.5), _player.members[_selected].y - (_TILE * _player.members[_selected].Range / 2.5))
					.makeGraphic(_player.members[_selected].Range * _TILE - _TILE, _player.members[_selected].Range * _TILE - _TILE, 0x0));
				_grid.members[i].drawLine(i * _TILE, 0, i * _TILE, _TILE * _player.members[_selected].Range, FlxG.WHITE);
			
				//horizantal
				_grid.add(new FlxSprite(_player.members[_selected].x - (_TILE * _player.members[_selected].Range / 2.5), _player.members[_selected].y - (_TILE * _player.members[_selected].Range / 2.5))
					.makeGraphic(_player.members[_selected].Range * _TILE - _TILE, _player.members[_selected].Range * _TILE - _TILE, 0x0));
				_grid.members[i].drawLine(0, i * _TILE, _player.members[_selected].Range * _TILE, i * _TILE, FlxG.WHITE);
			}
		}
		
		private function _status():void
		{
			_subMenu.clear();
			
			if (_menu.length > 0)
			{
				if (_menu.members[2].status == FlxButton.PRESSED)
				{
					_display = true;
			
					_player.members[_selected].clicked = false;
					
					_subMenu.add(new FlxSprite(FlxG.width - 100 - _TILE, _TILE).makeGraphic(100, FlxG.height / 2, FlxG.BLACK));
					_subMenu.add(new FlxText(_subMenu.members[0].x + _TILE, _subMenu.members[0].y * 2, _subMenu.members[0].width - _TILE, _player.members[_selected].Name));
					_subMenu.add(new FlxText(_subMenu.members[0].x + _TILE, _subMenu.members[0].y * 4, _subMenu.members[0].width - _TILE, "Health: " + _player.members[_selected].health + " / " + _player.members[_selected].maxHealth));
					_subMenu.add(new FlxText(_subMenu.members[0].x + _TILE, _subMenu.members[0].y * 6, _subMenu.members[0].width - _TILE, "Magic: " + _player.members[_selected].magic + " / " + _player.members[_selected].maxMagic));
					_subMenu.add(new FlxText(_subMenu.members[0].x + _TILE, _subMenu.members[0].y * 8, _subMenu.members[0].width - _TILE, "Offense: " + _player.members[_selected].offense));
					_subMenu.add(new FlxText(_subMenu.members[0].x + _TILE, _subMenu.members[0].y * 10, _subMenu.members[0].width - _TILE, "Defense: " +_player.members[_selected].defense));
					_subMenu.add(new FlxText(_subMenu.members[0].x + _TILE, _subMenu.members[0].y * 12, _subMenu.members[0].width - _TILE, "Accuracy: " + _player.members[_selected].accuracy));
					//weapon
					//armor
					//accessory
				}
			}
		}
		
		private function _talk():void 
		{ 
			_subMenu.clear();
			
			if (_menu.length > 0)
			{
				if (_menu.members[3].status == FlxButton.PRESSED)
				{
					_talking = true;
					_grid.clear();
					_menu.clear();
					_tmp = 0;
					_mainText.text = "Talk to who?"; 
				}
			}
		}
		
		private function _fight(attacker:Actor, defender:Actor):void
		{
			_fighting = true;
			
			var battleScene:FlxSprite = new FlxSprite();
			battleScene.makeGraphic(FlxG.width, FlxG.height / 2);
			add(battleScene);
			
			var battleStats:FlxSprite = new FlxSprite(0, FlxG.height / 2);
			battleStats.makeGraphic(FlxG.width, FlxG.height / 2, FlxG.BLACK);
			add(battleStats);
			
			var tmpAttacker:FlxSprite = new FlxSprite(FlxG.width - _TILE * _TILE, FlxG.height / 8);
			tmpAttacker.makeGraphic(Math.pow(attacker.width, 2), Math.pow(attacker.height, 2), attacker.color);
			add(tmpAttacker);
			
			var tmpDefender:FlxSprite = new FlxSprite(0, FlxG.height / 8);
			tmpDefender.makeGraphic(Math.pow(defender.width, 2), Math.pow(defender.height, 2), defender.color);
			add(tmpDefender);
			
			var attackerStats:FlxText = new FlxText(FlxG.width / 2, battleStats.y, FlxG.width / 2, 
			attacker.Name + "\n\nHealth: " + attacker.health.toString() + "\n\nMagic: " + attacker.magic.toString());
			add(attackerStats);
			
			var defenderStats:FlxText = new FlxText(0, battleStats.y, FlxG.width / 2, 
			defender.Name + "\n\nhealth: " + defender.health.toString() + "\n\nMagic: " + defender.magic.toString());
			add(defenderStats);
			
			var timer:TimerManager = new TimerManager();
			timer.add(new FlxTimer().start(1, 1, function():void
			{
				var tmp:String = attacker.attack(defender);
				
				trace(tmp);
				
				if (tmp == "Strike." || tmp == "Fatal strike!" || tmp == "Missed.")
				{
					attackerStats.text = attacker.Name + "\n\nHealth: " + attacker.health.toString() + "\n\nMagic: " + attacker.magic.toString() + "\n\n" + tmp;
					defenderStats.text = defender.Name + "\n\nhealth: " + defender.health.toString() + "\n\nMagic: " + defender.magic.toString();
				}
				else
				{
					attackerStats.text = attacker.Name + "\n\nHealth: " + attacker.health.toString() + "\n\nMagic: " + attacker.magic.toString();
					defenderStats.text = defender.Name + "\n\nhealth: " + defender.health.toString() + "\n\nMagic: " + defender.magic.toString() + "\n\n" + tmp;
				}
						
				/*if (defender.health <= 0 || attacker.health <= 0)
				{
					battleScene.kill();
					battleStats.kill();
					tmpAttacker.kill();
					tmpDefender.kill();
					attackerStats.kill();
					defenderStats.kill();
					
					//if (defender.health 
				}*/
						
				timer.add(new FlxTimer().start(1, 1, function():void
				{
					battleScene.kill();
					battleStats.kill();
					tmpAttacker.kill();
					tmpDefender.kill();
					attackerStats.kill();
					defenderStats.kill();
				}));
				
				_fighting = false;
					
			}));
			
		}
		
	}

}