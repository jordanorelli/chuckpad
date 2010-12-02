<<< "Defining TouchPad class." >>>;
public class TouchPad extends LPI
{
	32 => int loopFrames;
	int sculpture[loopFrames][8][8];
	0 => int currentFrame;
	int cellsDown[numRows][numCols];
	sixteenth @=> dur frameLength;
	8 => int rowStep;
	float toneMap[8][8];
	UGen @ out[8][8];
	0 => int waveformSelected;

	<<< "TouchPad preconstructor start." >>>;
	calculateToneMap();
	<<< "TouchPad preconstructor end." >>>;

	fun void start()
	{
		for(0 => int i; i < loopFrames; i++)
			for(0 => int j; j < numRows; j++)
				for(0 => int k; k < numCols; k++)
					0 => sculpture[i][j][k];

		<<< "TouchPad start!" >>>;
		while(true)
		{
			step();
			frameLength => now;
		}

	}

	fun void step()
	{
		if(inFocus)
			clearGrid();

		for(0 => int i; i < sculpture[0].size(); i++)
		{
			for(0 => int j; j < sculpture[0][0].size(); j++)
			{
				//if(sculpture[currentFrame][i][j] || notesDown[i][j])
				setNote(i, j, sculpture[currentFrame][i][j]);
				if(inFocus)
					setSquare(i, j, sculpture[currentFrame][i][j]);
			}
		}

		if(currentFrame < loopFrames - 1)
			currentFrame++;
		else
			0 => currentFrame;
		<<< "Currentframe:", currentFrame >>>;
	}

	fun void unFocus()
	{
		false => inFocus;
		for(0 => int i; i < out.size(); i++)
			for(0 => int j; j < out[0].size(); j++)
				if(out[i][j] != null)
					0 => out[i][j].gain;

		for(0 => int i; i < numRows; i++)
			for(0 => int j; j < numCols; j++)
				false => cellsDown[i][j];

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
				lowestFreq * Math.pow(toneStep, rowStep * row + column)
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
			m.data3 => cellsDown[mToRow(m.data2)][mToCol(m.data2)];
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
