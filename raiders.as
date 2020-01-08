package 
{
	//import adobe.utils.CustomActions;
	//import flash.desktop.NativeApplication;
	//import flash.ui.Multitouch;
	//import flash.ui.MultitouchInputMode;
	//import flash.system.Capabilities;
	//import flash.display.StageScaleMode;
	//import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.display.Graphics;	
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import flash.display.BitmapData;	
	import flash.display.Loader;
	import flash.media.Sound;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
		
	/*
	 * Space Raiders 2012
	 * Inspired by original game published by Psion Software 1982
	 * Anyone may use this code any way he or she wants 
	 * With absolutely no warranty
	 * @author Petr Horák
	 */
	 
[SWF(width="640", height="512", frameRate="30", backgroundColor="#000000")]	 
	 
	public class raiders extends MovieClip 
	{
[Embed(source = "intro.png", mimeType = "image/png")]
private const Intro:Class;
	
[Embed(source = "intro_.png", mimeType = "image/png")]
private const Intro_:Class;	
	
[Embed (source = "enemies.mp3")]
private const EnemiesSound:Class;	

[Embed (source = "newGameSound.mp3")]
private const newGameSound:Class;

[Embed (source = "Lives.mp3")]
private const LivesSound:Class;

[Embed (source = "fireSound.mp3")]
private const FireSound:Class;

[Embed (source = "ShieldHitSound.mp3")]
private const ShieldHitSound:Class;

[Embed (source = "enemyMove.mp3")]
private const enemyMoveSound:Class;

[Embed (source = "enemyHit.mp3")]
private const EnemyHit:Class;

[Embed (source = "ufoMove.mp3")]
private const ufoMove:Class;

[Embed (source = "ufoHit.mp3")]
private const ufoHit:Class;

[Embed (source = "blikSound.mp3")]
private const blikSound:Class;

[Embed (source = "gameOverSound.mp3")]
private const gameOverSound:Class;

		private var screenWidth:uint;
		private var screenHeight:uint;
		private var maxWidth:uint;
		private var maxHeight:uint;		
		private var player:MovieClip;
		private var backGround:MovieClip;
		private var fireArea:MovieClip;
		private var shieldPoint:MovieClip;
		private var strela:MovieClip;
		private var scoreMc0:MovieClip;
		private var scoreMc1:MovieClip;
		private var scoreMc2:MovieClip;
		private var scoreMc3:MovieClip;
		private var scoreMc4:MovieClip;
		private var scoreMc5:MovieClip;						
		private var HscoreMc0:MovieClip;
		private var HscoreMc1:MovieClip;
		private var HscoreMc2:MovieClip;
		private var HscoreMc3:MovieClip;
		private var HscoreMc4:MovieClip;
		private var HscoreMc5:MovieClip;
		private var highMc:MovieClip;
		private var shieldArray:Array;
		private var enemyArray:Array;
		private var enemyCounter:uint;
		private var enemyWidth:Number;
		private var enemyHeight:Number;
		private var rozestupNepratel:uint;
		private var delkaExploze:uint;
		private var enemyPhase:uint;
		private var enemyRow:uint;
		private var enemyColumn:uint;
		private var enemySpeed:Number;
		private var originalEnemySpeed:uint;
		private var rychlostStrely:uint;
		private var enemyDead:Boolean;
		private var rozptylStrel:uint;
		private var krytXArray:Array;
		private var krytWidth:Number;
		private var bombArray:Array;
		private var strelaShieldHit:Boolean;
		private var level:uint;
		private var jeUfo:Boolean;
		private var ufoSmer:int;
		private var spaceship:MovieClip;
		private var spaceship2:MovieClip;
		private var ufoCounter:uint;
		private var playerKeyboardSpeed:Number;
		private var koefBombyNadHracem:uint;
		private var score:uint;
		private var high:uint;
		private var oldScore:String;
		private var shieldY:uint;
		private var enemyY:uint;
		private var ufoY:uint;
		
		private var keyLeft:Boolean;
		private var keyRight:Boolean;
		private var pocetBomb:uint;
		private var maxPocetBomb:uint;
		private var ufoKoef:uint;
		private var ufoTime:uint;
		private var ufoStayTime:uint;
		
		private var lives:int;
		private var liveArray:Array;
		private var lastBonusLive:uint;
		private var enemyMove:Boolean;
		
		private var muzuRight:Boolean;
		private var muzuLeft:Boolean;
		private var jedeLeft:Boolean;
		private var jedeRight:Boolean;
		private var jedeDown:Boolean;
		
		private var downArray:Array;
		private var lastDirection:String;
		private var movePlayer:Boolean;
		private var liveSpeed:uint;
		private var enemiesCounter:uint;
		private var livesChanged:Boolean;
		private var endOfGame:MovieClip;

		private var border:MovieClip;
		private var mainScale:uint;
		private var borderColors:Array;
		private var blikCounter:uint;
		private var blikTotal:uint;
		private var levelPassed:Boolean;
		
		private var png1:Bitmap;
		private var png2:Bitmap;
		
		private var pngMc1:MovieClip;
		private var pngMc2:MovieClip;
		
		private var tmpDelayCounter:uint;
		private var firstRun:Boolean;
		private var actualBonusLive:uint;
		private var Mask:MovieClip;		
	
		public function raiders():void 
		{
			trace ("loaded");
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			stage.frameRate = 30;
		
			mainScale = 2;
			
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		
			//maxWidth = flash.system.Capabilities.screenResolutionX;
			//maxHeight = flash.system.Capabilities.screenResolutionY;	

			border = new MovieClip();
			border.graphics.beginFill(0x000000);
			border.graphics.moveTo(0, 0);
			border.graphics.lineTo(320, 0);
			border.graphics.lineTo(320, 256);
			border.graphics.lineTo(0, 256);
			border.graphics.lineTo(0, 0);
			border.scaleX = border.scaleY = mainScale;
			addChild(border);
					
		        png1 = new Intro();
		        
		        pngMc1 = new MovieClip();
		        pngMc1.addChild( png1 );
			pngMc1.scaleX = png1.scaleY = mainScale;

			addChild(pngMc1);
		
			pngMc1.x = border.width/2-pngMc1.width/2;
			pngMc1.y = border.height/2-pngMc1.height/2;			
		
		        png2 = new Intro_();
		        
		        pngMc2 = new MovieClip ();
		      
		        pngMc2.addChild( png2 );
			pngMc2.scaleX = png2.scaleY = mainScale;		        
		        						
			pngMc2.x = pngMc1.x +53*mainScale;
			pngMc2.y = pngMc1.y +151*mainScale;
			
			addChild(pngMc2);
			
			pngMc2.alpha = 0;
			
			
			pngMc2.addEventListener(MouseEvent.ROLL_OVER, loaderBlik);
			pngMc2.addEventListener(MouseEvent.CLICK, gotourl);
			
			pngMc1.addEventListener(MouseEvent.CLICK, runGame);			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, startKeyListener);
		}
				
		private function startKeyListener(e:KeyboardEvent):void
		{			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, startKeyListener);		
			pngMc2.removeEventListener(MouseEvent.ROLL_OVER, loaderBlik);
			pngMc2.removeEventListener(MouseEvent.CLICK, gotourl);			
			pngMc1.removeEventListener(MouseEvent.CLICK, runGame);			
		
			removeChild(pngMc1);
			removeChild(pngMc2);
			removeChild(border);
			startGame();
		}		
		
		private function gotourl(e:MouseEvent):void
		{
			navigateToURL(new URLRequest("http://goo.gl/jlnYW"));
		}
		
		private function runGame(e:MouseEvent):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, startKeyListener);		
			pngMc2.removeEventListener(MouseEvent.ROLL_OVER, loaderBlik);
			pngMc2.removeEventListener(MouseEvent.CLICK, gotourl);			
			pngMc1.removeEventListener(MouseEvent.CLICK, runGame);
			removeChild(pngMc1);
			removeChild(pngMc2);
			removeChild(border);
			startGame();
		}
		
		private function loaderBlik(e:MouseEvent):void
		{
			pngMc2.alpha = 1;
			pngMc2.addEventListener(MouseEvent.ROLL_OUT, loaderOdblik);
			pngMc2.removeEventListener(MouseEvent.ROLL_OVER, loaderBlik);
		}
		
		private function loaderOdblik(e:MouseEvent):void
		{
			pngMc2.alpha = 0;
			pngMc2.addEventListener(MouseEvent.ROLL_OVER, loaderBlik);
			pngMc2.removeEventListener(MouseEvent.ROLL_OUT, loaderOdblik);
		}		
		
		private function startGame():void
		{		
			actualBonusLive = 1000;
		
			firstRun = true;
			var sound:Sound = new newGameSound();	
			sound.play();			
			
			bombArray = new Array;

			borderColors = new Array (0x0000ff,0xff0000,0xff00ff,0x00ff00,0xffff00,0xffffff)

			shieldY = 160;				
			enemyY = 26;
			ufoY = 11;
			ufoSmer = 0;
			ufoKoef = 40;
			ufoStayTime = 18;
			ufoTime = 0;
						
			screenWidth = 256;
			screenHeight = 192;
						
			enemyRow = 11;
			enemyColumn = 5;
			originalEnemySpeed = 10;
			enemySpeed = originalEnemySpeed;
			rozestupNepratel = 4;
			
			enemyCounter = 0;
			
			downArray = new Array();
			
			enemyPhase = 0;
			jedeRight = true;
			jedeLeft = false;
			jedeDown = false;
			
			rychlostStrely = 8;
			delkaExploze = 3;
			enemyDead = false;
			rozptylStrel = 1.5;
			krytXArray = new Array (40, 112, 184);
			
			strelaShieldHit = false;
			jeUfo = false;
			ufoCounter = 0;
		
			level = 0;
			
			keyLeft = false;
			keyRight = false;
			
			playerKeyboardSpeed = 1.5;
			koefBombyNadHracem = 20;
			
			pocetBomb = 0;
			maxPocetBomb = 8;
			
			score = 0;
			if (high <= 0) high = 0;
			lives = 2;
			liveArray = new Array();
			lastBonusLive = 0;
			
			enemyMove = false;
			movePlayer = true;
			liveSpeed = 3;
			enemiesCounter = 0;
			livesChanged = false;
			levelPassed = false;
			
			initElements();
				
			}
			
				
		private function initElements():void
		{
			border = new MovieClip();
			border.graphics.beginFill(0x000000);
			border.graphics.moveTo(0, 0);
			border.graphics.lineTo(320, 0);
			border.graphics.lineTo(320, 256);
			border.graphics.lineTo(0, 256);
			border.graphics.lineTo(0, 0);
			border.scaleX = border.scaleY = mainScale;
			addChild(border);
		
		
			backGround = new MovieClip;
			backGround.graphics.beginFill(0x000000);
			backGround.graphics.moveTo(0, 0);
			backGround.graphics.lineTo(screenWidth, 0);
			backGround.graphics.lineTo(screenWidth, screenHeight);
			backGround.graphics.lineTo(0, screenHeight);
			backGround.graphics.lineTo(0, 0);
			backGround.scaleX = backGround.scaleY = mainScale;
			backGround.x = border.width/2 - backGround.width/2;
			backGround.y = border.height/2 - backGround.height/2;
			addChild(backGround);
						
			player = drawMatrix(elements.playerArray, 0xbfbfbf);
			backGround.addChild(player);
			player.x = 2.5*player.width;
			player.y = screenHeight - player.height;
			player.newX = player.x + player.width / 2;
			player.muzeStrilet = true;
			player.speed = 50;

					
			fireArea = new MovieClip;
			fireArea.graphics.beginFill(0x000000);
			fireArea.graphics.moveTo(0, 0);
			fireArea.graphics.lineTo(screenWidth, 0);
			fireArea.graphics.lineTo(screenWidth, player.y - player.height);
			fireArea.graphics.lineTo(0, player.y - player.height);
			fireArea.graphics.lineTo(0, 0);
			fireArea.alpha = 0;
			backGround.addChild(fireArea);		
			
			initEnemies();
			
			initShields();
			
			writeScore(true);
			writeHigh();

			setLives();
		}

		private function setLives():void
		{
			if (!firstRun)
			{
			var sound:Sound = new LivesSound();	
			sound.play();
			}
			
			firstRun = false;
			removeListeners();

			for (var i:uint = 0; i<liveArray.length; i++)
			{
				backGround.removeChild(liveArray[i]);
			}		
			
			liveArray = new Array();
			
			for (i = 0; i<lives; i++)
			{
			liveArray[i] = drawMatrix(elements.playerArray, 0x10d0d0);
			backGround.addChild(liveArray[i]);
			liveArray[i].x = 74+i*(player.width+5)+player.width;
			liveArray[i].y = 0;
			}	
				
			stage.addEventListener(Event.ENTER_FRAME, moveLivesLeft);
		}
		
		private function moveLivesLeft(e:Event):void
		{
		var canIlisten:Boolean = false;
		
		for (var i:uint = 0; i<liveArray.length; i++)
			{
				if (liveArray[i].x-liveSpeed >= 74+i*(player.width+5)) liveArray[i].x = liveArray[i].x-liveSpeed;
				else canIlisten = true;
			}
				
		if (movePlayer)	
		{
		if (player.x>=0 && player.x-liveSpeed*2>=0) 
			{
			player.x = player.x-liveSpeed*2;
			canIlisten = false;
			}
		else 
			{
			canIlisten = true;
			player.x = 0;
			}
		player.newX = player.x+player.width/2;	
		keyRight = false;
		keyLeft = false;
		}
		
		if (canIlisten)
		{
			stage.removeEventListener(Event.ENTER_FRAME,moveLivesLeft);
			if (enemiesCounter==0 || livesChanged) 
			{
			livesChanged = false;
			initListeners();
			}
		}
		}
		
		private function writeScore(poprve:Boolean = false):void
		{
		var scoreString:String = score.toString();
		while (scoreString.length<6) 
		{
		scoreString = "0"+scoreString;
		}
		
		if (poprve) 
		{
			scoreMc0 = new MovieClip;
			scoreMc1 = new MovieClip;
			scoreMc2 = new MovieClip;
			scoreMc3 = new MovieClip;
			scoreMc4 = new MovieClip;
			scoreMc5 = new MovieClip;
		}																
		
		for (var i:uint = 0; i<scoreString.length; i++)
		{
			if ((!poprve &&scoreString.charAt(i) != oldScore.charAt(i)) || poprve) 
			{
			if (!poprve) backGround.removeChild(this["scoreMc"+i]);
			this["scoreMc"+i] = drawMatrix(elements.cisla[uint(scoreString.charAt(i))], 0x10d0d0);
			this["scoreMc"+i].y = 0;
			this["scoreMc"+i].x = this["scoreMc"+i].width*i;
			if (poprve) backGround.addChild(this["scoreMc"+i])
			else backGround.addChild(this["scoreMc"+i]);
			}
		}
		oldScore = scoreString;
		
		if (score>=actualBonusLive) 
		{
			if (lives<3)
			{
			removeListeners();
			livesChanged = true;
			movePlayer = false;
			keyLeft = false;
			keyRight = false;
			lives ++;
			
			blikCounter = 0;
			blikTotal = 7;
			stage.addEventListener(Event.ENTER_FRAME, blikHandler);

			}
			if (actualBonusLive == 1000) actualBonusLive = 10000
			else actualBonusLive = actualBonusLive+10000;
		}
	
		}
		
		private function writeHigh():void
		{
		var scoreString:String = high.toString();
		while (scoreString.length<6) 
		{
		scoreString = "0"+scoreString;
		}
		
		HscoreMc0 = new MovieClip;
		HscoreMc1 = new MovieClip;
		HscoreMc2 = new MovieClip;
		HscoreMc3 = new MovieClip;
		HscoreMc4 = new MovieClip;
		HscoreMc5 = new MovieClip;
		
		var l:uint;
		
		for (var i:uint = scoreString.length; i>0; i--)
			{
			l = i-1;
			this["HscoreMc"+l] = drawMatrix(elements.cisla[uint(scoreString.charAt(scoreString.length-i))], 0x10d0d0);
			this["HscoreMc"+l].y = 0;
			this["HscoreMc"+l].x = screenWidth -1 - this["HscoreMc"+l].width*l-this["HscoreMc"+l].width;
			backGround.addChild(this["HscoreMc"+l])
			}
		
		highMc = new MovieClip;
		highMc = drawMatrix(elements.high,0x10d0d0);
		highMc.y = 0;
		highMc.x = HscoreMc5.x-highMc.width;
		backGround.addChild(highMc);
		}		
		
		private function initShields():void
		{
			var shieldPointArray:Array = new Array;
			shieldPointArray.push(0);
			shieldPointArray[0] = [1];
			
			krytWidth = elements.shieldCelek[0].length;
			
			shieldArray = new Array;
			
			for (var i:uint = 0; i < 3; i++)
			{
				shieldArray[i] = new Array;
				for (var y:uint = 0; y < elements.shieldCelek.length; y++)
				{
					for (var x:uint = 0; x < elements.shieldCelek[y].length; x++)
					{	
					if (elements.shieldCelek[y][x] == 1)
						{
						shieldPoint = drawMatrix(shieldPointArray, 0x10d0d0);	
						shieldPoint.x = krytXArray[i] + x; 
						shieldPoint.y = shieldY + y; 
						backGround.addChild (shieldPoint);
						backGround.setChildIndex(shieldPoint, backGround.getChildIndex(fireArea) - 1);
						shieldArray[i].push(shieldPoint);
						}
					}
				}
			}
		}
		
		private function initEnemies():void
		{  
			if (enemyY<80 && level!=0) enemyY = enemyY+4;
			jedeLeft = false;
			jedeRight = true;
		 	var kteryEnemy:Array = [elements.enemy1, elements.enemy2, elements.enemy2, elements.enemy3, elements.enemy3];
			var kteryEnemy_:Array = [elements.enemy1_, elements.enemy2_, elements.enemy2_, elements.enemy3_, elements.enemy3_];
			var bodu:Array = [30,20,20,10,10];
			var enemyColor:Array = [0xcece00, 0x00ce00, 0x00ce00, 0xce0000, 0xce0000];

		   	enemyWidth = elements.enemy1[0].length;
			enemyHeight = elements.enemy1.length;	
		   			
			var nepritel:MovieClip; 
			var nepritel_:MovieClip;
			var exploze:MovieClip;
			
			enemyArray = new Array;
			
			for (var i:uint = 0; i < enemyColumn; i++)
			{
				for (var j:uint = 0; j < enemyRow; j++)
				{		   											
				nepritel = drawMatrix(kteryEnemy[i], enemyColor[i]);
				nepritel_ = drawMatrix(kteryEnemy_[i], enemyColor[i]);
				exploze =  drawMatrix(elements.vybuch, enemyColor[i]);
				
				enemyArray.push(nepritel);
			
				nepritel.row = i;
				nepritel.x = (screenWidth/2 - (enemyRow*enemyWidth+((enemyRow-1)*rozestupNepratel))/2) + j* (enemyWidth+rozestupNepratel);
				nepritel.y = enemyY + i * (enemyHeight + rozestupNepratel);
				
				nepritel_.x = nepritel.x;
				nepritel_.y = nepritel.y;
				exploze.x = nepritel.x;
				exploze.y = nepritel.y;
				
				nepritel.blik = false;
				nepritel.stav2 = nepritel_;
				nepritel.stav3 = exploze;
				nepritel.row = i;
				nepritel.hazi = 0;
				nepritel.points = bodu[i];
				
				backGround.addChild(nepritel); 
				backGround.addChild(nepritel_);
				backGround.addChild(exploze);
				
				backGround.setChildIndex(nepritel, backGround.getChildIndex(fireArea) - 1);
				backGround.setChildIndex(nepritel_, backGround.getChildIndex(fireArea) - 1);
				backGround.setChildIndex(exploze, backGround.getChildIndex(fireArea) - 1);
				
				nepritel.alpha = 0;
				nepritel_.alpha = 0;
				exploze.alpha = 0;
				}
			}
			maxPocetBomb = maxPocetBomb+level;
				
			var sound:Sound = new EnemiesSound();			
			sound.play();				
									
			stage.addEventListener (Event.ENTER_FRAME, showEnemies);	
		}
		
		private function showEnemies(e:Event):void
		{								
			if (enemiesCounter%13 == 0)
			{
				
			for (var i:uint = 0; i<enemyArray.length; i++)
				{		
					if (enemyArray[i].row == enemyColumn - enemiesCounter/13) enemyArray[i].alpha = 1;
				}
				
			}
				
			if (enemiesCounter==enemyColumn*13)
			{
			stage.removeEventListener(Event.ENTER_FRAME, showEnemies);
			enemiesCounter = 0;
			initListeners();
			}
			enemiesCounter++;	
		}
		
		private function initListeners():void
		{
			player.addEventListener(MouseEvent.MOUSE_DOWN, playerDown);
			fireArea.addEventListener(MouseEvent.MOUSE_DOWN, fire);
			stage.addEventListener(Event.ENTER_FRAME, frameHandler);
				
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyListener);			
			stage.addEventListener(KeyboardEvent.KEY_UP, keyReleaseListener);			
		}
		
		private function removeListeners():void
		{
			player.removeEventListener(MouseEvent.MOUSE_DOWN, playerDown);
			fireArea.removeEventListener(MouseEvent.MOUSE_DOWN, fire);
			stage.removeEventListener(Event.ENTER_FRAME, frameHandler);
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyListener);			
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyReleaseListener);	
		}		
		
		
		private function keyListener(e:KeyboardEvent):void
		{
			if (e.keyCode == 89 || e.keyCode== 90 || e.keyCode== 37) 
			{
			keyLeft = true;
			keyRight = false;
			}
			if (e.keyCode == 88 || e.keyCode== 39) 
			{
			keyRight = true;
			keyLeft = false;
			}
			if (e.keyCode == 32) fire(null);
		}
		
		private function keyReleaseListener(e:KeyboardEvent):void


		{
			if (e.keyCode == 89 || e.keyCode== 90 || e.keyCode== 37) keyLeft = false;
			if (e.keyCode == 88 || e.keyCode== 39) keyRight = false;
		}
		
		private function frameHandler(e:Event):void
		{
			// HACK - sound lag
		
			//pohyb hrace - klavesnice
			if (keyLeft && player.x - 1 > 0) player.x -= playerKeyboardSpeed;
			if (keyRight && (player.x + player.width) < screenWidth) player.x += playerKeyboardSpeed;
		
			//pohyb hrace - mys
			if (!keyRight && !keyLeft)
			{
			if (Math.round(player.x+ player.width / 2) != Math.round(player.newX)) 
			{
				var speed:Number = Math.round (Math.abs (player.x + player.width / 2 - player.newX) / player.speed);
				if (player.newX > player.x+ player.width / 2 && player.x + speed < screenWidth-player.width) player.x += speed;
				else if (player.x - speed > 0) player.x -= speed;
			}
			else player.x = player.newX - player.width / 2;
			}
			else player.newX = player.x + player.width/2;
			//pohyb strely a jeji kolize
			
				if (strela != null)
				{
						//strela pryc z obrazovky - neni tu spatne ta 0?
						if (strela.y - rychlostStrely < 0) odstranStrelu();
						else 
						{
						if (!strelaShieldHit) 
						{
						shieldHit(strela.x, strela.y+strela.height, strela.y+strela.height+rychlostStrely+player.height, rozptylStrel, strela);	
						strelaShieldHit = true;
						}
						}
				}
			
			if (enemyArray.length != 0) enemyCounter++;
			if (enemyCounter >= enemySpeed)
			{
				enemyCounter = 0;	
				enemyMove = true;
				muzuLeft = true;
				muzuRight = true;	
				downArray = new Array ();
			}
									
			for (var i:uint = 0; i < enemyArray.length; i++)
			{
						
			// pohyb nepratel
			
				if (enemyMove)
				{

				if (enemyArray[i].x + enemyWidth + (enemyWidth+rozestupNepratel)/2 >= screenWidth 
					&& enemyArray[i].stav2.x + enemyWidth + (enemyWidth+rozestupNepratel)/2 >= screenWidth
					&& enemyArray[i].row == enemyPhase) muzuRight = false;
							i
				
					if (enemyArray[i].x  - (enemyWidth+rozestupNepratel) /2 <= 0  
							&& enemyArray[i].stav2.x  - (enemyWidth + rozestupNepratel)  / 2 <= 0  
							&& enemyArray[i].row == enemyPhase) muzuLeft = false;
				
					if (!enemyArray[i].movedY) downArray.push(enemyArray[i].row);
				}			
			
			//strelba nepratel; 
				if (Math.random()*10000 > 9900+Math.round(enemyArray.length/2)+(Math.abs((enemyArray[i].x+enemyArray[i].width/2) - (player.x + player.width / 2)))/(screenWidth/512) - level*2)
				{
				 if (pocetBomb<maxPocetBomb && enemyArray[i].hazi<2) bomb(enemyArray[i]);
				 //break;
				}
							
							//zasah strelou
							if (strela != null) 
							{
								if (Math.abs(strela.y - (enemyArray[i].y+enemyArray[i].height/2)) < strela.height && Math.abs((strela.x+strela.width/2)-(enemyArray[i].x+enemyArray[i].width/2)) < enemyArray[i].width/2)
									{
									var sound:Sound = new EnemyHit();
									sound.play();
									enemyArray[i].alpha = 0;
									enemyArray[i].stav2.alpha = 0;
									enemyArray[i].stav3.alpha = 1;
									enemyArray[i].dead = true;
									enemyArray[i].deadCounter = 0;
									odstranStrelu();
									enemyDead = true;
									//break;
									}
							}
							
				//odstraneni nepritele + vybuch
					if (enemyArray[i].dead) 
					{
					enemyArray[i].deadCounter++;
					if (enemyArray[i].deadCounter > delkaExploze) 
					{
					backGround.removeChild(enemyArray[i]);
					backGround.removeChild(enemyArray[i].stav2);
					backGround.removeChild(enemyArray[i].stav3);
					score = score+enemyArray[i].points;	
					writeScore(false);
					enemyArray.splice(i, 1);
					enemyDead = false;
					enemySpeed = enemySpeed - ((enemyRow*enemyColumn)/enemyArray.length)/((enemyRow*enemyColumn)/*/2*/);
					}
					}												
						
						
						}
						
			if (enemyMove && enemyArray.length>0)
			{			
			if (jedeRight && muzuRight) moveEnemies("right");
			if (jedeLeft && muzuLeft) moveEnemies("left");
			if ((jedeLeft && !muzuLeft) || jedeDown) 
			{
			jedeLeft = false;
			enemyPhase = Math.max.apply(null, downArray);
			moveEnemies("down");
			}
			else if ((jedeRight && !muzuRight) || jedeDown) 
			{
			enemyPhase = Math.max.apply(null, downArray);
			jedeRight = false;
			moveEnemies("down");			
			}
			enemyMove = false;
			}
				
						
//bombArray
						for (i = 0; i < bombArray.length; i++)
						{
							if (strela != null) 
							{
							var hitHit:Boolean = false;
								{
								if (Math.abs(bombArray[i].x-strela.x)<strela.width && Math.abs(bombArray[i].y-strela.y)<strela.height)
								{
								odstranStrelu();
								odstranBombu(bombArray[i]);
								hitHit = true;
								break;
								}
						
								
								}
							}
						//kolize bomb

				if (bombArray[i].y +rychlostStrely  > screenHeight)
				{
					odstranBombu(bombArray[i]);
				}
				if (bombArray[i]!=null && !bombArray[i].shieldBombHit) 
				{
				shieldHit(bombArray[i].x, bombArray[i].y+bombArray[i].height, bombArray[i].y+bombArray[i].height+rychlostStrely/2, rozptylStrel*2.5, bombArray[i]);	
				}
				
				if (bombArray[i]!=null && Math.abs(bombArray[i].y-player.y)<bombArray[i].height && Math.abs((bombArray[i].x+bombArray[i].width/2) - (player.x+player.width/2))<player.width/2)
				{
				removeListeners ();
				if (strela!=null) odstranStrelu();
				removeAllBombs();	
				lives --;
				player.alpha = 0;
				livesChanged = true;
				movePlayer = true;
				blikCounter = 0;
				blikTotal = 13;
				stage.addEventListener(Event.ENTER_FRAME, blikHandler);
				}
				if (bombArray[i]!=null) bombArray[i].y = bombArray[i].y + rychlostStrely / 4;
			}			
						
						
						
						
					//nedoslo-li ke kolizi (strela existuje) - let!
					if (strela != null) 
					{
						strela.y = strela.y - rychlostStrely;
						strelaShieldHit = false;
					}


						
			//pohyb nepratel
																
			// enemy spaceship
			
			var ufoRandom:Number = Math.random();
			if (ufoRandom >.9 && !jeUfo && ufoTime==0) 
			{
			ufoCounter++;
			if (ufoCounter>ufoKoef) 
				{
				var kolko:String = String(Math.round(Math.random()*2)*100);
				if (kolko=="0") kolko = "050";	
				ufo(kolko);
				ufoCounter = 0;
				}
			}
			
			//jeji pohyb
			if (jeUfo)
			{
			 sound = new ufoMove();
			 sound.play();
			 spaceship.x = spaceship.x+playerKeyboardSpeed*(2/3)*ufoSmer;
			 spaceship2.x = spaceship.x+spaceship.width/2 - spaceship2.width/2;
			 
			 //odstran po preletu
			 if (spaceship.x>screenWidth+1 || spaceship.x<-spaceship.width-1)
			 	{
			 	backGround.removeChild(spaceship);
			 	backGround.removeChild(spaceship2);
 				backGround.removeChild(Mask);	
			 	jeUfo = false;
			 	}

			 // ufo zasazeno
			 if (strela!=null)
			 {
			if (Math.abs(strela.y - spaceship.y+spaceship.height) < strela.height && Math.abs(strela.x-(spaceship.x+spaceship.width/2)) < spaceship.width/2)
						{
						sound = new ufoHit();
						sound.play();
						ufoSmer = 0;
						jeUfo = false;
						spaceship.alpha = 0;
						odstranStrelu();						
						spaceship2.alpha = 1
						score = score+spaceship.bodu;
						backGround.removeChild(spaceship);
						ufoTime = 1;
						writeScore();
						}
			  }
			 }
			 
			 if (ufoTime>0)
			 {
			 ufoTime++;
			 if (ufoTime>ufoStayTime)
			 	{
				backGround.removeChild(spaceship2);
				backGround.removeChild(Mask);
				ufoTime = 0;
			 	}
			 }
			
				//vetrelci pristali				
				for (i = 0; i < enemyArray.length; i++)
				{
					if (enemyArray[i].y + enemyArray[i].height > player.y) gameOver();
				}				
				
				//vetrelci snedli kryty
				for (i = 0; i < enemyArray.length; i++)
				{
					if (enemyArray[i].y + enemyArray[i].height > shieldY) odstranKryty();
				}
			// next level
			if (enemyArray.length==0)
			{
			removeAllBombs();
			removeListeners();
			level++;
			enemySpeed = originalEnemySpeed-level/2;		
			levelPassed = true;		
			blikCounter = 0;
			blikTotal = 75;
			keyLeft = false;
			keyRight = false;
			stage.addEventListener(Event.ENTER_FRAME, blikHandler);
			}
	}	
	
	private function blikHandler(e:Event):void
	{
	if (blikCounter%3==0)
	{
	var sound:Sound = new blikSound();
	sound.play();
	}

	var colorIndex:uint = blikCounter/2;	
	blikCounter ++;
	
	if (blikCounter<blikTotal)
		{
			while (colorIndex>borderColors.length) 
			{
				colorIndex = colorIndex - borderColors.length;
			}
			border.parent.removeChild(border);
			border = new MovieClip;
			border.graphics.beginFill(borderColors[colorIndex]);
			border.graphics.moveTo(0, 0);
			border.graphics.lineTo(320, 0);
			border.graphics.lineTo(320, 256);
			border.graphics.lineTo(0, 256);
			border.graphics.lineTo(0, 0);
			border.scaleX = border.scaleY = mainScale;
			addChild (border);
			setChildIndex(border,0);
		}
	else
	{
	stage.removeEventListener(Event.ENTER_FRAME, blikHandler);

			border.parent.removeChild(border);
			border = new MovieClip;
			border.graphics.beginFill(0x000000);
			border.graphics.moveTo(0, 0);
			border.graphics.lineTo(320, 0);
			border.graphics.lineTo(320, 256);
			border.graphics.lineTo(0, 256);
			border.graphics.lineTo(0, 0);
			border.scaleX = border.scaleY = mainScale;
			addChild (border);		
			setChildIndex(border,0);			
		
	if (levelPassed && !livesChanged)
	{
		levelPassed = false;
		initEnemies();
		if (shieldArray[0].length==0&& shieldArray[1].length==0 && shieldArray[2].length==0) initShields();
	}	
			
	if (livesChanged)
	{
		if (movePlayer)
		{
		if (lives>=0)
			{
				player.x = 2.5*player.width;
				player.alpha = 1;
				movePlayer = true;
				setLives();	
			}
				else 
			{
				gameOver();
			}
		}
		if (!movePlayer || levelPassed) 
		{
		levelPassed = false;
		setLives();
		}
	}
	
	
	}
	}
	
	private function removeAllBombs():void
	{
		for (var j:uint = 0; j<bombArray.length; j++)
		{
			pocetBomb --;
			bombArray[j].kdoHodil.hazi--;
			backGround.removeChild(bombArray[j]);
		}
								
		bombArray = new Array();
	}
				
	
	private function moveEnemies(smer:String):void
	{

		if (((smer=="left" || smer=="right") && enemyArray[enemyArray.length-1].row == enemyPhase) || smer=="down") 
		{
		var sound:Sound = new enemyMoveSound();
		sound.play();		
		}
		
		for (var i:uint = 0; i < enemyArray.length; i++)
				{
					if (enemyArray[i].row == enemyPhase)
					{
						if (smer=="right") 
						{
						enemyArray[i].x = enemyArray[i].x + (enemyWidth+rozestupNepratel) /2;
						enemyArray[i].stav2.x = enemyArray[i].x;
						enemyArray[i].stav3.x = enemyArray[i].x;
						enemyArray[i].movedY = false;
						}
						
						if (smer=="left")
						{
						enemyArray[i].x = enemyArray[i].x  - (enemyWidth+rozestupNepratel) /2;
						enemyArray[i].stav2.x = enemyArray[i].x;
						enemyArray[i].stav3.x = enemyArray[i].x;
						enemyArray[i].movedY = false;
						}
						
						if (smer=="down")
						{
						enemyArray[i].y = enemyArray[i].y + (enemyHeight+rozestupNepratel) /2;
						enemyArray[i].stav2.y = enemyArray[i].y;
						enemyArray[i].stav3.y = enemyArray[i].y;
						enemyArray[i].movedY = true;				
						}
					if (!enemyArray[i].dead) enemyBlik(enemyArray[i]);	
					}
				}
		if (smer=="left" || smer =="right")
			{
			if (enemyPhase < enemyArray[enemyArray.length-1].row) enemyPhase++
			else 
			{
			enemyPhase = enemyArray[0].row;
			lastDirection = smer;
			}
			}	
		else
		{
			if (enemyPhase > enemyArray[0].row) 
			{
			enemyPhase--;	
			jedeDown = true;
			}
			else 
			{
			jedeDown = false;
			if (lastDirection=="right") jedeLeft = true
			else jedeRight = true;
			}
		}
	}

	
	private function ufo(points:String):void
	{
		spaceship = new MovieClip;
		spaceship2 = new MovieClip;
		spaceship = drawMatrix(elements.ufoArray, 0xd010d0);
		var tmpMc:MovieClip;
		for (var i:uint = 0; i<points.length; i++)
		{
		 tmpMc = new MovieClip;
		 tmpMc = drawMatrix(elements.cisla[uint(points.charAt(i))], 0xd010d0);
		 spaceship2.addChild(tmpMc);
		 tmpMc.x = tmpMc.width*i;
		}
		spaceship.bodu = uint(points);
		
		if (Math.random()>.5) 
			{
			ufoSmer = 1;
			spaceship.x = -spaceship.width;
			}
			else
			{
			ufoSmer = -1;
			spaceship.x = screenWidth;
			}
		
		spaceship.y = ufoY;	
		spaceship2.y = ufoY;
		backGround.addChild(spaceship);
		backGround.addChild(spaceship2);
		spaceship2.alpha = 0;
		
		Mask = new MovieClip();
		Mask.graphics.beginFill(0xFF0000);
		Mask.graphics.drawRect(0, 0, screenWidth, screenHeight);
		Mask.graphics.endFill();
		backGround.addChild(Mask);
		Mask.x = 0;
		Mask.y = 0;
		Mask.mouseEnabled = false;
		spaceship.mask = Mask;		
		jeUfo = true;
	}
	
	private function bomb(mc:MovieClip):void
	{
		var bomba:MovieClip = drawMatrix(elements.fireArray, 0x10d0d0);
		bomba.x = mc.x + (Math.random()*mc.width) -bomba.width/2;
		bomba.y = mc.y + mc.height;
		bomba.shieldBombHit = false;
		mc.hazi++;
		bomba.kdoHodil = mc;
		pocetBomb ++;
		bombArray.push(bomba);
		backGround.addChild(bomba);
		backGround.setChildIndex (bomba, 1);
	}
	
	private function odstranBombu(mc:MovieClip):void
	{
		for (var i:uint = 0; i < bombArray.length ; i++ )
		{
			if (bombArray[i] == mc) 
			{
			bombArray.splice(i, 1);
			break;
			}
		}
		pocetBomb --;
		mc.kdoHodil.hazi--;
		mc.parent.removeChild(mc);
	}

	
	private function shieldHit(x:Number, startY:Number, endY:Number, rozptyl:uint, mc:MovieClip):void
	{
		var kteryShield:uint = 3;
		var hit:Boolean = false;
		if (startY > shieldY || endY > shieldY)
		{
			if (mc.x >= krytXArray[0] && mc.x < krytXArray[0] + krytWidth) kteryShield = 0;
			if (mc.x >= krytXArray[1] && mc.x < krytXArray[1] + krytWidth) kteryShield = 1;
			if (mc.x >= krytXArray[2] && mc.x < krytXArray[2] + krytWidth) kteryShield = 2;
			
			if (kteryShield == 3) 
			{
			if (mc == strela) strelaShieldHit = false;	
			else mc.shieldBombHit = false;
			return;
			}
			else
				{
				for (var j:int = startY; j< endY; j++)
					{
					for (var i:uint = 0; i < shieldArray[kteryShield].length; i++)
						{
							if (Math.round(shieldArray[kteryShield][i].x-x)==0 && Math.round(shieldArray[kteryShield][i].y-j)==0)
							{
								backGround.removeChild(shieldArray[kteryShield][i]);
								shieldArray[kteryShield].splice (i, 1);
								strelaShieldHit = true;
								mc.shieldBombHit = true;
								hit = true;
								break;
							}
						}
						
						if (hit)
						{
						for (var o:uint = 0; o<rozptyl; o++)
						{
						var koef:int = 1;
						if (Math.random()>.5) koef = -1;
						var rX:Number = x+(Math.random()*rozptyl)*koef;
						koef = 1;
						if (Math.random()>.5) koef = -1;
						var rY:Number = j+(Math.random()*rozptyl)*koef;
								
						for (var l:uint = 0; l < shieldArray[kteryShield].length; l++)
						{	
							if (Math.round(shieldArray[kteryShield][l].x-rX)==0 && Math.round(shieldArray[kteryShield][l].y-rY)==0)
								{
								backGround.removeChild(shieldArray[kteryShield][l]);
								shieldArray[kteryShield].splice (l, 1);
								break;
								}
						}
						}
						}
					
				}
			}
			}
		else
		{
			if (mc == strela) strelaShieldHit = false;
			else mc.shieldBombHit = false;			
		}
		
		if (hit) 
		{
			var sound:Sound = new ShieldHitSound();
			sound.play();

			if (mc == strela) odstranStrelu()
			else odstranBombu(mc);
		}
		
	}
	
	private function odstranStrelu():void
	{
		backGround.removeChild(strela);
		player.muzeStrilet = true;
		strela = null;	
	}
	
	private function odstranKryty():void
	{
		for (var j:uint = 0; j < 3; j++)
		{
		for (var i:uint = 0; i < shieldArray[j].length; i++)
		{
			backGround.removeChild(shieldArray[j][i]);
			shieldArray[j].splice(i,1);
		}
		}
	}
	
	private function gameOver():void
	{
			var sound:Sound = new gameOverSound();
			sound.play();
			removeListeners();
			endOfGame = new MovieClip();
			endOfGame = drawMatrix(elements.gameIsOver, 0xbfbfbf);
			backGround.addChild (endOfGame);
			endOfGame.x = 0;
			endOfGame.y = 188;
			fireArea.addEventListener(MouseEvent.CLICK, newGameMouse);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, newGameKey);			
	}		
		
		
	private function newGameKey(e:KeyboardEvent):void
		{
			if (e.keyCode == 32) newGame();
		}
			
	private function newGameMouse(e:MouseEvent):void
	{
		newGame();
	}
	
	private function newGame():void
	{
			if (score>high) high = score;
			fireArea.removeEventListener(MouseEvent.CLICK, newGameMouse);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, newGameKey);
			
			for (var i:uint = 0; i<backGround.numChildren; i++)
			{
				backGround.removeChild(backGround.getChildAt(i));
			}
			
			removeChild(backGround);
			removeChild(border);
			
			startGame();
	}
		
		private function enemyBlik(mc:MovieClip):void
		{
			if (!mc.blik)
			{
				mc.alpha = 0;
				mc.stav2.alpha = 1;
				mc.blik = true;
			}
			else
			{
				mc.alpha = 1;
				mc.stav2.alpha = 0;
				mc.blik = false;
			}			
		}
		
		private function playerDown(e:MouseEvent):void
		{
			player.removeEventListener(MouseEvent.MOUSE_DOWN, playerDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, playerRelease);
		}
		
		private function playerRelease(e:MouseEvent):void
		{
			player.newX = mouseX;
			if (player.newX < 0) player.newX = 0;
			if (player.newX > screenWidth) player.newX = screenWidth;
			player.addEventListener(MouseEvent.MOUSE_DOWN, playerDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, playerRelease);
		}		
		
		private function fire(e:MouseEvent):void
		{			
			if (player.muzeStrilet)
			{
			var sound:Sound = new FireSound();
			sound.play();	
			strela = drawMatrix(elements.fireArray, 0xbfbfbf);
			backGround.addChild(strela);
			backGround.setChildIndex (strela, backGround.getChildIndex(fireArea) - 1);
			strela.x = player.x + player.width / 2 -strela.width/2;
			strela.y = player.y;						
			player.muzeStrilet = false;
			}
		}
		
		private function drawMatrix(drawArray:Array, color:Number):MovieClip
		{
			var mc:MovieClip = new MovieClip;
			var bd:BitmapData = new BitmapData(drawArray[0].length, drawArray.length, false, 0x000000);
			for (var i:uint = 0; i < drawArray.length; i++)
			{
				for (var j:uint = 0; j < drawArray[i].length; j++)
				{
					if (drawArray[i][j] == 1) bd.setPixel(j, i, color);
				}
			}

			var bmp:Bitmap = new Bitmap(bd);
			mc.addChild(bmp);			
			
			return mc;
		}
		
		/*
		private function deactivate(e:Event):void 
		{
			// auto-close
			//NativeApplication.nativeApplication.exit();
		}
		*/
	}
}	

