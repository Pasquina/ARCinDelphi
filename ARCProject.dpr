program ARCProject;

uses
  Vcl.Forms,
  ARCForm in 'ARCForm.pas' {Form1},
  ARCObject in 'ARCObject.pas';

{$R *.res}

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
