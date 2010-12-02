<<< "Defining class LPI." >>>;
public class LPI
{
	-1 => static int bpm;
	static dur whole;
	static dur half;
	static dur quarter;
	static dur eighth;
	static dur sixteenth;
	static dur thirtySecond;
	static dur sixtyFourth;
	8 => static int numRows;
	8 => static int numCols;

	-1 => int semitonesPerOctave;
	110.0 => float lowestFreq;
	false => int inFocus;
	float toneStep;
	MidiOut padOut;

	<<< "LPI base preconstructor start." >>>;
	if(bpm == -1)
		setBpm(120);
	if(semitonesPerOctave == -1)
		setSemitonesPerOctave(12);
	<<< "LPI base preconstructor end." >>>;

	fun void receive(MidiMsg m)
	{
		<<< getName(), "hears MidiMsg:\t", m.data1, "\t", m.data2, "\t", m.data3, "\tRow:", mToRow(m.data2), "\tCol:", mToCol(m.data2) >>>;
	}

	fun string getName()
	{
		return "LPI_Base";
	}

	fun void start()
	{
		<<< getName(), me, "start." >>>;
	}

	fun void focus()
	{
		true => inFocus;
		clearGrid();
	}

	fun void unFocus()
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

	fun void setSquare(int row, int column, int velocity)
	{
		if(midiState[row][column] != velocity)
		{
			velocity => midiState[row][column];
			MidiMsg m;
			144 => m.data1;
			pairToM(row, column) => m.data2;
			velocity => m.data3;
			padOut.send(m);
		}
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
		eighth / 2 @=> sixteenth;
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
