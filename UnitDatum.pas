unit UnitDatum;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, AdvMetroForm, AdvMetroProgressBar, CurvyControls, AdvOfficePager, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL,
  GridsEh, DBAxisGridsEh, DBGridEh, AdvUtil, Vcl.Grids, AdvObj, BaseGrid, AdvGrid,
  AdvMetroTile, tmsAdvGridExcel, EhLibMTE, EhLibFireDAC,
  PrnDbgeh, DataSetImpExpEh,  QImport3, QImport3Xlsx,
  QExport4, QExport4XLS, Vcl.StdCtrls, AdvMetroTaskDialog, W7Classes, W7Buttons, AdvGroupBox, AdvOfficeButtons;

type
  TFormDatum = class(TAdvMetroForm)
    AdvPagerMain: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    AdvOfficePager12: TAdvOfficePage;
    AdvOfficePager13: TAdvOfficePage;
    CurvyPanel1: TCurvyPanel;
    ProgressBar: TAdvMetroProgressBar;
    AdvPagerShop: TAdvOfficePager;
    AdvOfficePager21: TAdvOfficePage;
    AdvOfficePager22: TAdvOfficePage;
    EhGridShop: TDBGridEh;
    AdvStringGrid1: TAdvStringGrid;
    AdvOpen: TAdvMetroTile;
    AdvImport: TAdvMetroTile;
    AdvExport: TAdvMetroTile;
    AdvMetroTile1: TAdvMetroTile;
    OpenDialog1: TOpenDialog;
    AdvExcelIO1: TAdvGridExcelIO;
    PrintShop: TPrintDBGridEh;
    QExportShop: TQExport4XLS;
    SaveDialog1: TSaveDialog;
    AdvMetroTile2: TAdvMetroTile;
    AdvMetroTile3: TAdvMetroTile;
    AdvMetroTaskDialog1: TAdvMetroTaskDialog;
    AdvPagerFeeinfo: TAdvOfficePager;
    AdvOfficePage1: TAdvOfficePage;
    EhGridFeeInfo: TDBGridEh;
    AdvOfficePage2: TAdvOfficePage;
    AdvMetroTile4: TAdvMetroTile;
    AdvMetroTile5: TAdvMetroTile;
    W7SpeedButton1: TW7SpeedButton;
    W7PageSelector1: TW7PageSelector;
    W7PageSelector2: TW7PageSelector;
    W7PageSelector3: TW7PageSelector;
    AdvOfficePage3: TAdvOfficePage;
    AdvOfficePage4: TAdvOfficePage;
    AdvOfficePage5: TAdvOfficePage;
    PrintFeeinfo: TPrintDBGridEh;
    AdvExcelIO2: TAdvGridExcelIO;
    AdvPagerPactInfo: TAdvOfficePager;
    AdvOfficePage6: TAdvOfficePage;
    W7SpeedButton2: TW7SpeedButton;
    EhGridPactInfo: TDBGridEh;
    AdvOfficePage7: TAdvOfficePage;
    AdvStringGrid3: TAdvStringGrid;
    AdvPagerEm: TAdvOfficePager;
    AdvOfficePage8: TAdvOfficePage;
    W7SpeedButton3: TW7SpeedButton;
    EhGridEM: TDBGridEh;
    AdvOfficePage9: TAdvOfficePage;
    AdvOfficePager3: TAdvOfficePager;
    AdvOfficePage10: TAdvOfficePage;
    W7SpeedButton4: TW7SpeedButton;
    EhGridStdRent: TDBGridEh;
    AdvOfficePage11: TAdvOfficePage;
    AdvExcelIO3: TAdvGridExcelIO;
    AdvExcelIO4: TAdvGridExcelIO;
    PrintPactInfo: TPrintDBGridEh;
    PrintEm: TPrintDBGridEh;
    EhGridStdProp: TDBGridEh;
    PrintRent: TPrintDBGridEh;
    PrintProp: TPrintDBGridEh;
    CommitDialog: TAdvMetroTaskDialog;
    QExportFeeInfo: TQExport4XLS;
    QExportPactInfo: TQExport4XLS;
    QExportEm: TQExport4XLS;
    FeeKind: TAdvOfficeRadioGroup;
    AdvStringGrid2: TAdvStringGrid;
    CurvyCombo1: TCurvyCombo;
    AdvStringGrid4: TAdvStringGrid;
    PactKind: TAdvOfficeRadioGroup;
    procedure AdvOpenClick(Sender: TObject);
    procedure AdvMetroFormCreate(Sender: TObject);
    procedure AdvMetroTile1Click(Sender: TObject);
    procedure AdvExportClick(Sender: TObject);
    procedure AdvImportClick(Sender: TObject);
    procedure QExportShopEndExport(Sender: TObject);
    procedure AdvMetroTile5Click(Sender: TObject);
    procedure AdvMetroTile4Click(Sender: TObject);
    procedure AdvExcelIO2Progress(Sender: TObject; SheetNum, SheetTot, RowNum, RowTot: Integer);
    procedure InsertFeeInfo();
    procedure InsertEmInfo();
    procedure InsertPactInfo();
    procedure UpdateShopInfo();
    procedure AdvMetroTile3Click(Sender: TObject);
    procedure CurvyCombo1Select(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure ClearGrid(AGrid: TAdvStringGrid); // �ų�����
    procedure ClaerSelection(AGrid: TAdvStringGrid);
    function NormalGridData(AGrid: TAdvStringGrid): Integer; // �ų��ַ����ҿո�
    function CheckPayFeeHeader(AGrid: TAdvStringGrid): Boolean; // �����ͷ�ֶ�˳��
    function CheckShopHeader(AGrid: TAdvStringGrid): Boolean; // ���������Ϣ��ͷ
    function CheckPactInfoHeader(AGrid: TAdvStringGrid): Boolean; // ����ͬ��Ϣ��ͷ
    function CheckEmHeader(AGrid: TAdvStringGrid): Boolean; // �������Ϣ��ͷ
    function CheckFeatID(const Astr: string): Boolean; // ���Ҫ�ر���Ƿ���ȷ
    function CheckGridFeatID(AGrid: TAdvStringGrid): Integer; // ����������FeatiD
  public
    { Public declarations }
    Recorder: string;
  end;

var
  FormDatum: TFormDatum;

implementation

{$R *.dfm}


uses UnitDBM, UnitMain, System.RegularExpressions;

procedure TFormDatum.AdvExcelIO2Progress(Sender: TObject; SheetNum, SheetTot, RowNum, RowTot: Integer);
begin

  // ����� MouseActions.DisjunctCellSelect or MouseActions.DisjunctRowSelect
  // or MouseActions.DisjunctColSelect property to True
  if Trim((Sender as TAdvGridExcelIO).AdvStringGrid.Cells[1, RowNum]) = '' then
  begin
    (Sender as TAdvGridExcelIO).AdvStringGrid.RowSelect[RowNum] := True;
  end;
end;

procedure TFormDatum.AdvExportClick(Sender: TObject);
begin
  if AdvPagerMain.ActivePageIndex > 3 then Exit;
  SaveDialog1.FileName := AdvPagerMain.ActivePage.Caption;
  if SaveDialog1.Execute() then
  begin
    case AdvPagerMain.ActivePageIndex of
      0:
        begin
          QExportShop.ShowFile := AdvMetroTile2.Down;
          QExportShop.FileName := SaveDialog1.FileName;
          QExportShop.Execute;
        end;

      1:
        begin
          QExportFeeInfo.ShowFile := AdvMetroTile2.Down;
          QExportFeeInfo.FileName := SaveDialog1.FileName;
          QExportFeeInfo.Execute;
        end;

      2:
        begin
          QExportPactInfo.ShowFile := AdvMetroTile2.Down;
          QExportPactInfo.FileName := SaveDialog1.FileName;
          QExportPactInfo.Execute;
        end;

      3:
        begin
          QExportEm.ShowFile := AdvMetroTile2.Down;
          QExportEm.FileName := SaveDialog1.FileName;
          QExportEm.Execute;
        end;
    end;
  end;

end;

procedure TFormDatum.AdvImportClick(Sender: TObject);
begin

  case AdvPagerMain.ActivePageIndex of
    0:
      begin
        // InsertFeeInfo;
        ShowMessage('��ȷ������������Ϣô��');
        UpdateShopInfo;

      end;
    1:
      begin
        ShowMessage('��ȷ������ ' + FeeKind.Items[FeeKind.ItemIndex] + ' �ɷѼ�¼ô��');
        InsertFeeInfo;
      end;
    2:
      begin
        ShowMessage('��ȷ������ ' + PactKind.Items[PactKind.ItemIndex] + ' ��Ϣô��');
        InsertPactInfo;
      end;
    3:
      begin
        ShowMessage('��ȷ������ ��� ��Ϣô��');
        InsertEmInfo;
        // Self.Caption:=
        // AdvStringGrid4.Cells[1, 1]+AdvStringGrid4.Cells[2,  1]+
        // AdvStringGrid4.Cells[3,  1]+
        // AdvStringGrid4.Cells[4,  1];
        // ShowMessage(Self.Caption);
      end;
  end;
end;

procedure TFormDatum.AdvMetroFormCreate(Sender: TObject);
begin
  AdvPagerMain.ActivePageIndex := 0;
  AdvPagerShop.ActivePageIndex := 0;
  AdvPagerFeeinfo.ActivePageIndex := 0;
  AdvPagerEm.ActivePageIndex := 0;
  AdvPagerPactInfo.ActivePageIndex := 0;

  EhGridShop.SearchPanel.Active := True;
  EhGridFeeInfo.SearchPanel.Active := True;
  EhGridPactInfo.SearchPanel.Active := True;
  EhGridEM.SearchPanel.Active := True;

  AdvStringGrid1.RowCount := 1;
  AdvStringGrid2.RowCount := 1;
  AdvStringGrid3.RowCount := 1;
  AdvStringGrid4.RowCount := 1;
  AdvStringGrid1.ColCount := 1;
  AdvStringGrid2.ColCount := 1;
  AdvStringGrid3.ColCount := 1;
  AdvStringGrid4.ColCount := 1;

  // QExportFeeInfo

  DM.FDQshop.Open;
  DM.FDQfeeinfo.Open;
  DM.FDQpactInfo.Open;
  DM.FDQEM.Open;
  DM.FDQstdRent.Open;
  DM.FDQstdProp.Open;

  Recorder := FormMain.AdvMetroButton8.Caption;
end;

procedure TFormDatum.AdvMetroTile1Click(Sender: TObject);
begin
  case AdvPagerMain.ActivePageIndex of
    0:
      begin
        PrintShop.Preview;
      end;
    1:
      begin
        PrintFeeinfo.Preview;
      end;

    2:
      begin
        PrintPactInfo.Preview;
      end;
    3:
      begin
        PrintEm.Preview;
      end;

    4:
      begin
        case AdvOfficePager3.ActivePageIndex of
          0:
            begin
              PrintRent.Preview;
            end;

          1:
            begin
              PrintProp.Preview;
            end;
        end;
      end;

  end;
end;

procedure TFormDatum.AdvMetroTile3Click(Sender: TObject);
var
  iErrorow: Integer;
begin
  case AdvPagerMain.ActivePageIndex of
    0:
      begin
        if AdvStringGrid1.RowCount > 1 then
        begin
          iErrorow := CheckGridFeatID(AdvStringGrid2);
          if iErrorow > 0 then
          begin
            AdvImport.Enabled := False;
            ShowMessage('�зǷ����ݣ����޸ı��Ϊ��ɫ�����ݣ�');
          end
          else
          begin
            AdvImport.Enabled := True;
            ShowMessage('���̱�Ÿ�ʽ��ȷ!');
          end;
        end
        else
        begin
          ShowMessage('��δ���������ļ���');
        end;
      end;
    1:
      begin
        if AdvStringGrid2.RowCount > 1 then
        begin
          iErrorow := CheckGridFeatID(AdvStringGrid2);
          if iErrorow > 0 then
          begin
            AdvImport.Enabled := False;
            ShowMessage('�зǷ����ݣ����޸ı��Ϊ��ɫ�����ݣ�');
          end
          else
          begin
            AdvImport.Enabled := True;
            ShowMessage('���̱�Ÿ�ʽ��ȷ!');
          end;
        end
        else
        begin
          ShowMessage('��δ���������ļ���');
        end;
      end;

    2:
      begin
        if AdvStringGrid3.RowCount > 1 then
        begin
          iErrorow := CheckGridFeatID(AdvStringGrid3);
          if iErrorow > 0 then
          begin
            AdvImport.Enabled := False;
            ShowMessage('�зǷ����ݣ����޸ı��Ϊ��ɫ�����ݣ�');
          end
          else
          begin
            AdvImport.Enabled := True;
            ShowMessage('���̱�Ÿ�ʽ��ȷ!');
          end;
        end
        else
        begin
          ShowMessage('��δ���������ļ���');
        end;
      end;
    3:
      begin
        if AdvStringGrid4.RowCount > 1 then
        begin
          iErrorow := CheckGridFeatID(AdvStringGrid4);
          if iErrorow > 0 then
          begin
            AdvImport.Enabled := False;
            ShowMessage('�зǷ����ݣ����޸ı��Ϊ��ɫ�����ݣ�');
          end
          else
          begin
            AdvImport.Enabled := True;
            ShowMessage('���̱�Ÿ�ʽ��ȷ!');
          end;
        end
        else
        begin
          ShowMessage('��δ���������ļ���');
        end;
      end;
  end;

end;

procedure TFormDatum.AdvMetroTile4Click(Sender: TObject);
var
  noError: Integer;
begin
  noError := 99;
  if CommitDialog.Execute = 101 then Exit;

  case AdvPagerMain.ActivePageIndex of
    0:
      begin
        noError := DM.FDQshop.ApplyUpdates(0);
        // DM.FDQfeeinfo.Refresh;
      end;
    1:
      begin
        noError := DM.FDQfeeinfo.ApplyUpdates(0);
        // DM.FDQfeeinfo.Refresh;
      end;

    2:
      begin

        noError := DM.FDQpactInfo.ApplyUpdates(0);
        // DM.FDQpactInfo.Refresh;
      end;
    3:
      begin
        noError := DM.FDQEM.ApplyUpdates(0);
        // DM.FDQEM.Refresh;
      end;
    4:
      begin
        case AdvOfficePager3.ActivePageIndex of
          0:
            begin

              noError := DM.FDQstdRent.ApplyUpdates(0);
              // DM.FDQstdRent.Refresh;
            end;

          1:
            begin
              noError := DM.FDQstdProp.ApplyUpdates(0);
              // DM.FDQstdProp.Refresh;
            end;
        end;
      end;
  end;
  if noError = 0 then ShowMessage('�ύ�ɹ�');
end;

procedure TFormDatum.AdvMetroTile5Click(Sender: TObject);
begin

  case AdvPagerMain.ActivePageIndex of
    0:
      begin
        DM.FDQshop.CancelUpdates;
        DM.FDQfeeinfo.Refresh;
      end;
    1:
      begin
        DM.FDQfeeinfo.CancelUpdates;
        DM.FDQfeeinfo.Refresh;
      end;

    2:
      begin

        DM.FDQpactInfo.CancelUpdates;
        DM.FDQpactInfo.Refresh;
      end;
    3:
      begin
        DM.FDQEM.CancelUpdates;
        DM.FDQEM.Refresh;
      end;
    4:
      begin
        case AdvOfficePager3.ActivePageIndex of
          0:
            begin

              DM.FDQstdRent.CancelUpdates;
              DM.FDQstdRent.Refresh;
            end;

          1:
            begin
              DM.FDQstdProp.CancelUpdates;
              DM.FDQstdProp.Refresh;
            end;
        end;
      end;

  end;
end;

procedure TFormDatum.AdvOpenClick(Sender: TObject);
var
  iErrorow: Integer;
begin
  if AdvPagerMain.ActivePageIndex > 3 then Exit;
  if OpenDialog1.Execute then
  begin
    case AdvPagerMain.ActivePageIndex of
      0:
        begin // AdvStringGrid1
          AdvStringGrid1.ClearRowSelect;
          AdvStringGrid1.Row := 0;
          AdvExcelIO1.XLSImport(OpenDialog1.FileName);
          if CheckShopHeader(AdvStringGrid1) then // �ֶνṹ��ȷ����
          begin
            ClearGrid(AdvStringGrid1); // ������
            NormalGridData(AdvStringGrid1); // ��д�к�
            iErrorow := CheckGridFeatID(AdvStringGrid1); // ��������
            if iErrorow > 0 then
            begin
              AdvImport.Enabled := False;
              ShowMessage('�Ƿ�������');
            end;
            AdvPagerShop.ActivePageIndex := 1;
            AdvStringGrid1.ColCount := 10; // ������ȥ��
          end
          else
          begin
            AdvStringGrid1.RowCount := 1;
            AdvStringGrid1.ColCount := 1;
            ShowMessage('�����ļ��ṹ����');
          end;

        end;
      1:
        begin
          AdvStringGrid2.ClearRowSelect;
          AdvStringGrid2.Row := 0;
          AdvExcelIO2.XLSImport(OpenDialog1.FileName);
          if CheckPayFeeHeader(AdvStringGrid2) then // �ֶνṹ��ȷ����
          begin
            ClearGrid(AdvStringGrid2); // ������
            NormalGridData(AdvStringGrid2); // ��д�к�
            iErrorow := CheckGridFeatID(AdvStringGrid2); // ��������
            if iErrorow > 0 then
            begin
              AdvImport.Enabled := False;
              // ShowMessage('�Ƿ�������');
            end;
            AdvPagerFeeinfo.ActivePageIndex := 1;
            AdvStringGrid2.ColCount := 9; // ������ȥ��
          end
          else
          begin
            AdvStringGrid2.RowCount := 1;
            AdvStringGrid2.ColCount := 1;
            ShowMessage('�����ļ��ṹ����');
          end;

        end;

      2:
        begin
          AdvStringGrid3.ClearRowSelect;
          AdvStringGrid3.Row := 0;
          AdvExcelIO3.XLSImport(OpenDialog1.FileName);
          if CheckPactInfoHeader(AdvStringGrid3) then // �ֶνṹ��ȷ����
          begin
            ClearGrid(AdvStringGrid3); // ������
            NormalGridData(AdvStringGrid3); // ��д�к�
            iErrorow := CheckGridFeatID(AdvStringGrid3); // ��������
            if iErrorow > 0 then
            begin
              AdvImport.Enabled := False;
              // ShowMessage('�Ƿ�������');
            end;
            AdvPagerPactInfo.ActivePageIndex := 1;
            AdvStringGrid3.ColCount := 12; // ������ȥ��
          end
          else
          begin
            AdvStringGrid3.RowCount := 1;
            AdvStringGrid3.ColCount := 1;
            ShowMessage('�����ļ��ṹ����');
          end;
        end;

      3:
        begin // AdvStringGrid4
          AdvStringGrid4.ClearRowSelect;
          AdvStringGrid4.Row := 0;
          AdvExcelIO4.XLSImport(OpenDialog1.FileName);
          if CheckEmHeader(AdvStringGrid4) then // �ֶνṹ��ȷ����
          begin
            ClearGrid(AdvStringGrid4); // ������
            NormalGridData(AdvStringGrid4); // ��д�к�
            iErrorow := CheckGridFeatID(AdvStringGrid4); // ��������
            if iErrorow > 0 then
            begin
              AdvImport.Enabled := False;
              // ShowMessage('�Ƿ�������');
            end;
            AdvPagerEm.ActivePageIndex := 1;
            AdvStringGrid4.ColCount := 5; // ������ȥ��
          end
          else
          begin
            AdvStringGrid4.RowCount := 1;
            AdvStringGrid4.ColCount := 1;
            ShowMessage('�����ļ��ṹ����');
          end;
        end;

    end;
  end;
end;

function TFormDatum.CheckEmHeader(AGrid: TAdvStringGrid): Boolean;
begin
  { ���̱��	��������	������	��ע }
  Result := True;
  if AGrid.Cells[1, 0] <> '���̱��' then Exit(False);
  if AGrid.Cells[2, 0] <> '��������' then Exit(False);
  if AGrid.Cells[3, 0] <> '������' then Exit(False);
  if AGrid.Cells[4, 0] <> '��ע' then Exit(False);

end;

function TFormDatum.CheckFeatID(const Astr: string): Boolean;
var
  sFID: string;
begin
  // sFID := '[1-2]-[1-4]F-[A-G]-[0-9][0-9][0-9]';
  // sFID := '^[1-2]-[1-4]F-[A-G]-*';
  sFID := '^[1-2]-[1-4]F-*';
  if TRegEx.IsMatch(Astr, sFID) then
  begin
    Result := True
  end
  else
  begin
    Result := False;
  end;
end;

function TFormDatum.CheckGridFeatID(AGrid: TAdvStringGrid): Integer;
var
  I: Integer;
begin
  Result := 0;
  CurvyCombo1.Items.Clear;
  CurvyCombo1.Text := '';
  for I := 1 to AGrid.RowCount - 1 do
  begin
    if not CheckFeatID(AGrid.Cells[1, I]) then
    begin
      AGrid.Colors[1, I] := clWebOrangeRed;
      CurvyCombo1.Items.Add(AGrid.Cells[1, I]);
      // ShowMessage(AGrid.Cells[1, I]);
      Result := Result + 1;
    end
    else
    begin
      AGrid.Colors[1, I] := AGrid.Colors[2, I];
    end;
  end;
end;

function TFormDatum.CheckPactInfoHeader(AGrid: TAdvStringGrid): Boolean;
begin
  { Ҫ�ر��	��ͬ���	��ͬ����	��ͬ��ʼ	��ͬ��ֹ	��֤���	��ϵ��	�̻�����	����Ȩ��	��ϵ�绰	���õ绰	���õȼ�
  }
  Result := True;
  if AGrid.Cells[1, 0] <> '���̱��' then Exit(False);
  // if AGrid.Cells[2, 0] <> '��������' then Exit(False);
  if AGrid.Cells[2, 0] <> '��ͬ���' then Exit(False);
  // if AGrid.Cells[3, 0] <> '��ͬ����' then Exit(False);
  if AGrid.Cells[3, 0] <> '��ͬ��ʼ' then Exit(False);
  if AGrid.Cells[4, 0] <> '��ͬ��ֹ' then Exit(False);
  if AGrid.Cells[5, 0] <> '��֤���' then Exit(False);
  if AGrid.Cells[6, 0] <> '��ϵ��' then Exit(False);
  if AGrid.Cells[7, 0] <> '�̻�����' then Exit(False);
  if AGrid.Cells[8, 0] <> '����Ȩ��' then Exit(False);
  if AGrid.Cells[9, 0] <> '��ϵ�绰' then Exit(False);
  if AGrid.Cells[10, 0] <> '���õ绰' then Exit(False);
  if AGrid.Cells[11, 0] <> '���õȼ�' then Exit(False);
end;

function TFormDatum.CheckPayFeeHeader(AGrid: TAdvStringGrid): Boolean;
begin
  // ���ɷѼ�¼�ı��ͷ�ֶ�
  { ���̱��	��������	�ɷ�����	��Ч����	��������	Ӧ�ս��
    ʵ�ս��	�տ���		��ע
  }
  Result := True;
  if AGrid.Cells[1, 0] <> '���̱��' then Exit(False);
  // if AGrid.Cells[2, 0] <> '��������' then Exit(False);
  if AGrid.Cells[2, 0] <> '�ɷ�����' then Exit(False);
  if AGrid.Cells[3, 0] <> '��Ч����' then Exit(False);
  if AGrid.Cells[4, 0] <> '��������' then Exit(False);
  if AGrid.Cells[5, 0] <> 'Ӧ�ս��' then Exit(False);
  if AGrid.Cells[6, 0] <> 'ʵ�ս��' then Exit(False);
  if AGrid.Cells[7, 0] <> '�տ���' then Exit(False);
  if AGrid.Cells[8, 0] <> '��ע' then Exit(False);

end;

function TFormDatum.CheckShopHeader(AGrid: TAdvStringGrid): Boolean;
begin
  { ���̱��	��������	����״̬	��������
    �������      �������	��𵥼�   ����ҵ��	�Żݶ��
  }
  Result := True;
  if AGrid.Cells[1, 0] <> '���̱��' then Exit(False);
  // if AGrid.Cells[2, 0] <> '��������' then Exit(False);
  if AGrid.Cells[2, 0] <> '��������' then Exit(False);
  if AGrid.Cells[3, 0] <> '����״̬' then Exit(False);
  if AGrid.Cells[4, 0] <> '��������' then Exit(False);
  if AGrid.Cells[5, 0] <> '�������' then Exit(False);
  if AGrid.Cells[6, 0] <> '�������' then Exit(False);
  if AGrid.Cells[7, 0] <> '��𵥼�' then Exit(False);
  if AGrid.Cells[8, 0] <> '����ҵ��' then Exit(False);
  if AGrid.Cells[9, 0] <> '�Żݶ��' then Exit(False);
end;

procedure TFormDatum.ClaerSelection(AGrid: TAdvStringGrid);
begin
  AGrid.ClearRowSelect;
end;

procedure TFormDatum.ClearGrid(AGrid: TAdvStringGrid);
var
  I: Integer;
begin
  for I := AGrid.RowCount - 1 downto 1 do
  begin
    if AGrid.RowSelect[I] then
    begin
      AGrid.RemoveRowsEx(I, 1);
    end;
  end;

end;

procedure TFormDatum.CurvyCombo1Select(Sender: TObject);
begin
  case AdvPagerMain.ActivePageIndex of
    0:
      begin
        AdvStringGrid1.SearchPanel.EditControl.Text := CurvyCombo1.Text;
      end;
    1:
      begin
        AdvStringGrid2.SearchPanel.EditControl.Text := CurvyCombo1.Text;
      end;

    2:
      begin
        AdvStringGrid3.SearchPanel.EditControl.Text := CurvyCombo1.Text;
      end;
    3:
      begin
        AdvStringGrid4.SearchPanel.EditControl.Text := CurvyCombo1.Text;
      end;
  end;
end;

procedure TFormDatum.InsertEmInfo;
var
  I, iRowCount: Integer;
begin
  { insert into T03EMeters values
    (
    :FeatureID,:ReadDate,:Reading,:Recorder,:Memo
    )
  }
  if AdvStringGrid4.RowCount <= 1 then
  begin
    ShowMessage('���ȼ��������ļ�');
    Exit;
  end;
  iRowCount := AdvStringGrid4.RowCount - 1;
  DM.FDQemInsert.Params.ArraySize := iRowCount;

  for I := 0 to iRowCount - 1 do // 0..20
  begin
    DM.FDQemInsert.ParamByName('FeatureID').AsStrings[I] := AdvStringGrid4.Cells[1, I + 1];
    DM.FDQemInsert.ParamByName('ReadDate').AsDates[I] := AdvStringGrid4.Dates[2, I + 1];
    DM.FDQemInsert.ParamByName('Reading').AsFloats[I] := AdvStringGrid4.Floats[3, I + 1];
    DM.FDQemInsert.ParamByName('Memo').AsStrings[I] := AdvStringGrid4.Cells[4, I + 1];
    DM.FDQemInsert.ParamByName('Recorder').AsStrings[I] := Recorder;
  end;

  DM.FDQemInsert.Execute(iRowCount);
  ShowMessage(DM.FDQemInsert.RowsAffected.ToString);
end;

procedure TFormDatum.InsertFeeInfo;
var
  I, iRowCount: Integer;
begin

  if AdvStringGrid2.RowCount <= 1 then
  begin
    ShowMessage('���ȼ��������ļ�');
    Exit;
  end;

  iRowCount := AdvStringGrid2.RowCount - 1;
  DM.FDQfeeInsert.Params.ArraySize := iRowCount;
  for I := 0 to iRowCount - 1 do // 0..20
  begin
    DM.FDQfeeInsert.ParamByName('FeatureID').AsStrings[I] := AdvStringGrid2.Cells[1, I + 1];
    DM.FDQfeeInsert.ParamByName('FeeKind').AsStrings[I] := FeeKind.Items.Strings[FeeKind.ItemIndex];
    DM.FDQfeeInsert.ParamByName('PayDate').AsDates[I] := AdvStringGrid2.Dates[2, I + 1];
    DM.FDQfeeInsert.ParamByName('FeeBegin').AsDates[I] := AdvStringGrid2.Dates[3, I + 1];;
    DM.FDQfeeInsert.ParamByName('FeeEnd').AsDates[I] := AdvStringGrid2.Dates[4, I + 1];;
    DM.FDQfeeInsert.ParamByName('Dues').AsFloats[I] := AdvStringGrid2.Floats[5, I + 1];
    DM.FDQfeeInsert.ParamByName('PaidFee').AsFloats[I] := AdvStringGrid2.Floats[6, I + 1];
    DM.FDQfeeInsert.ParamByName('Payee').AsStrings[I] := AdvStringGrid2.Cells[7, I + 1];
    DM.FDQfeeInsert.ParamByName('Memo').AsStrings[I] := AdvStringGrid2.Cells[8, I + 1];
    DM.FDQfeeInsert.ParamByName('Recorder').AsStrings[I] := Recorder;
  end;

  DM.FDQfeeInsert.Execute(iRowCount);

  ShowMessage(DM.FDQfeeInsert.RowsAffected.ToString);

end;

procedure TFormDatum.InsertPactInfo;
var
  I, iRowCount: Integer;
  s: string;
begin

  if AdvStringGrid3.RowCount <= 1 then
  begin
    ShowMessage('���ȼ��������ļ�');
    Exit;
  end;
  { insert into T13PactInfo values
    (
    :FeatureID,:PactID  ,:PactKind ,:PactBegin ,:PactEnd ,
    :Margin ,:BossName  ,:ShopKind  ,:ShopRights  ,:Phone1  ,
    :Phone2  ,:StarLevel,:Recorder
    )


  }
  iRowCount := AdvStringGrid3.RowCount - 1;
  DM.FDQpactInsert.Params.ArraySize := iRowCount;
  for I := 0 to iRowCount - 1 do // 0..20
  begin
    DM.FDQpactInsert.ParamByName('FeatureID').AsStrings[I] := AdvStringGrid3.Cells[1, I + 1];
    DM.FDQpactInsert.ParamByName('PactID').AsStrings[I] := AdvStringGrid3.Cells[2, I + 1];
    DM.FDQpactInsert.ParamByName('PactKind').AsStrings[I] := PactKind.Items.Strings[PactKind.ItemIndex];
    DM.FDQpactInsert.ParamByName('PactBegin').AsDates[I] := AdvStringGrid3.Dates[3, I + 1];
    DM.FDQpactInsert.ParamByName('PactEnd').AsDates[I] := AdvStringGrid3.Dates[4, I + 1];;
    DM.FDQpactInsert.ParamByName('Margin').AsFloats[I] := AdvStringGrid3.Floats[5, I + 1];;
    DM.FDQpactInsert.ParamByName('BossName').AsStrings[I] := AdvStringGrid3.Cells[6, I + 1];
    DM.FDQpactInsert.ParamByName('ShopKind').AsStrings[I] := AdvStringGrid3.Cells[7, I + 1];
    DM.FDQpactInsert.ParamByName('ShopRights').AsStrings[I] := AdvStringGrid3.Cells[8, I + 1];
    DM.FDQpactInsert.ParamByName('Phone1').AsStrings[I] := AdvStringGrid3.Cells[9, I + 1];
    DM.FDQpactInsert.ParamByName('Phone2').AsStrings[I] := AdvStringGrid3.Cells[10, I + 1];
    // s := AdvStringGrid3.Cells[9, I + 1] + sLineBreak + AdvStringGrid3.Cells[11, I + 1];
    // ShowMessage(s);
    DM.FDQpactInsert.ParamByName('StarLevel').AsIntegers[I] := AdvStringGrid3.Ints[11, I + 1];
    DM.FDQpactInsert.ParamByName('Recorder').AsStrings[I] := Recorder;

  end;

  DM.FDQpactInsert.Execute(iRowCount);

  ShowMessage(DM.FDQpactInsert.RowsAffected.ToString);
end;

function TFormDatum.NormalGridData(AGrid: TAdvStringGrid): Integer;
var
  I: Integer;
  J: Integer;
begin
  Result := 0;

  ProgressBar.Max := AGrid.RowCount - 1;
  for I := 1 to AGrid.RowCount - 1 do
  begin
    ProgressBar.Position := I;

    AGrid.Cells[0, I] := I.ToString;

    for J := 1 to AGrid.ColCount - 1 do
    begin
      AGrid.Cells[J, I] := Trim(AGrid.Cells[J, I]);
    end;
  end;
end;

procedure TFormDatum.QExportShopEndExport(Sender: TObject);
begin
  AdvMetroTaskDialog1.Execute;;
end;

procedure TFormDatum.UpdateShopInfo;
var
  I, iRowCount: Integer;
  s: string;
begin
  if AdvStringGrid1.RowCount <= 1 then
  begin
    ShowMessage('���ȼ��������ļ�');
    Exit;
  end;
  { update T00Features
    set
    FeatureName= :FeatureName
    ,FeatureStatus = :FeatureStatus
    ,FeatureKind =:FeatureKind
    ,GrossArea=:GrossArea
    ,UsableArea :UsableArea
    ,RentPrice=:RentPrice
    ,PropPrice=:PropPrice
    ,RentOff=:RentOff
    ,Recorder=:Recorder
    where
    FeatureID=:FeatureID
    1���̱��	2��������	3����״̬	4��������	5�������
    6�������	7��𵥼�	8����ҵ��	9�Żݶ�� }
  iRowCount := AdvStringGrid1.RowCount - 1;
  DM.FDQshopUpdate.Params.ArraySize := iRowCount;
  for I := 0 to iRowCount - 1 do // 0..20
  begin
    DM.FDQshopUpdate.ParamByName('FeatureID').AsStrings[I] := AdvStringGrid1.Cells[1, I + 1];
    DM.FDQshopUpdate.ParamByName('FeatureName').AsStrings[I] := AdvStringGrid1.Cells[2, I + 1];
    DM.FDQshopUpdate.ParamByName('FeatureStatus').AsStrings[I] := AdvStringGrid1.Cells[3, I + 1];;
    DM.FDQshopUpdate.ParamByName('FeatureKind').AsStrings[I] := AdvStringGrid1.Cells[4, I + 1];;
    DM.FDQshopUpdate.ParamByName('GrossArea').AsFloats[I] := AdvStringGrid1.Floats[5, I + 1];
    DM.FDQshopUpdate.ParamByName('UsableArea').AsFloats[I] := AdvStringGrid1.Floats[6, I + 1];
    DM.FDQshopUpdate.ParamByName('RentPrice').AsFloats[I] := AdvStringGrid1.Floats[7, I + 1];
    DM.FDQshopUpdate.ParamByName('PropPrice').AsFloats[I] := AdvStringGrid1.Floats[8, I + 1];
    DM.FDQshopUpdate.ParamByName('RentOff').AsFloats[I] := AdvStringGrid1.Floats[9, I + 1];
    DM.FDQshopUpdate.ParamByName('Recorder').AsStrings[I] := Recorder;
  end;

  DM.FDQshopUpdate.Execute(iRowCount);

  ShowMessage(DM.FDQshopUpdate.RowsAffected.ToString);
end;

end.
