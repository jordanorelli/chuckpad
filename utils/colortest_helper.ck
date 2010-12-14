LPDriver device;
device.init(0);
Press p;
spork ~ device.listen(p);

1 => int count;
1::second => now;

/*
for(0 => int i; i < 8; i++)
{
	for(0 => int j; j < 8; j++)
	{
		i => p.col;
		j => p.row;
		count => p.vel;
		p.signal();
		me.yield();
		2 +=> count;
	}
}
*/


[Colors.lightRed, Colors.red, Colors.lightOrange, Colors.orange,
Colors.lightYellow, Colors.yellow, Colors.lightGreen, Colors.green] @=> int color[];

0 => int offset;
<<< "mmmmmmmmmmmm" >>>;
while(true)
{
	<<< "Doop" >>>;
	for(0 => int i; i < 8; i++)
	{
		for(0 => int j; j < 8; j++)
		{
			i => p.col;
			j => p.row;
			color[i] => p.vel;
			//color[j + offset] => p.vel;
			p.signal();
			me.yield();
		}
	}
	0.4::second => now;
	1 +=> offset;
	if (offset == 8)
		0 => offset;
	break;
}



while(true)
{
	10::second => now;
}
