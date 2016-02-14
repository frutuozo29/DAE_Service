{$D+}
unit cTdi;

{ *********************************************************************** }
{ Classe TTDI                                                             }
{   Encapsula todo o código necessário para utilizar a interface TDI      }
{                                                                         }
{ Principais métodos                                                      }
{   MostrarFormulario(Classe: TComponentClass; Multi: Boolean);           }
{   Fechar(Todas: Boolean);                                               }
{ Veja mais informações sobre estes métodos em seu escopo.                }
{                                                                         }
{ Propriedades                                                            }
{   FormPadrao: TFormClass;                                               }
{    Este é o formulário que será aberto sempre que todas as abas         }
{    forem fechadas.                                                      }
{                                                                         }
{   MostrarMenuPopup: Boolean;                                            }
{    Nesta propriedade você pode definir se o menu popup com as opções    }
{    'Fechar' e 'Fechar todas' será exibido.                              }
{                                                                         }
{   PageControl: TcxPageControl;                                            }
{    Esta é uma propriedade somente leitura que dá acesso ao TPageControl }
{    onde as abas (TTabSheets) estão sendo exibidas.                      }
{                                                                         }
{                                                                         }
{ *********************************************************************** }

interface

uses ComCtrls, Forms, Messages, Controls, Classes, Menus, Windows, Dialogs,  DBClient;


const         
  WM_CLOSE_TAB = WM_USER + 1;

type
  TTDI = class(TWinControl)
  private
    FPageControl: TPageControl;
    FFormPadrao: TFormClass;
    FPopup: TPopupMenu;
    FCaption : String;
    FParam : String;

    procedure SetMostrarMenuPopup(const Value: Boolean);
    procedure SetFormPadrao(const Value: TFormClass);
    function GetFormPadrao: TFormClass;
    function GetMostrarMenuPopup: Boolean;
    function GetPageControl: TPageControl;

    procedure OnTabHide(Sender: TObject);
    procedure MenuFechar(Sender: TObject);
    procedure MenuFecharTodas(Sender: TObject);
    procedure CriarFormulario(Classe: TFormClass; Primeiro: Boolean = false);
    procedure CriarPageControl;
    procedure OnWm_Close_Tav(var Msg: TMessage); message WM_CLOSE_TAB;

    function NovaAba: TTabSheet;
    function Pagina(aClasseForm: TFormClass): TTabSheet;
    function Formulario(Pagina: Integer): TForm;
    procedure PageChange(Sender: TObject);
    procedure FormShow(Sender: TObject); virtual;
  public
    ppForm : TForm;
    constructor Create(AOwner: TWinControl; aFormPadrao: TFormClass);
    destructor Destroy; override;
    procedure MostrarFormulario(Classe: TFormClass; Multi: Boolean; Primeiro:Boolean = false; pCaption : String = ''; pParam : String = '');
    procedure MostrarFormulario1(Classe: TFormClass; Multi: Boolean; Primeiro:Boolean = false; pCaption : String = ''; pMargemEsquerda : Integer = -1; pMargemDireita : Integer = -1);

    procedure Fechar(Todas: Boolean; pIndex:integer = 0);
  published
    property MostrarMenuPopup: Boolean read GetMostrarMenuPopup write SetMostrarMenuPopup;
    property PageControl: TPageControl read GetPageControl;

    {FormPadrao é classe do formulario que sempre sera aberto quando todos os
     outros forms estão fechados}
    property FormPadrao: TFormClass read GetFormPadrao write SetFormPadrao;
  end;

implementation

uses Math, SysUtils;

const
  INDEX_FORM = 00;//o primeiro componente da pagina eh sempre o formulario

{ TTDI }

procedure TTDI.MostrarFormulario1(Classe: TFormClass; Multi: Boolean; Primeiro:Boolean = false; pCaption : String = ''; pMargemEsquerda : Integer = -1; pMargemDireita : Integer = -1);
begin
  if not Multi then//se nao pode criar mais de uma instacia da classe
  begin
    PageControl.ActivePage := Pagina(Classe);

    if PageControl.ActivePage <> nil then//se encontrou uma instacia da classe
      Exit;//sai pq nao pode criar outra
  end;
  FCaption := pCaption;
  FParam := '0';
  CriarFormulario(Classe ,Primeiro);
  PageControl.Visible := PageControl.PageCount > 0;
end;

procedure TTDI.MostrarFormulario(Classe: TFormClass; Multi: Boolean; Primeiro:Boolean = false; pCaption : String = ''; pParam : String = '');
begin
  if not Multi then//se nao pode criar mais de uma instacia da classe
  begin
    PageControl.ActivePage := Pagina(Classe);

    if PageControl.ActivePage <> nil then//se encontrou uma instacia da classe
      Exit;//sai pq nao pode criar outra
  end;
  FCaption := pCaption;
  FParam := '0';
  if pParam <> '' then
    FParam := pParam;
  CriarFormulario(Classe ,Primeiro);
  PageControl.Visible := PageControl.PageCount > 0;
