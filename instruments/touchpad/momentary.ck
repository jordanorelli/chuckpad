public class MomentaryTouchPad extends Momentary
{
	float toneStep;
	float toneMap[8][8];
	8 => int rowStep;
	110.0 => float lowestFreq;
	//0 => int waveformSelected;
	SinOsc @ out[8][8];
	"tpMomentary" => name;

	fun void init()
	{
		0.4::second => now;
		calculateToneStep(12) => toneStep;
		calculateToneMap();
		for(0 => int i; i < 8; i++)
		{
			for(0 => int j; j < 8; j++)
			{
				SinOsc s;
				toneMap[i][j] => s.freq;
				//s => dac;
				s @=> out[i][j];
				//out[i][j] => dac;
				0.4 => s.gain;
			}
		}
	}

	fun void readPress(Press p)
	{
		reportReceive(p);
		if(p.vel != 0)
		{
			out[p.col][p.row] => dac;
			//0.6 => out[p.col][p.row].gain;
			<<< toneMap[p.col][p.row] >>>;
			color => p.vel;
		}
		else
		{
			out[p.col][p.row] =< dac;
			//0 => out[p.col][p.row].gain;
		}
		reportSignal(p);
		p.signal();
	}

	fun float calculateToneStep(int tonesPerOctave)
	{
		return Math.pow(2, 1.0 / tonesPerOctave);
	}

	fun void calculateToneMap()
	{
		for(0 => int row; row < toneMap.size(); row++)
			for(0 => int column; column < toneMap[0].size(); column++)
				lowestFreq * Math.pow(toneStep, rowStep * row + column)
					=> toneMap[row][column];
	}

// 	fun void focus()
// 	{
// 		<<< "focus\tmode\t", getName() >>>;
// 		true => inFocus;
// 		clearGrid();
// 	}
// 
	fun void unfocus()
	{
		false => inFocus;
		for(0 => int i; i < 8; i++)
			for(0 => int j; j< 8; j++)
				out[i][j] =< dac;
		me.yield();
	}
// 
// 	fun void reportReceive(Press press)
// 	{
// 		<<< "receive\tmode\t", getName(), "\t", press.col, "\t", press.row, "\t", press.vel >>>;
// 	}
// 
// 	fun void reportSignal(Press press)
// 	{
// 		<<< "signal\tmode\t", getName(), "\t", press.col, "\t", press.row, "\t", press.vel >>>;
// 	}


}
