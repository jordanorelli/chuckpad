public class MomentaryTouchPad extends Momentary
{
	float toneMap[][];
	SinOsc @ out[8][8];
	"tpMomentary" => name;

	fun void init()
	{
		ToneMap.calculate(8, 8, 1, 8, 110.0, 12.0) @=> toneMap;
		for(0 => int i; i < 8; i++)
		{
			for(0 => int j; j < 8; j++)
			{
				SinOsc s;
				toneMap[i][j] => s.freq;
				s @=> out[i][j];
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
			<<< toneMap[p.col][p.row] >>>;
			color => p.vel;
		}
		else
		{
			out[p.col][p.row] =< dac;
		}
		reportSignal(p);
		p.signal();
	}

	fun void unfocus()
	{
		false => inFocus;
		for(0 => int i; i < 8; i++)
			for(0 => int j; j< 8; j++)
				out[i][j] =< dac;
		me.yield();
	}
}