end;



constructor TTDI.Create(AOwner: TWinControl; aFormPadrao: TFormClass);
begin
  inherited Create(AOwner);

  Parent       := AOwner;
  ParentWindow := AOwner.Handle;

  if aFormPadrao <> nil then
    FFormPadrao := aFormPadrao;

  CriarPageControl;

  if FFormPadrao <> nil then
    MostrarFormulario(FFormPadrao, True);

end;

function TTDI.NovaAba: TTabSheet;
{adiciona uma nova aba ao PageControl e retorna a nova aba como resultado}

    {Alem de criar um novo TabSheet a funcao NovaAba ativa a TabSheet criada,
     assim apos executar NovaAba, a propriedade ActivePage sempre será a
     ultima TabSheet criada}
var
  vTab: TTabSheet;
begin
  vTab := TTabSheet.Create(PageControl);

  vTab.PageControl := PageControl;
  vTab.TabVisible  := True;
  vTab.Caption     := 'Carregando...';
  vTab.OnHide      := OnTabHide;
  vTab.PopupMenu := nil;

  PageControl.ActivePageIndex := vTab.PageIndex;

  Result := vTab;
end;

procedure TTDI.PageChange(Sender: TObject);
begin

end;

function TTDI.Pagina(aClasseForm: TFormClass): TTabSheet;
{procura por um formulario passado no parametro Classe e retorna
 o TTabSheet onde este formulario se encontra.}
var
  vC: Integer;
begin
{ TODO : FAZER VOLTAR PARA PRIMEIRA INSTACIA QUANDO EXISTE MAIS DE UMA E A ULTIMA JA ESTA ATIVA }

  Result := nil;//se nao econtrar retorna nil

  vC := 0;//inicia variavel

  {verifica se a pagina ativa tem uma instacia da classe em questao,
   se tiver, define vC igual a posicao da pagina ativa para comecar
   a procurar dali para frente. Se nao fizermos isso as abas ficaram
   alternando entre a primeira e a segunda instancia sem nunca passar
   para a terceira instacia, caso ela exista.}
  if PageControl.ActivePage <> nil then//se tiver uma pagina ativa
    if Formulario(PageControl.ActivePageIndex) is aClasseForm then
      vC := PageControl.ActivePageIndex;

  //loop por todas as paginas
  for vC := vC to PageControl.PageCount - 1 do
    if Formulario(vC) is aClasseForm then
    begin
      Result := PageControl.Pages[vC];

      {se a pagina encontrada ja estiver ativa}
      if not (PageControl.ActivePage = Result) then
      begin
        {sai do loop apenas se a pagina nao estiver ativa, pq se a pagina
         ja estiver ativa nos vamos procurar por outra instancia desta classe.
         Isso fara com que caso exista mais de uma instacia criada, cada chamada
         desta funcao o resultado não seja a ultima instacia encontrada}
        Break;
      end;
    end;
end;

procedure TTDI.SetFormPadrao(const Value: TFormClass);
begin
  if FFormPadrao <> Value then
  begin
    MostrarFormulario(Value, False);
    FFormPadrao := Value;
  end;
end;

function TTDI.GetFormPadrao: TFormClass;
begin
  Result := FFormPadrao;
end;

procedure TTDI.SetMostrarMenuPopup(const Value: Boolean);

  function Add_Fechar: TMenuItem;
  begin
    FPopup.Items.Add(TMenuItem.Create(FPopup));

    with FPopup.Items[0] do
    begin
      ParentWindow := PageControl.Handle;;
      OnClick := MenuFechar;
      ShortCut := 16499;//CTRL + F4
      Caption := 'Fechar janela';
    end;
  end;

  function Add_FecharTodas: TMenuItem;
  begin
    FPopup.Items.Add(TMenuItem.Create(FPopup));

    with FPopup.Items[0] do
    begin
      ParentWindow := PageControl.Handle;;
      OnClick := MenuFecharTodas;
      Caption := 'Fechar todas as janelas';
    end;
  end;

begin
  if Value then
  begin
    if not Assigned(FPopup) then
    begin
      FPopup := TPopupMenu.Create(PageControl);
      FPopup.Name := 'pop';

      //Add_Fechar;
      Add_FecharTodas;
      
    end;

    PageControl.PopupMenu := FPopup;
  end
  else
    PageControl.PopupMenu := nil
end;

function TTDI.GetMostrarMenuPopup: Boolean;
begin
  Result := Assigned(PageControl.PopupMenu);
end;

procedure TTDI.Fechar(Todas: Boolean;PIndex:Integer=0);
var
  vC: Integer;
