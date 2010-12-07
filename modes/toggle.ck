<<< "Start Toggle Mode definition." >>>;
public class Toggle extends Mode
{
	int gridState[8][8];

	"Toggle" => name;

	fun void focus()
	{
		for(0 => int i; i < 8; i++)
		{
			for(0 => int j; j < 8; j++)
			{
				i => press.col;
				j => press.row;
				gridState[i][j] => press.vel;
				press.signal();
				me.yield();
			}
		}
	}

	fun void readPress(Press p)
	{
		reportReceive(p);
		if(p.vel != 0)
		{
			if(gridState[p.col][p.row] == 0)
			{
				p.vel => gridState[p.col][p.row];
				reportSignal(p);
				p.signal();
			}
			else
			{
				0 => gridState[p.col][p.row];
				p.col => press.col;
				p.row => press.row;
				0 => press.vel;
				reportSignal(press);
				press.signal();
			}
		}
	}
}
