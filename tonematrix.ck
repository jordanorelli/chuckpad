<<< "Defining ToneMatrix class." >>>;
public class ToneMatrix extends LPI
{
	quarter => dur stepDuration;
	0 => int currentColumn;
	float toneMap[8];
	int notesQueued[8][8];
	5 => int rowStep;

	<<< "ToneMatrix preconstructor start." >>>;
	calculateToneMap();
	<<< "ToneMatrix preconstructor end." >>>;

	fun void receive(MidiMsg m)
	{
		// <<< "ToneMatrix hears MidiMsg:\t", m.data1, "\t", m.data2, "\t", m.data3 >>>;
	}

	fun string getName()
	{
		return "ToneMatrix";
	}

	fun void focus()
	{
		true => inFocus;
		clearGrid();
		setColumn(currentColumn, 127);
	}

	fun void start()
	{
		<<< "ToneMatrix", me, "start." >>>;
		
		while(true)
		{
			step();
			stepDuration => now;
		}
	}

	fun void step()
	{
		if(inFocus)
			setColumn(currentColumn, 0);

		playColumn(currentColumn);
		if(currentColumn == 7)
			0 => currentColumn;
		else
			currentColumn++;

		if(inFocus)
			setColumn(currentColumn, 127);
	}

	fun void playColumn(int column)
	{
		if(column < 0 || column > 7)
		{
			<<< "ERROR: out of bounds in playColumn with input: ", column >>>;
			return;
		}
		for(0 => int i; i < notesQueued[column].size(); i++)
		{
		}
	}

	fun void playNote(float freq, dur duration)
	{
	}

	fun void calculateToneMap()
	{


	}


}
<<< "Done with ToneMatrix class definition." >>>;
