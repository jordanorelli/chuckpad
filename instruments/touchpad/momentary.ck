public class MomentaryTouchPad extends Momentary
{
	float toneMap[][];
	SinOsc @ out[8][8];
	ADSR adsr;
	0 => int notesOn;
	"tpMomentary" => name;
	10::ms => dur attack;
	800::ms => dur decay;
	0.5 => float sustain;
	500::ms => dur release;

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
		adsr.set(attack, decay, sustain, release);
	}

	fun void readPress(Press p)
	{
		reportReceive(p);
		if(p.vel != 0)
		{
			if(notesOn == 0)
			{
				adsr =< dac;
				adsr => dac;
				adsr.keyOn();
			}
				
			out[p.col][p.row] => adsr;
			1 +=> notesOn;
			<<< toneMap[p.col][p.row] >>>;
			color => p.vel;
		}
		else
		{
			1 -=> notesOn;
			if(notesOn == 0)
			{
				adsr.keyOff();
			}
			out[p.col][p.row] =< adsr;
		}
		reportSignal(p);
		p.signal();
	}

	fun void unfocus()
	{
		false => inFocus;
		for(0 => int i; i < 8; i++)
			for(0 => int j; j< 8; j++)
				out[i][j] =< adsr;
		me.yield();
	}
}
