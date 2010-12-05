<<< "Start Mode definition." >>>;
public class Mode
{
	string name;
	false => int inFocus;

	"base" => name;

	fun string getName()
	{
		return name;
	}

	fun void readPress(Press press)
	{
		reportReceive(press);
		<<< "", "" >>>;
	}

	fun void focus()
	{
		<<< "focus\tmode\t", getName() >>>;
		true => inFocus;
	}

	fun void unfocus()
	{
		false => inFocus;
	}

	fun void reportReceive(Press press)
	{
		<<< "receive\tmode\t", getName(), "\t", press.col, "\t", press.row, "\t", press.vel >>>;
	}

	fun void reportSignal(Press press)
	{
		<<< "signal\tmode\t", getName(), "\t", press.col, "\t", press.row, "\t", press.vel >>>;
	}
}
<<< "End Mode definition." >>>;
