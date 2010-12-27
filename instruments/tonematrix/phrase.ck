public class TMPhrase extends Mode
{
	200::ms => dur stepDuration;
	0 => int currentColumn;
	Colors.lightOrange => int scrollColor;
	Colors.lightGreen => int queueColor;
	Colors.green => int noteOnColor;
	8 => int numColumns;
	8 => int numRows;
	float tempo;

	int notesQueued[8][8];
	
	fun void init()
	{
		spork ~ play();
	}

	fun void play()
	{
		while(true)
		{
			if(inFocus)
			{
				if(currentColumn == 0)
					drawColumn(numColumns - 1);
				else
					drawColumn(currentColumn - 1);
				drawColumn(currentColumn);
			}

			1 +=> currentColumn;
			if(currentColumn == numColumns)
				0 => currentColumn;

			stepDuration => now;
		}
	}

	fun void focus()
	{
		for(0 => int i; i < numColumns; i++)
			drawColumn(i);
		true => inFocus;
	}

	fun void drawColumn(int column)
	{
		<<< "Draw ", column >>>;
		for(0 => int i; i < numRows; i++)
		{
			if(notesQueued[column][i] != 0)
			{
				if(column == currentColumn)
					Press.fill(column, i, noteOnColor, press);
				else
					Press.fill(column, i, queueColor, press);
			}
			else
			{
				if(column == currentColumn)
					Press.fill(column, i, scrollColor, press);
				else
					Press.fill(column, i, 0, press);
			}
			press.signal();
			me.yield();
		}
	}
}
