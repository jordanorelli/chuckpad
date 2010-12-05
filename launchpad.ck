<<< "BEGIN\tLaunchpadController definition.", "" >>>;
public class LaunchpadController
{
    MidiOut padOut;
    int gridLights[8][8];
    int instrumentLights[8];
    int modeLights[8];

    127 => static int maxVelocity;

    <<< "BEGIN\tLaunchpadController preconstructor.", "" >>>;
    <<< "END\tLaunchpadController preconstructor.", "" >>>;

    fun void init(int midiChannel)
    {
        <<< "BEGIN\tLaunchpadController init", midiChannel >>>;
        if(!padOut.open(midiChannel))
        {
            <<< "ERROR: couldn't open channel", midiChannel, "for MIDI out." >>>;
            me.exit();
        }
        Utils.setArray(gridLights, -1);
        Utils.setArray(instrumentLights, -1);
        Utils.setArray(modeLights, -1);
        2::second => now;
        clearGridLights(gridLights, padOut);
        clearInstrumentLights(instrumentLights, padOut);
        clearModeLights(modeLights, padOut);
        <<< "END\tLaunchpadController init", midiChannel >>>;
    }

    fun void listen(ButtonPress m)
    {
        <<< "LaunchpadController listening..." >>>;
        while(true)
        {
            m => now;
            <<< "receive\tlpc\t", me, "\t", m.row, "\t", m.col, "\t", m.vel >>>;
            if(m.row == 8)
                setInstrumentLight(m.vel, m.col, instrumentLights, padOut);
            else if(m.col == 8)
                setModeLight(m.vel, m.row, modeLights, padOut);
            else
                setGridLight(m.col, m.row, m.vel, gridLights, padOut);
        }
    }

    /*--------------------------------------------------------------------------
    -
    -                               Private!
    -
    --------------------------------------------------------------------------*/

    fun void clearGridLights(int grid[][], MidiOut gridOut)
    {
        <<< "------------------------------------------------------------\n", "" >>>;
        <<< "                      <clearGridLights>                     \n", "" >>>;
        <<< "------------------------------------------------------------\n", "" >>>;
        for(0 => int col; col < grid.size(); col++)
            for(0 => int row; row < grid[0].size(); row++)
                setGridLight(col, row, 0, grid, MidiOut gridOut);
        <<< "------------------------------------------------------------\n", "" >>>;
        <<< "                     </clearGridLights>                     \n", "" >>>;
        <<< "------------------------------------------------------------\n", "" >>>;
    }

    fun void setGridLight(int col, int row, int vel, int grid[][], MidiOut gridOut)
    {
        if(col < 0 || col > grid.size() || row < 0 || row > grid[0].size()
            || vel > maxVelocity)
        {
            <<< "OOB\tsetGrid", "\t", col, "\t", row, "\t", vel, "\t", grid >>>;
            return;
        }

        if(grid[col][row] != vel)
        {
            MidiMsg m;
            144 => m.data1;
            pairToM(col, row) => m.data2;
            vel => m.data3;
            gridOut.send(m);
            <<< "send\tgrid\t", gridOut, "\t", m.data1, "\t", m.data2, "\t", m.data3, "\n" >>>;
            vel => grid[col][row];
        }
        else
            <<< "ignore\tlpc\t", me, "\t", col, "\t", row, "\t", vel, "\t", grid, "\n" >>>;
    }

    fun void clearInstrumentLights(int lights[], MidiOut instrumentsOut)
    {
        for(0 => int i; i < lights.size(); i++)
            setInstrumentLight(0, i, lights, instrumentsOut);
    }

    fun void clearModeLights(int lights[], MidiOut modesOut)
    {
        for(0 => int i; i < lights.size(); i++)
            setModeLight(0, i, lights, modesOut);
    }

    fun void setInstrumentLight(int vel, int index, int lights[], MidiOut instrumentOut)
    {
        if(index < 0 || index > lights.size())
        {
            <<< "OOB\tsetInstrumentLights\t", vel, "\t", index, "\t", lights >>>;
            return;
        }
        MidiMsg m;
        176 => m.data1;
        104 + index => m.data2;
        vel => m.data3;
        <<< "send\tpad\t", instrumentOut, "\t", m.data1, "\t", m.data2, "\t", m.data3, "\n" >>>;
        instrumentOut.send(m);
    }

    fun void setModeLight(int vel, int index, int lights[], MidiOut modesOut)
    {
        if(index < 0 || index > lights.size())
        {
            <<< "OOB\tsetModeLight\t", vel, "\t", index, "\t", lights >>>;
            return;
        }
        MidiMsg m;
        144 => m.data1;
        index * 16 + 8 => m.data2;
        vel => m.data3;
        <<< "send\tpad\t", modesOut, "\t", m.data1, "\t", m.data2, "\t", m.data3, "\n" >>>;
        modesOut.send(m);
    }

    fun static int pairToM(int col, int row)
    {
        if(row < 0 || row > 8 || col < 0 || col > 8 || (col == 8 && row == 8))
        {
            <<< "ERROR\tout of bounds in pairToM.  Input: row:", row, "col:", col >>>;
            return -1;
        }
        if(row == 8)
            return 16 * row + col;
        else
            return 16 * (7 - row) + col;
    }

    fun static int mToCol(int midiNum)
    {
        if(midiNum < 0 || midiNum > 120)
        {
            <<< "ERROR\tout of bounds in mToCol.  Input:", midiNum >>>;
            return -1;
        }
        return midiNum % 16;
    }

    fun static int mToRow(int midiNum)
    {
        if(midiNum < 0 || midiNum > 120)
        {
            <<< "ERROR\tout of bounds in mToRow.  Input:", midiNum >>>;
            return -1;
        }
        return 7 - (midiNum / 16);
    }
}
<<< "END\tLaunchpadController definition.", "" >>>;
