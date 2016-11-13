unit UnitDBM;

interface

uses
  System.SysUtils, System.Classes, DBXDevartSQLServer, Data.DB, Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, FireDAC.Comp.UI, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDM = class(TDataModule)
    GeoDBC: TSQLConnection;
    FDConn: TFDConnection;
    FDQuery1: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    procedure GeoDBCBeforeConnect(Sender: TObject);
    procedure FDConnBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}


procedure TDM.DataModuleCreate(Sender: TObject);
begin
  GeoDBC.Close;
  FDConn.Close;
end;

procedure TDM.FDConnBeforeConnect(Sender: TObject);
begin
  FDConn.Params.Values['Database'] := 'CDCC';
  FDConn.Params.Values['User_Name'] := 'sa';
  FDConn.Params.Values['Password'] := 'masterkey';
  FDConn.Params.Values['Server'] := 'localhost';
  FDConn.Params.Values['DriverID'] := 'MSSQL';
  FDConn.Params.Values['OSAuthent'] := 'No';
  { Database=CDCC
    User_Name=sa
    Password=*****
    Server=localhost
    DriverID=MSSQL
    OSAuthent=No }
end;

procedure TDM.GeoDBCBeforeConnect(Sender: TObject);
begin
  GeoDBC.Params.Values['BlobSize'] := '-1';
  GeoDBC.Params.Values['SchemaOverride'] := '%.dbo';
  GeoDBC.Params.Values['HostName'] := 'localhost';
  GeoDBC.Params.Values['Database'] := 'CDCC';
  GeoDBC.Params.Values['DriverName'] := 'DevartSQLServer';
  GeoDBC.Params.Values['User_Name'] := 'sa';

  GeoDBC.Params.Values['Password'] := 'masterkey';
  GeoDBC.Params.Values['LongStrings'] := 'True';
  GeoDBC.Params.Values['EnableBCD'] := 'True';
  GeoDBC.Params.Values['FetchAll'] := 'True';
  GeoDBC.Params.Values['UseUnicode'] := 'True';

  { BlobSize=-1
    SchemaOverride=%.dbo
    HostName=localhost
    Database=CDCC
    DriverName=DevartSQLServer
    User_Name=sa
    Password=masterkey
    LongStrings=True
    EnableBCD=True
    FetchAll=True
    UseUnicode=True }
end;

end.