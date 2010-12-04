<<< "Defining class LPI." >>>;
public class LPI
{
	string name;
	0.15::second => dur peekTime;
	0 => int prevSelected;
	0 => int selected;
	false => int optionMode;
	time peekStart;
	-1 => static int bpm;
	static dur whole;
	static dur half;
	static dur quarter;
	static dur eighth;

	-1 => int semitonesPerOctave;
	110.0 => float lowestFreq;
	false => int inFocus;
	float toneStep;
	MidiOut padOut;
	OptionEvent optionEvent;
	OptionPage @ options[8];
	int optionListeners[8];

	<<< "LPI base preconstructor start." >>>;
	"LPI_Base" => name;
	if(bpm == -1)
		setBpm(120);
	if(semitonesPerOctave == -1)
		setSemitonesPerOctave(12);
	for(0 => int i; i < 8; i++)
		new OptionPage @=> options[i];
	<<< "LPI base preconstructor end." >>>;

	fun void receive(MidiMsg m)
	{
		if(m.data1 != 144)
		{
			<<< "ERROR:  LPI received a Midi message it shouldn't have:", m.data1, m.data2, m.data3 >>>;
			return;
		}
		else if (mToCol(m.data2) == 8)
		{
			if(m.data3 == 127)
			{
				now => peekStart;
				setSelected(mToRow(m.data2));
			}
			else if(m.data3 == 0)
			{
				<<< "Button held for", now - peekStart >>>;
				if(now - peekStart > peekTime)
				{
					<<< "UnPeek!" >>>;
					if(optionMode)
						setSelected(prevSelected);
					else
					{
						options[selected].unfocus();
						focus();
					}
				}
				else
					true => optionMode;
			}
			else
				<<< "ERROR: dropex LPI Midi message:", me, m.data1, m.data2, m.data3 >>>;
		}
		else if(selected != -1 && !inFocus)
			options[selected].receive(m);
		else
		{
			<<< getName(), "hears MidiMsg:\t", m.data1, "\t", m.data2, "\t", m.data3, "\tRow:", mToRow(m.data2), "\tCol:", mToCol(m.data2) >>>;
			gridReceive(m);
		}
	}

	fun void gridReceive(MidiMsg m)
	{

	}

	fun void optionEventListener(OptionPage p, OptionEvent e)
	{
		<<< "I done sporked." >>>;
		while(p.inFocus)
		{
			<<< "Derp" >>>;
			1::second=>now;
			//e => now;
			//<<< e.Poop >>>;
		}
		<<< "It's over!" >>>;
	}

	fun string getName()
	{
		return name;
	}

	fun void start()
	{
		<<< getName(), me, "start." >>>;
	}

	fun void focus()
	{
		true => inFocus;
		clearGrid();
		if(optionMode)
			setOptionLight(selected);
	}

	fun void unfocus()
	{
		false => inFocus;
	}

	fun void clearGrid()
	{
		MidiMsg m;
		144 => m.data1;
		0 => m.data3;
		for(0 => int i; i < 64; i++)
		{
			numToM(i) => m.data2;
			padOut.send(m);
		}
	}

	fun void setSelected(int value)
	{
		if(value < -1 || value > 7)
		{
			<<< "ERROR: out of bounds in setSelected with input", value >>>;
			return;
		}

		if(options[value] == null)
		{
			<<< "ERROR: attempt to select null optionPage" >>>;
			return;
		}

		selected => prevSelected;
		if(value != selected)
		{
			value => selected;
			unfocus();
			options[value].focus();
			(spork ~ optionEventListener(options[value], optionEvent)).id()
				=> optionListeners[value];
			setOptionLight(value);
		}
		else
		{
			if(optionMode)
			{
				focus();
				options[selected].unfocus();
				Machine.remove(optionListeners[selected]);
				clearOptionLights();
				false => optionMode;
			}
		}
	}

	fun void setOptionLight(int optionIndex)
	{
		for(0 => int i; i < 8; i++)
			if(optionIndex == i)
				setSquare(i, 8, 127);
			else
				setSquare(i, 8, 0);
	}

	fun void clearOptionLights()
	{
		for(0 => int i; i < 8; i++)
			setSquare(i, 8, 0);
	}

	fun void setSquare(int row, int column, int velocity)
	{
		MidiMsg m;
		144 => m.data1;
		pairToM(row, column) => m.data2;
		velocity => m.data3;
		padOut.send(m);
	}

	fun void setColumn(int column, int velocity)
	{
		for(0 => int row; row < 8; row++)
			setSquare(row, column, velocity);
	}

	fun void setRow(int row, int velocity)
	{
		for(0 => int column; column < 8; column++)
			setSquare(row, column, velocity);
	}

	fun static void setBpm(int value)
	{
		if(value < 1)
		{
			<<< "ERROR: Attempt to lower tempo below 1 bpm.  Input: ", value >>>;
			return;
		}
		<<< "BPM", value >>>;
		value => bpm;
		4::minute / bpm @=> whole;
		whole / 2 @=> half;
		half / 2 @=> quarter;
		quarter / 2 @=> eighth;
	}

	fun static int numToM(int keyNum)
	{
		if(keyNum < 0 || keyNum > 63)
		{
			<<< "ERROR: out of bounds in numToM.  Input:", keyNum >>>;
			return -1;
		}
		return 16 * (7 - (keyNum / 8)) + keyNum % 8;
	}

	fun static int mToRow(int midiNum)
	{
		if(midiNum < 0 || midiNum > 120)
		{
			<<< "ERROR: out of bounds in mToRow.  Input:", midiNum >>>;
			return -1;
		}
		return 7 - (midiNum / 16);
	}

	fun static int mToCol(int midiNum)
	{
		if(midiNum < 0 || midiNum > 120)
		{
			<<< "ERROR: out of bounds in mToCol.  Input:", midiNum >>>;
			return -1;
		}
		return midiNum % 16;
	}

	fun static int pairToM(int row, int col)
	{
		if(row < 0 || row > 7 || col < 0 || col > 8)
		{
			<<< "ERROR: out of bounds in pairToM.  Input: row:", row, "col:", col >>>;
			return -1;
		}
		return 16 * (7 - row) + col;
	}

	fun void setSemitonesPerOctave(int value)
	{
		if(value < 1)
		{
			<<< "ERROR: out of bounds in setSemitonesPerOctave with input: ", value >>>;
			return;
		}
		Math.pow(2, 1.0/value) => toneStep;
		value => semitonesPerOctave;
	}
}
<<< "Done with LPI class definition." >>>;
