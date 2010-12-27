public class WubWubMain extends Mode
{
	float toneStep;
	float toneMap[4][8];
	4 => int rowStep;
	110 => int bpm;
	55 => float lowestFreq;
	UGen @ out[4][8];
	ADSR adsr[4][8];

	SinOsc wobbleOsc;
	//ADSR adsr;
	Gain mrGain;
	FullRect rect;
	"wwMain" => name;

	fun void init()
	{
		calculateToneStep(12) => toneStep;
		calculateToneMap();
		0 => wobbleOsc.freq;
		1 => wobbleOsc.gain;
		0.5 => mrGain.gain;
		wobbleOsc => rect => blackhole;

		for(0 => int i; i < 4; i++)
		{
			for(0 => int j; j < 8; j++)
			{
				SinOsc s;
				toneMap[i][j] => s.freq;
				1 => s.gain;
				s @=> out[i][j];

				adsr[i][j].set(80::ms, 8::ms, .8, 50::ms);
				out[i][j] => adsr[i][j];
				me.yield();
			}
		}


		mrGain => dac;
		spork ~ wobble();
		me.yield();
	}

	fun void wobble()
	{
		while(true)
		{
			1::samp => now;
			1 - Math.max(0.05, rect.last()) => mrGain.gain;
		}
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

	fun void unfocus()
	{
		false => inFocus;
		for(0 => int i; i < 4; i++)
			for(0 => int j; j< 8; j++)
				out[i][j] =< dac;
		me.yield();
	}

	fun void readPress(Press p)
	{
		reportReceive(p);
		if(p.vel != 0)
		{
			if(p.col < 4)
			{
				adsr[p.col][p.row].keyOn();
				adsr[p.col][p.row] =< mrGain;
				adsr[p.col][p.row] => mrGain;

				<<< toneMap[p.col][p.row] >>>;
				color => p.vel;
			}
			else if (p.row == 0)
			{
				Math.pow(2, p.col - 4) => wobbleOsc.freq;
			}
		}
		else
		{
			if(p.col < 4)
			{
				adsr[p.col][p.row].keyOff();
			}
			else
			{
				0 => wobbleOsc.freq;
				0 => wobbleOsc.phase;
				0.5 => mrGain.gain;
			}
		}
		reportSignal(p);
		p.signal();
	}
}
