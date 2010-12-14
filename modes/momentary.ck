<<< "Start Momentary Mode definition." >>>;
public class Momentary extends Mode
{
	Colors.red => int color;

	"Momentary" => name;
	fun void readPress(Press p)
	{
		reportReceive(p);
		if(p.vel != 0)
			color => p.vel;
		reportSignal(p);
		p.signal();
	}
}
<<< "End Momentary Mode defintion." >>>;