begin
  case Todas of
    True: begin
            for vC := PageControl.PageCount - 1 downto 0 do
              if (FormPadrao = nil) or ('T'+PageControl.pages[vc].name <> TFormClass(FormPadrao).ClassName) then
                PostMessage(Self.Handle, WM_CLOSE_TAB, vC, 0);
          end;
    False: begin
            if pIndex < 0 then            
              PostMessage(Self.Handle, WM_CLOSE_TAB, PageControl.ActivePageIndex, 0)
            else
              PostMessage(Self.Handle, WM_CLOSE_TAB, pIndex-1, 0);
           end;
  end;
end;

procedure TTDI.FormShow(Sender: TObject);
begin

end;

function TTDI.Formulario(Pagina: Integer): TForm;
{retorna o fomulario da pagina em questao}
begin
  Result := nil;

  with PageControl.Pages[Pagina] do
    if ComponentCount > 0 then
      if Components[INDEX_FORM] is TForm then
        Result := TForm(Components[INDEX_FORM]);
end;

procedure TTDI.OnTabHide(Sender: TObject);
begin
  if PageControl.PageCount = 0 then
    PageControl.Visible := False;

  {quando fechar uma aba verifica se esta configurado o formulario padrao
   caso esteja configurado e a aba que esteja sendo fechada não seja o form padrão,
   caso nao tenha mais nem uma outra aba aberta,
   entao abre o formulario padrao}
  if (FormPadrao <> nil) and (PageControl.PageCount = 1) and ('T'+PageControl.ActivePage.Name <> FormPadrao.ClassName) then
  begin
    MostrarFormulario(FormPadrao, False);
    PageControl.ActivePage := Pagina(FormPadrao);
  end;

  {PageControl.PageCount = 1;;; isso se deve pq este vento eh chamado antes da aba
   sumir de fato. Ou seja, se existir somente uma aba e este evento for chamado
   significa que esta ultima aba esta sendo fechada e depoois nao sobra outra}
end;

procedure TTDI.OnWm_Close_Tav(var Msg: TMessage);
begin

  if Msg.WParam < 0 then
    Exit;

  if Formulario(Msg.WParam) <> nil then
  begin
    with Formulario(Msg.WParam) do
    begin
      Close;

      if CloseQuery then
        Free;
    end;

    //se o formulario nao existe mais
    if Formulario(Msg.WParam) = nil then
    begin
      {se nao setarmos o ActivePage (abaixo), quando o usuário pedir para fechar
       todas, duas vezes seguidas, o OnHide nao será executado na segunda vez e
       o FormPadrao não sera mostrado}
      PageControl.ActivePage := NIL;

      PageControl.Pages[Msg.WParam].Free;//entao deleta a pagina
    end;
  end;
end;

procedure TTDI.MenuFechar(Sender: TObject);
begin
  Fechar(False);
end;

procedure TTDI.MenuFecharTodas(Sender: TObject);
begin
  Fechar(True);
end;


procedure TTDI.CriarFormulario(Classe: TFormClass; Primeiro:Boolean = false);
  {cria o formulario a partir de sua classe}
begin

  with TFormClass(Classe).Create(NovaAba) do
  begin

    //configura o formulario
    Align       := alClient;
    BorderStyle := bsNone;
    Parent      := FPageControl.ActivePage;//ActivePage é ultima aba criada com NovaAba
    Name        := copy(TFormClass(Classe).classname,2,length(TFormClass(Classe).classname)) ;

    {O evento onActive do TForm não é executado pq o que se torna ativo
     na verdade é o TTabSheet onde o formulario foi criado. Sendo assim qualquer
     coisa escrita no onActive do formulário não será executado.
     Para contornar esta situação passamos o evento onActive do Form para o
     evento onEnter do TTabSheet. E assim simulamos com segurança o evento onActive}

    PageControl.ActivePage.OnShow := OnActivate;

    //transfere o caption do form para o caption da aba
    if FCaption  = '' then
      PageControl.ActivePage.Caption := Caption
    else
      PageControl.ActivePage.Caption := FCaption;

    if Primeiro then
      begin
        if FormPadrao = nil then
          FormPadrao := Classe;
        FPageControl.ActivePage.PageIndex := 0;
        FPageControl.ActivePage.Tag := 1;
      end;

    Show;//mostra o formulário

  end;

end;

procedure TTDI.CriarPageControl;
begin

  FPageControl := TPageControl.Create(Self.Parent);

  with PageControl do
  begin
    Align        := alClient;
    Parent       := Self.Parent;
    ParentWindow := Self.Parent.Handle;
    Name := 'PcGeral';
    AlignWithMargins := True;
  end;
end;

function TTDI.GetPageControl: TPageControl;
begin
  Result := FPageControl;
end;

destructor TTDI.Destroy;
begin
  try
    try
      Fechar(True);
    finally
 //     PageControl.Free;
    end;
  except
    { TODO : ACABAR ESTA EXCEÇÃO
             ACOTECE SEMPRE QUE A APLICAÇÃO É FECHADA }
  end;

  inherited;
end;

initialization


finalization



end.
