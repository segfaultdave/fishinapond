/**
 * initializes all objects related to rwmidi
 */
void rwmidiInit()
{
  println("Midi device list:");			
  println(RWMidi.getInputDeviceNames());
  input = RWMidi.getInputDevices()[0].createInput(this);
  output = RWMidi.getOutputDevices()[0].createOutput();
  println("Input: " + input.getName());
  println("Output: " + output.getName());
}

/**
 * user plays a note, we record it
 */
void noteOnReceived(Note note) {

  if(phase == 4)  // plays the piano
  {
    notePlayed = note.getPitch();
    int n = 0;
    switch(notePlayed){
        case 65:
            n = 1;
            break;
        case 67:
            n = 2;
            break;
        case 69:
            n = 3;
            break;
        case 71:
            n = 4;
            break;
        case 72:
            n = 5;
            break;
        case 74:
            n = 6;
            break;
        case 76:
            n = 7;
            break;
        default:
            break;
    }
    userPlaysNote(n);
  }
  //println("Note on: " + note.getPitch() + ", velocity: " + note.getVelocity());
}

void noteOffReceived(Note note) {
  println("Note off: " + note.getPitch());
}

void controllerChangeReceived(Controller controller) {
  println("CC: " + controller.getCC() + ", value: " + controller.getValue());
}