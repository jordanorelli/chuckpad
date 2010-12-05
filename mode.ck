<<< "Start Mode definition." >>>;
public class Mode
{
	string name;
	false => int inFocus;

	<<< "Mode preconstructor start." >>>;
	"Mode_Base" => name;
	<<< "Mode preconstrcutor end." >>>;

	fun string getName()
	{
		return name;
	}

	fun void readPress(Press press)
	{
		reportReceive(press);
		reportSignal(press);
		press.signal();
	}

	fun void focus()
	{
		true => inFocus;
	}

	fun void unfocus()
	{
		false => inFocus;
	}

	fun void reportReceive(Press press)
	{
		<<< "receive\tmode\t", me, "\t", press.col, "\t", press.row, "\t", press.vel >>>;
	}

	fun void reportSignal(Press press)
	{
		<<< "signal\tmode\t", me, "\t", press.col, "\t", press.row, "\t", press.vel >>>;
	}
}
<<< "End Mode definition." >>>;
