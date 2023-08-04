B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.2
@EndOfDesignText@
#Event: Click
#If B4A Or B4I
#Event: LongClick
#End If

Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView
	Private xpnlBase As B4XView
	Private xui As XUI 'ignore
	Public Tag As Object
	Private mEnabled As Boolean = True
	Private xlbl_main As B4XView
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
End Sub

'Base type must be Object
Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	#If B4I
	Lbl.UserInteractionEnabled = False
	#End If
	xpnlBase = xui.CreatePanel("base")
	xpnlBase.Color = xui.Color_Transparent
	xlbl_main = Lbl
	mBase.AddView(xpnlBase,0,0,0,0)
	mBase.AddView(xlbl_main,0,0,0,0)
    Tag = mBase.Tag
    mBase.Tag = Me 

	#If B4A
	Base_Resize(mBase.Width,mBase.Height)
	#End If
	
End Sub

Public Sub Base_Resize (Width As Double, Height As Double) 
	xpnlBase.SetLayoutAnimated(0,0,0,Width,Height)
	xlbl_main.SetLayoutAnimated(0,0,0,Width,Height)
End Sub
'gets the native label
Public Sub getLabel As Label
	Return xlbl_main
End Sub
'gets the native label as B4XView
Public Sub getxLabel As B4XView
	Return xlbl_main
End Sub

#If B4J
Private Sub base_MouseClicked (EventData As MouseEvent)
	Click
End Sub
#Else
Private Sub base_Click
	Click
End Sub

Private Sub base_LongClick
	LongClick
End Sub
#End If

'Disabled or Enabled the label click events
Public Sub setEnabled(Enabled As Boolean)
	mEnabled = Enabled
End Sub

Public Sub getEnabled As Boolean
	Return mEnabled
End Sub

'Private Sub base_Touch(Action As Int, X As Float, Y As Float)
'	
'End Sub

#Region Events

Private Sub Click
	If mEnabled = False Then Return
	If xui.SubExists(mCallBack, mEventName & "_Click", 0) Then
		CallSub(mCallBack, mEventName & "_Click")
	End If
End Sub

Private Sub LongClick
	If mEnabled = False Then Return
	If xui.SubExists(mCallBack, mEventName & "_LongClick", 0) Then
		CallSub(mCallBack, mEventName & "_LongClick")
	End If
End Sub

#End Region