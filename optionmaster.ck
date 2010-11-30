<<< "Defining class optionMaster." >>>;
public class OptionMaster extends LPI
{
	false => int tempoUp;
	false => int tempoDown;

	fun void focus()
	{
		true => inFocus;
		clearGrid();
		setSquare(7,0,127);
		setSquare(7,1,127);
	}

	fun string getName()
	{
		return "OptionMaster";
	}

	fun void receive(MidiMsg m)
	{
		if(mToRow(m.data2) == 7)
		{
			if(mToCol(m.data2) == 0)
			{
				if(m.data3 == 127)
				{
					true => tempoUp;
					spork ~ increaseTempo();
				}
				else
					false => tempoUp;
			}
			else if(mToCol(m.data2) == 1)
			{
				if(m.data3 == 127)
				{
					true => tempoDown;
					spork ~ decreaseTempo();
				}
				else
					false => tempoDown;
			}
		}
	}

	fun void increaseTempo()
	{
		100::ms => dur tempoDelta;
		while(tempoUp)
		{
			setBpm(bpm + 1);
			tempoDelta => now;
			if(tempoDelta > 10::ms)
				1::ms -=> tempoDelta;
		}
	}

	fun void decreaseTempo()
	{
		100::ms => dur tempoDelta;
		while(tempoDown)
		{
			setBpm(bpm - 1);
			tempoDelta => now;
			if(tempoDelta > 10::ms)
				1::ms -=> tempoDelta;
		}
	}
}
<<< "Finished with optionMaster definition." >>>;
