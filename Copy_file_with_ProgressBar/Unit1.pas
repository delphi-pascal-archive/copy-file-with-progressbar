// Programme de démonstration de la fonction CopyFileEx
//
// Par DelphiProg  delphiprog@fr.fm
//  et Nono40      nono40.fr.st
//
// 21/01/2003  : rédaction par Nono40
// 22/01/2003  : tests et améliorations par Delphiprog

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ProgressBar1: TProgressBar;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
  Edit1.Text := '';
  Edit2.Text := '';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Edit1.Text := OpenDialog1.FileName;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Edit2.Text := SaveDialog1.FileName;
end;

// Fonction "CallBack" appelée par CopyFileEx pour signaler l'avancement de la copie
function CopyCallBack(
  TotalFileSize: LARGE_INTEGER;          // Taille totale du fichier en octets
  TotalBytesTransferred: LARGE_INTEGER;  // Nombre d'octets déjàs transférés
  StreamSize: LARGE_INTEGER;             // Taille totale du flux en cours
  StreamBytesTransferred: LARGE_INTEGER; // Nombre d'octets déjà tranférés dans ce flus
  dwStreamNumber: DWord;                 // Numéro de flux actuem
  dwCallbackReason: DWord;               // Raison de l'appel de cette fonction
  hSourceFile: THandle;                  // handle du fichier source
  hDestinationFile: THandle;             // handle du fichier destination
  ProgressBar : TProgressBar             // paramètre passé à la fonction qui est une
                                         // recopie du paramètre passé à CopyFile Ex
                                         // Il sert à passer l'adresse du progress bar à
                                         // mettre à jour pour la copie. C'est une
                                         // excellente idée de DelphiProg
  ): DWord; far; stdcall;
var
  EnCours: Int64;
begin
  // Calcul de la position du progresbar en pourcent, le calcul doit être effectué dans
  // une variable intermédiaire de type Int64. Pour éviter les débordement de calcul
  // dans la propriété Position de type integer.
  EnCours := TotalBytesTransferred.QuadPart * 100 div TotalFileSize.QuadPart;
  If ProgressBar<>Nil Then ProgressBar.Position := EnCours;
  // La fonction doit définir si la copie peut être continuée.
  Result := PROGRESS_CONTINUE;
end;

procedure TForm1.Button1Click(Sender: TObject);
var Retour: LongBool;
begin
  if (Edit1.Text = '') or (Edit2.Text = '') or (Edit1.Text = Edit2.Text) then
    Exit;
  if FileExists(Edit2.Text) and
    (MessageDlg('Le fichier de destination existe, voulez-vous le remplacer ?',
    mtconfirmation, [mbYes, mbNo], 0) <> mrYes) then
    Exit;
  Retour := False;
  if not CopyFileEx(
    PChar(Edit1.Text),     // Nom du fichier d'origine
    PChar(Edit2.Text),     // Nom du fichier de destination
    @CopyCallBack,         // Adresse de la fonction appelée durant la copie
    ProgressBar1,          // Paramètre auxiliaire qui sert ici à définir le progress bar
                           // à mettre à jour [DelphiProg]
    @Retour,               // adresse d'une variable booléène que la fonction teste
                           // en permanence pour éventuellement stopper la copie
    COPY_FILE_RESTARTABLE) // Si la copie est stoppée, un nouvel appel avec les mêmes
                           // paramètres permet de la continuer
    then ShowMessage(IntToStr(GetLastError));
end;

end.
