/**
 * converts int to bool
 */
boolean int2bool(int i)
{
	if(i == 0)
		return false;
	else
		return true;
}

/**
 * converts bool to int
 */
int bool2int(boolean b)
{
	if(b)
		return 1;
	else
		return 0;
}

/**
 * Return random number {-1, 1}
 */
int randONEorNEGATIVEONE()
{
	int i = (int)random(0,2);
	if(i < 1)
		return -1;
	else
		return 1;
}

/**
 * delay by the given miliseconds
 * for debugging purposes only
 */
public void pause(int ms)
{
	try{
		Thread.sleep(ms);
	}catch (InterruptedException ie){}
}