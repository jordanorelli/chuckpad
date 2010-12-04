<<< "Start GridMode definition." >>>;
public class GridMode
{
	string name;
	false => int inFocus;

	<<< "GridMode preconstructor start." >>>;
	"GridMode_Base" => name;
	<<< "GridMode preconstrcutor end." >>>;

	fun string getName()
	{
		return name;
	}

	fun void focus()
	{
		true => inFocus;
	}

	fun void unfocus()
	{
		false => inFocus;
	}
}
<<< "End GridMode definition." >>>;
