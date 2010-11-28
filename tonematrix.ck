<<< "Defining ToneMatrix class." >>>;
public class ToneMatrix extends LPI
{
	quarter => dur stepDuration;
	0 => int currentColumn;

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

		if(currentColumn == 7)
			0 => currentColumn;
		else
			currentColumn++;

		if(inFocus)
			setColumn(currentColumn, 127);
	}

}
<<< "Done with ToneMatrix class definition." >>>;
