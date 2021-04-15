program DelphiBird;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  Objects in 'Objects.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
