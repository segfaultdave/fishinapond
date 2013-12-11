/**
 * Displays animation
 */

class Animation
{
	PImage[] sprites;
	int sprite_index;
	float animation_last_millis;
	float frame_rate;
	boolean should_loop;

	Animation(float f, PImage[] s, boolean l)
	{
		frame_rate = f;
		sprites = s;
		should_loop = l;
		animation_last_millis = millis();
		sprite_index = 0;
	}

	/**
	 * make animation start from 1st frame again
	 */
	void resetAnimation()
	{
		sprite_index = 0;
	}

	/**
	 * update sprite, determine when to go to next frame
	 */ 
	void update()
	{
		if(millis() - animation_last_millis > frame_rate)
		{
			animation_last_millis = millis();

			// go to next frame, loop only if we should
			if(should_loop)
				sprite_index = (sprite_index + 1) % sprites.length;
			else
				sprite_index = min(sprite_index + 1, sprites.length);
		}
	}

	/**
	 * display sprite
	 * return whether we actually drew the sprite
	 */
	boolean display()
	{
		// don't draw if we did not reset sprite index
		if(sprite_index >= sprites.length)
			return false;

		// draw sprite at (0, 0)
		// caller has to use translate() to move the sprite
		image(sprites[sprite_index], 0 , 0);
		return true;
	}
}