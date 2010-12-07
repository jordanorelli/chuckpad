<<< "Defining ToneMatrix class." >>>;
public class ToneMatrix extends Instrument
{
	"tonematrix";
	// eighth @=> dur stepDuration;
	// 0 => int currentColumn;
	// float toneMap[8];
	// int notesQueued[8][8];
	// 8 => int rowStep;

	// 42 => int cursorColor;
	// 87 => int noteOnColor;
	// 112 => int noteQueuedColor;

	// <<< "ToneMatrix preconstructor start." >>>;
	// "ToneMatrix" => name;
	// calculateToneMap(lowestFreq, toneStep, rowStep, toneMap.size()) @=> toneMap;
	// <<< "ToneMatrix preconstructor end." >>>;

	// fun void gridReceive(MidiMsg m)
	// {
	// 	if(m.data1 != 144)
	// 		return;
	// 	else if (mToCol(m.data2) == 8)
	// 	{
	// 		// TODO: add ToneMatrix option triggers here
	// 	}
	// 	else if (m.data3 ==127)
	// 	{
	// 		toggleNoteQueue(mToRow(m.data2), mToCol(m.data2), notesQueued);
	// 	}
	// 	else
	// 	{
	// 		// these are button unpresses.  So far meaningless.
	// 	}
	// }

	// fun void focus()
	// {
	// 	true => inFocus;
	// 	//clearGrid();
	// 	setOptionLight();
	// 	for(0 => int i; i < 8; i++)
	// 		drawColumn(i);
	// }

	// fun void start()
	// {
	// 	<<< "ToneMatrix", me, "start." >>>;
	// 	
	// 	while(true)
	// 	{
	// 		step();
	// 		eighth => now;
	// 	}
	// }

	// fun void step()
	// {
	// 	if(currentColumn == 7)
	// 		0 => currentColumn;
	// 	else
	// 		currentColumn++;

	// 	if(inFocus)
	// 	{
	// 		if(currentColumn == 0)
	// 			drawColumn(7);
	// 		else
	// 			drawColumn(currentColumn - 1);
	// 	}

	// 	playColumn(currentColumn);
	// 	if(inFocus)
	// 		drawColumn(currentColumn);
	// }

	// fun void drawColumn(int column)
	// {
	// 	for(0 => int i; i < notesQueued.size(); i++)
	// 	{
	// 		if(notesQueued[i][column] != 0)
	// 		{
	// 			if(column == currentColumn)
	// 				setSquare(i, column, noteOnColor);
	// 			else
	// 				setSquare(i, column, noteQueuedColor);
	// 		}
	// 		else
	// 		{
	// 			if(column == currentColumn)
	// 				setSquare(i, column, cursorColor);
	// 			else
	// 				setSquare(i, column, 0);
	// 		}
	// 	}
	// }
	// 
	// fun void playColumn(int column)
	// {
	// 	if(column < 0 || column > 7)
	// 	{
	// 		<<< "ERROR: out of bounds in playColumn with input: ", column >>>;
	// 		return;
	// 	}
	// 	for(0 => int i; i < notesQueued[column].size(); i++)
	// 	{
	// 		if(notesQueued[i][column] != 0)
	// 			spork ~ playNote(toneMap[i], stepDuration);
	// 	}
	// }

	// fun void toggleNoteQueue(int row, int col, int queueMap[][])
	// {
	// 	if(row < 0 || row >= queueMap.size() || col < 0 || col >= queueMap[0].size())
	// 	{
	// 		<<< "ERROR: out of bounds in toggleNoteQueue with inputs: ", row, col >>>;
	// 		return;
	// 	}
	// 	if(queueMap[row][col] == 0)
	// 	{
	// 		127 => queueMap[row][col];
	// 		setSquare(row, col, noteQueuedColor);
	// 	}
	// 	else
	// 	{
	// 		0 => queueMap[row][col];
	// 		setSquare(row, col, 0);
	// 	}
	// }

	// fun void playNote(float freq, dur duration)
	// {
	// 	SinOsc s => dac;
	// 	freq => s.freq;
	// 	0.6 => s.gain;
	// 	duration => now;
	// 	0 => s.gain;
	// }

	// fun float[] calculateToneMap(float baseFrequency, float toneStep, int rowStep, int numSteps)
	// {
	// 	float tones[numSteps];
	// 	baseFrequency => tones[0];
	// 	if(numSteps < 2)
	// 	{
	// 		<<< "ERROR: numSteps out of bounds in calculateToneMap with input:", numSteps >>>;
	// 		return tones;
	// 	}
	// 	for(1 => int i; i < numSteps; i++)
	// 		tones[i-1] * Math.pow(toneStep, rowStep) => tones[i];
	// 	return tones;
	// }
}
<<< "Done with ToneMatrix class definition." >>>;
