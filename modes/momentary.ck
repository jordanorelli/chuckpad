<<< "Start Momentary Mode definition." >>>;
public class Momentary extends Mode
{
	"Momentary" => name;
	fun void readPress(Press press)
	{
		reportReceive(press);
		reportSignal(press);
		press.signal();
	}
}
<<< "End Momentary Mode defintion." >>>;
