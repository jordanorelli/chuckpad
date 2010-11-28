<<< "Defining TouchPad class." >>>;
public class TouchPad extends LPI
{
	float toneMap[8][8];
	UGen @ out[8][8];
	0 => int waveformSelected;

	calculateToneMap();

	fun void setSemitonesPerOctave(int value)
	{
		if(value < 1)
		{
			<<< "ERROR: out of bounds in setSemitonesPerOctave with input: ", value >>>;
			return;
		}

		value => semitonesPerOctave;
		Math.pow(2, 1.0/value) => toneStep;
		calculateToneMap();
	}

	fun void setLowestFreq(int value)
	{
		value => lowestFreq;
		calculateToneMap();
	}

	fun void calculateToneMap()
	{
		for(0 => int row; row < toneMap.size(); row++)
			for(0 => int column; column < toneMap[0].size(); column++)
				lowestFreq * Math.pow(toneStep, toneMap.size() * row + column)
					=> toneMap[row][column];
	}

	fun void receive(MidiMsg m)
	{
		if(m.data1 != 144)
			return;
		else if (mToCol(m.data2) == 8) 
		{
		}
		else
		{
			setNote(mToRow(m.data2), mToCol(m.data2), m.data3);
			bounce(m);
		}
	}

	fun void setNote(int row, int column, int velocity)
	{
		if (row < 0 || row > 7 || column < 0 || column > 7)
		{
			<<< "ERROR: out of bounds in setNote with input row:", row, " column:", column >>>;
			return;
		}
		if(out[row][column] == null)
		{
			SinOsc o;
			toneMap[row][column] => o.freq;
			o => dac;
			o @=> out[row][column];
		}
		velocity / 127.0 => out[row][column].gain;
	}

	fun string getName()
	{
		return "TouchPad";
	}

	fun void bounce(MidiMsg m)
	{
		padOut.send(m);
	}
}
<<< "Done with TouchPad class definition." >>>;
