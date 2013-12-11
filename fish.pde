/**
 * front end visual for the fish
 * includes sprites and sounds
 * controlled by phaseDecision
 */
class Fish
{
	int px, py;					// for position calculation
	int startx, starty;			// for resetting position
	float fish_last_millis;		// for sprite calculation
	int state;					// one of the values right below

	// states of the fish
	static final int IDLE 	= 0;
	static final int WATCH	= 1;
	static final int PLAY 	= 2;
	static final int HAPPY  = 3;
	static final int SAD 	= 4;

	// sound for fish
	AudioPlayer bubble_happy, bubble_sad, water_splash;

	// for loading animations
	final String[] states = {"idle", "watch", "play", "happy", "sad"};
	final float[] frame_rates = {400.0, 400.0, 125.0, 150.0, 200.0};

	// reflection in water, and all animations. index as above
	Animation reflection;
	Animation[] fish_animations;

	Fish(int x, int y)
	{
		// set up positions
		startx = x;
		starty = y;
		state = 0;
		resetPosition();

		// load all the sprites for the fish
		fish_animations = new Animation[states.length];
		for(int i = 0; i < fish_animations.length; i++)
		{
			// for each state, create animation object
			PImage[] sprites = new PImage[4];
			for(int j = 0; j < sprites.length; j++)
			{
				sprites[j] = loadImage("fish/fish_"+states[i]+"_"+j+".png");
			}

			boolean should_loop = (i != 2);
			fish_animations[i] = new Animation(frame_rates[i], sprites, should_loop);
		}
		
		// load all the sprites for reflection
		PImage[] reflection_sprites = new PImage[4];
		for(int i = 0; i < reflection_sprites.length; i++)
		{
			reflection_sprites[i] = loadImage("fish/reflect_"+i+".png");
		}
		reflection = new Animation(100.0, reflection_sprites, true);

		// load sound effects for the fish
		water_splash = minim.loadFile("splash.wav");
		bubble_sad = minim.loadFile("bubble_sad.wav");
		bubble_happy = minim.loadFile("bubble_happy.wav");
	}

	/**
	 * make a splash sround
	 */
	void makeSplashSound()
	{
		water_splash.rewind();
		water_splash.play();
	}

	/**
	 * resets the animation so we play at frame 0
	 */
	void resetAnimation()
	{
		fish_animations[state].resetAnimation();
	}

	/**
	 * puts fish back to original position
	 */
	void resetPosition()
	{
		updatePosition(startx, starty);
	}

	/*
	 * push fish at position (x, y)
	 */ 
	void updatePosition(int x, int y)
	{
		fish_last_millis = millis();
		px = x;
		py = y;
	}

	/*
	 * changing the state of the fish
	 */
	void updateState(int s)
	{
		if(s == HAPPY)
		{
			bubble_happy.rewind();
			bubble_happy.play();
		}
		else if(s == SAD)
		{
			bubble_sad.rewind();
			bubble_sad.play();
		}
		state = s;
	}

	/*
	 * Draw the fish
	 */
	void display()
	{
		// update all sprites
		reflection.update();
		fish_animations[state].update();

		imageMode(CENTER);
		tint(255, 204);
		pushMatrix();
		translate(px, py);
			if(fish_animations[state].display())
				reflection.display();
		popMatrix();
		imageMode(CORNER);
		tint(255, 255);
	}
}

/**
 * Create fish object, read in all the image files
 */
void fishInit()
{
	fish = new Fish(473, 544);
}