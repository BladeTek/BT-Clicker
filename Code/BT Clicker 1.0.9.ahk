Menu, Tray, Icon, %A_ScriptDir%\icons\btc1icon.ico,, 1

Gui +OwnDialogs
Gui, Add, Tab2,, Start|Key Clicker|Mouse Clicker|Quick Clicker|Click Holder  ; Tab2 vs. Tab requires [v1.0.47.05+].
Gui, Add, Checkbox, vKeyboardC, Key Clicker
Gui, Add, Checkbox, vMouseC, Mouse Clicker
Gui, Add, Checkbox, vQC, Quick Clicker
Gui, Add, Checkbox, vCH, Click Holder
Gui, Add, Text,, Press to activate.
Gui, Add, Checkbox, vActionActivate gActivate, Active
Gui, Tab, 2
Gui, Add, Text,, Press key: (Enter shift if only using a function key.)
Gui, Add, Hotkey, vChosenKey
Gui, Add, Text,, Press function key: (Not used for key combinations)
Gui, Add, DropDownList, vXChosenKey, Shift|Ctrl|Alt|None
Gui, Add, Text,, Speed: (1000 = 1s)
Gui, Add, Slider, vKBdelay Range0-5000 ToolTip TickInterval1000, 2.5
Gui, Tab, 3
Gui, Add, Text,, Click button:
Gui, Add, DropDownList, vChosenMButton, Left Button|Right Button|Middle Button|X Button 1|X Button 2
Gui, Add, Text,, Speed: (1000 = 1s)
Gui, Add, Slider, vMSdelay Range0-5000 ToolTip TickInterval1000, 2.5
Gui, Tab, 4
Gui, Add, Text,, Hotkey:
Gui, Add, DropDownList, vChosenQCKey, Left Button|Right Button|Middle Button|X Button 1|X Button 2
Gui, Add, Text,, Speed: (1000 = 1s)
Gui, Add, Slider, vQCdelay Range0-5000 ToolTip TickInterval1000, 2.5
Gui, Add, Text,, Clicks:
Gui, Add, Slider, vQCtimes Range0-10 ToolTip TickInterval1000, 2.5
Gui, Tab, 5
Gui, Add, Radio, vHoldType, Keyboard
Gui, Add, Radio,, Mouse
Gui, Add, Text,, Press key: (Enter shift if only using a function key.)
Gui, Add, Hotkey, v1HoldButton
Gui, Add, Text,, Press function key: (Not used for key combinations)
Gui, Add, DropDownList, vX1HoldButton, Shift|Ctrl|Alt|None
Gui, Add, Text,, Hold Mouse button:
Gui, Add, DropDownList, v2HoldButton, Left Button|Right Button|Middle Button|X Button 1|X Button 2
Gui, Tab
Gui, Add, Button, Default xm, Exit
Gui, Show
return

Activate:
Gui, Submit, NoHide

If XChosenKey = "Shift"
  {
  KeyboardKey := "+"
  }
    else If XChosenKey = Ctrl
     {
     KeyboardKey := "^"
     }
    else If XChosenKey = Alt
     {
     KeyboardKey := "!"
     }
    else
     {
     KeyboardKey := XChosenKey
     }
	 
If ChosenMButton = Left Button
  {
  MouseButton := "LButton"
  }
    else If ChosenMButton = Right Button
      {
      MouseButton := "RButton"
      }
    else If ChosenMButton = Middle Button
      {
      MouseButton := "MButton"
      }
      else If ChosenMButton = X Button 1
      {
      MouseButton := "XButton1"
      }
      else If ChosenMButton = X Button 2
      {
      MouseButton := "XButton2"
      }

If ChosenQCKey = Left Button
  {
  QCHotkey := "LButton"
  }
    else If ChosenQCKey = Right Button
      {
      QCHotkey := "RButton"
      }
    else If ChosenQCKey = Middle Button
      {
      QCHotkey := "MButton"
      }
      else If ChosenQCKey = X Button 1
      {
      QCHotkey := "XButton1"
      }
      else If ChosenQCKey = X Button 2
      {
      QCHotkey := "XButton2"
      }
	  
If 2HoldButton = Left Button
  {
  MouseHoldButton := "LButton"
  }
    else If 2HoldButton = Right Button
      {
      MouseHoldButton := "RButton"
      }
    else If 2HoldButton = Middle Button
      {
      MouseHoldButton := "MButton"
      }
      else If 2HoldButton = X Button 1
      {
      MouseHoldButton := "XButton1"
      }
      else If 2HoldButton = X Button 2
      {
      MouseHoldButton := "XButton2"
      }

If X1HoldButton = None
  {
  KeyboardHoldKey = 1HoldButton
  }
  else
  {
  KeyboardHoldKey = X1HoldButton
  }
	  
If HoldType = Keyboard
  {
  HoldButton = KeyboardHoldKey
  }
  else
  {
  HoldButton = MouseHoldButton
  }

  Loop 
{
Gui, Submit, NoHide
  If ActionActivate = 0
    {
	break
	}
  If KeyboardC = 1
    {
    Sendinput, %ChosenKey%
    Sleep, %KBdelay%
    }
	
  If MouseC = 1
    {
    Sendinput, {%MouseButton%}
    Sleep, %MSdelay%
    }
	
  If QC = 1
    {
	GetKeyState, QCHotkeyState, %QCHotkey%
	If QCHotkeyState = D
	  {
	  Loop, %QCtimes%
	    {
        blockinput, on
	    MouseClick, Left
	    blockinput, off
		Sleep, %QCdelay%
        }
	  }
	}
  If CH = 1
    {
	Send, {%HoldButton%}
	}
}
return

ButtonExit:
ExitApp