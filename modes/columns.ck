public class Columns extends Mode
{
	"columns" => name;
	int cols[8];

	fun void readPress(Press p)
	{
		if(p.vel > 0)
		{
			p.col => press.col;

			if(p.row > cols[p.col])
			{
				for(cols[p.col] => int i; i <= p.row; i++)
				{
					i => press.row;
					color => press.vel;
					press.signal();
					reportSignal(press);
					me.yield();
				}
			}
			else if (p.row < cols[p.col])
			{
				for(cols[p.col] => int i; i > p.row; i--)
				{
					i => press.row;
					0 => press.vel;
					press.signal();
					reportSignal(press);
					me.yield();
				}
			}
			p.row => cols[p.col];
		}
		reportReceive(p);
		<<< "", "" >>>;
	}
	
	fun void focus()
	{
		<<< "focus\tmode\t", getName() >>>;
		true => inFocus;
		draw();
	}

	fun void draw()
	{
		for(0 => int i; i < cols.size(); i++)
		{
			i => press.col;
			for(0 => int j; j < 8; j++)
			{
				j => press.row;
				if(cols[i] >= j)
					color => press.vel;
				else
					0 => press.vel;
				reportSignal(press);
				press.signal();
				me.yield();
			}
		}

	}
}
