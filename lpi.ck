<<< "Defining class LPI." >>>;
public class LPI
{
	string name;
	0.15::second => dur peekTime;
	int prevSelected;
	-1 => int selected;
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
	OptionPage @ options[8];

	<<< "LPI base preconstructor start." >>>;
	"LPI_Base" => name;
	if(bpm == -1)
		setBpm(120);
	if(semitonesPerOctave == -1)
		setSemitonesPerOctave(12);
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
				selected => prevSelected;
				now => peekStart;
				setSelected(mToRow(m.data2));
			}
			else if(m.data3 == 0)
			{
				if(now - peekStart > peekTime)
					setSelected(prevSelected);
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
		setOptionLight();
	}

	fun void unFocus()
	{
		false => inFocus;
	}

	fun void setOptionLight()
	{
		for(0 => int i; i < 8; i++)
			if(selected == i)
				setSquare(i, 8, 127);
			else
				setSquare(i, 8, 0);
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
		// in retrospect, using -1 to indicate that there's no option page
		// selected was a fucking terrible idea.

		if(value >= 0 && value < options.size() && options[value] == null)
			return;

		if(selected != -1)
		{
			setSquare(selected, 8, 0);
			options[selected].unFocus();
		}

		if(value == selected || value == -1)
		{
			-1 => selected;
			focus();
			return;
		}

		if(value < -1 || value > options.size())
		{
			<<< "ERROR: out of bounds in setSelected with input", value >>>;
			return;
		}

		if(inFocus)
			unFocus();

		setSquare(value, 8, 127);
		selected => prevSelected;
		value => selected;
		options[value].focus();
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
