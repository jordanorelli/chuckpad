<<< "Start Mode definition." >>>;
public class Mode
{
	string name;
	int color;

	false => int inFocus;
	Press press;

	"base" => name;
	Colors.red => color;

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
		clearGrid();
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

	fun void clearGrid()
	{
		for(0 => int i; i < 8; i++)
		{
			for(0 => int j; j < 8; j++)
			{
				i => press.col;
				j => press.row;
				0 => press.vel;
				reportSignal(press);
				press.signal();
				me.yield();
			}
		}
	}
}
<<< "End Mode definition." >>>;
