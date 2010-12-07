<<< "Start Momentary Mode definition." >>>;
public class Momentary extends Mode
{
	"Momentary" => name;
	fun void readPress(Press p)
	{
		reportReceive(p);
		reportSignal(p);
		p.signal();
	}
}
<<< "End Momentary Mode defintion." >>>;
