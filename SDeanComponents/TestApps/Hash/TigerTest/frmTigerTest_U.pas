unit frmTigerTest_U;
// Description: 
// By Sarah Dean
// Email: sdean12@sdean12.org
// WWW:   http://www.SDean12.org/
//
// -----------------------------------------------------------------------------
//


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, HashAlg_U, HashAlgTiger_U;

type
  TfrmTigerTest = class(TForm)
    reResults: TRichEdit;
    HashAlgTiger: THashAlgTiger;
    pbClear: TButton;
    pbClose: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    pbNESSIETestSet1: TButton;
    pbNESSIETestSet2: TButton;
    pbStdTest: TButton;
    pbNESSIETestSet4: TButton;
    pbNESSIETestSet3: TButton;
    procedure pbCloseClick(Sender: TObject);
    procedure pbClearClick(Sender: TObject);
    procedure pbStdTestClick(Sender: TObject);
    procedure pbNESSIETestSet1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pbNESSIETestSet2Click(Sender: TObject);
    procedure pbNESSIETestSet3Click(Sender: TObject);
    procedure pbNESSIETestSet4Click(Sender: TObject);
  private
    CountSuccess: integer;
    CountFailure: integer;

    procedure CommentStd();
    procedure CommentNESSIE();

    procedure TestInit(testSetDesc: string; isNESSIE: boolean);
    procedure Test(description, testVector, expectedResult: string);
    procedure TestFinish();
  public
    { Public declarations }
  end;

var
  frmTigerTest: TfrmTigerTest;

implementation

{$R *.DFM}

uses
  HashValue_U,
  NESSIESet2,
  NESSIESet3;

procedure TfrmTigerTest.pbCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmTigerTest.pbClearClick(Sender: TObject);
begin
  reResults.Lines.Clear();

end;

procedure TfrmTigerTest.CommentStd();
begin
  reResults.Lines.Add('Note: The standard test vectors found on the Tiger WWW site are laid out using the following byte order:');
  reResults.Lines.Add('');
  reResults.Lines.Add('7 6 5 4 3 2 1 0 space 15 14 13 12 11 10 9 8 space 23 22 21 20 19 18 17');
  reResults.Lines.Add('');
  reResults.Lines.Add('This tool uses the standard THash layout, which displays hashes in the following byte order:');
  reResults.Lines.Add('');
  reResults.Lines.Add('1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23');
  reResults.Lines.Add('');
  reResults.Lines.Add('Note: The Tiger WWW site states quite clearly that there is *no* standard layout for displaying hashes generated by Tiger.');
  reResults.Lines.Add('');
  reResults.Lines.Add('');

end;

procedure TfrmTigerTest.CommentNESSIE();
begin
  reResults.Lines.Add('Note: The NESSIE test vectors are laid out using the following byte order:');
  reResults.Lines.Add('');
  reResults.Lines.Add('1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23');
  reResults.Lines.Add('');
  reResults.Lines.Add('This tool uses the standard THash layout, which displays hashes in the same byte order as NESSIE.');
  reResults.Lines.Add('');
  reResults.Lines.Add('Note: The Tiger WWW site states quite clearly that there is *no* standard layout for displaying hashes generated by Tiger.');
  reResults.Lines.Add('');
  reResults.Lines.Add('');

end;


procedure TfrmTigerTest.pbStdTestClick(Sender: TObject);
var
  str64K: string;
  i: integer;
begin
  TestInit('Standard Tiger Test Vectors', FALSE);

  Test(
       '""',
       '',
       '3293AC630C13F0245F92BBB1766E16167A4E58492DDE73F3'
      );

  Test(
       '"abc"',
       'abc',
       '2AAB1484E8C158F2BFB8C5FF41B57A525129131C957B5F93'
      );

  Test(
       '"Tiger"',
       'Tiger',
       'DD00230799F5009FEC6DEBC838BB6A27DF2B9D6F110C7937'
      );

  Test(
       '"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-"',
       'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-',
       'F71C8583902AFB879EDFE610F82C0D4786A3A534504486B5'
      );

  Test(
       '"ABCDEFGHIJKLMNOPQRSTUVWXYZ=abcdefghijklmnopqrstuvwxyz+0123456789"',
       'ABCDEFGHIJKLMNOPQRSTUVWXYZ=abcdefghijklmnopqrstuvwxyz+0123456789',
       '48CEEB6308B87D46E95D656112CDF18D97915F9765658957'
      );

  Test(
       '"Tiger - A Fast New Hash Function, by Ross Anderson and Eli Biham"',
       'Tiger - A Fast New Hash Function, by Ross Anderson and Eli Biham',
       '8A866829040A410C729AD23F5ADA711603B3CDD357E4C15E'
      );

  Test(
       '"Tiger - A Fast New Hash Function, by Ross Anderson and Eli Biham, proceedings of Fast Software Encryption 3, Cambridge."',
       'Tiger - A Fast New Hash Function, by Ross Anderson and Eli Biham, proceedings of Fast Software Encryption 3, Cambridge.',
       'CE55A6AFD591F5EBAC547FF84F89227F9331DAB0B611C889'
      );

  Test(
       '"Tiger - A Fast New Hash Function, by Ross Anderson and Eli Biham, proceedings of Fast Software Encryption 3, Cambridge, 1996."',
       'Tiger - A Fast New Hash Function, by Ross Anderson and Eli Biham, proceedings of Fast Software Encryption 3, Cambridge, 1996.',
       '631ABDD103EB9A3D245B6DFD4D77B257FC7439501D1568DD'
      );

  Test(
       '"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-"',
       'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+-',
       'C54034E5B43EB8005848A7E0AE6AAC76E4FF590AE715FD25'
      );

  str64K := '';
  for i:=0 to 65535 do
    begin
    str64K := str64K + char(i and $FF);
    end;
  Test(
       'a 64K-byte string',
       str64K,
       'FDF4F5B35139F48E710E421BE5AF411DE1A8AAC333F26204'
      );

  TestFinish();
end;

procedure TfrmTigerTest.pbNESSIETestSet1Click(Sender: TObject);
begin
  TestInit('NESSIE Tiger Test vectors -- set 1', TRUE);

  Test(
       'Set 1, vector# 0: "" (empty string)',
       '',
       '3293AC630C13F0245F92BBB1766E16167A4E58492DDE73F3'
      );

  Test(
       'Set 1, vector# 1: "a"',
       'a',
       '77BEFBEF2E7EF8AB2EC8F93BF587A7FC613E247F5F247809'
      );

  Test(
       'Set 1, vector# 2: "abc"',
       'abc',
       '2AAB1484E8C158F2BFB8C5FF41B57A525129131C957B5F93'
      );

  Test(
       'Set 1, vector# 3: "message digest"',
       'message digest',
       'D981F8CB78201A950DCF3048751E441C517FCA1AA55A29F6'
      );

  Test(
       'Set 1, vector# 4: "abcdefghijklmnopqrstuvwxyz"',
       'abcdefghijklmnopqrstuvwxyz',
       '1714A472EEE57D30040412BFCC55032A0B11602FF37BEEE9'
      );

  Test(
       'Set 1, vector# 5: "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"',
       'abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq',
       '0F7BF9A19B9C58F2B7610DF7E84F0AC3A71C631E7B53F78E'
      );

  Test(
       'Set 1, vector# 6: "A...Za...z0...9"',
       'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789',
       '8DCEA680A17583EE502BA38A3C368651890FFBCCDC49A8CC'
      );

  Test(
       'Set 1, vector# 7: 8 times "1234567890"',
       '12345678901234567890123456789012345678901234567890123456789012345678901234567890',
       '1C14795529FD9F207A958F84C52F11E887FA0CABDFD91BFD'
      );

  Test(
       'Set 1, vector# 8: 1 million times "a"',
       StringOfChar('a', 1000000),
       '6DB0E2729CBEAD93D715C6A7D36302E9B3CEE0D2BC314B41'
      );

  TestFinish();
end;

procedure TfrmTigerTest.TestInit(testSetDesc: string; isNESSIE: boolean);
begin
  CountSuccess:= 0;
  CountFailure:= 0;

  reResults.Lines.Add('Running test set: '+testSetDesc);
  reResults.Lines.Add('====================================');
  reResults.Lines.Add('');

  if (isNESSIE) then
    begin
    CommentNESSIE();
    end
  else
    begin
    CommentStd();
    end;

end;

procedure TfrmTigerTest.Test(description, testVector, expectedResult: string);
var
  ha: THashArray;
  strHashGenerated: string;
  strStatus: string;
begin
  ha := HashAlgTiger.HashString(testVector);
  strHashGenerated := HashAlgTiger.HashToDisplay(ha);

  strStatus := '';
  if (strHashGenerated = expectedResult) then
    begin
    strStatus := 'Pass';
    CountSuccess := CountSuccess + 1;
    end
  else
    begin
    strStatus := 'FAIL.';
    CountFailure := CountFailure + 1;
    end;

  reResults.lines.add('Test description: '+description);
  reResults.lines.add('Expected hash: '+expectedResult);
  reResults.lines.add('Generated hash: '+strHashGenerated);
  reResults.lines.add('Result: '+strStatus);
  reResults.lines.add('');

end;

procedure TfrmTigerTest.TestFinish();
begin
  reResults.Lines.Add('');
  reResults.Lines.Add('Results');
  reResults.Lines.Add('-------');
  reResults.Lines.Add('Tests run: '+inttostr(CountSuccess+CountFailure));
  reResults.Lines.Add('Passed: '+inttostr(CountSuccess));
  reResults.Lines.Add('Failed: '+inttostr(CountFailure));

  if (CountFailure > 0) then
    begin
    reResults.lines.add('');
    reResults.lines.add('!!!!!!!!!!!!!!!!');
    reResults.lines.add('ONE OR MORE OF THE TEST VECTORS FAILED.');
    reResults.lines.add('!!!!!!!!!!!!!!!!');

    MessageDlg('One or more of the test vectors failed!', mtError, [mbOK], 0);
    end
  else if (CountFailure = 0) then
    begin
    reResults.lines.add('');
    reResults.lines.add('All tests passed successfully.');
    end;

  reResults.lines.add('');

end;

procedure TfrmTigerTest.FormShow(Sender: TObject);
begin
  self.Caption := Application.Title;
  reResults.Lines.Clear();

end;

procedure TfrmTigerTest.pbNESSIETestSet2Click(Sender: TObject);
var
  i: integer;
begin
  TestInit('NESSIE Tiger Test vectors -- set 2', TRUE);

  reResults.Lines.Add('Note: Because THash only operates on bytes, not bits, only every 8th NESSIE test set 2 test will be carried out.');
  reResults.Lines.Add('');

  for i:=0 to 1023 do
    begin
    if ((i mod 8) = 0) then
      begin
      Test(
           'Set 2, vector# '+inttostr(i)+': '+inttostr(i)+' zero bits',
           StringOfChar(#0, i div 8),
           NESSIE_SET_2_EXPECTED[i]
          );
      end;
    end;

  TestFinish();
end;

procedure TfrmTigerTest.pbNESSIETestSet3Click(Sender: TObject);
var
  testID: integer;
  testString: string;
  bit: byte;
  i: integer;
  j: integer;
begin
  TestInit('NESSIE Tiger Test vectors -- set 3', TRUE);

  testID := 0;
  for i:=0 to 63 do
    begin
    bit := $80;
    for j:=1 to 8 do
      begin
      if (j <> 1) then
        begin
        bit := bit shr 1;
        end;

      testString := StringOfChar(#0, i);
      testString := testString + char(bit);
      testString := testString + StringOfChar(#0, (63-i));

      Test(
           'Set 3, vector# '+inttostr(testID)+': 512-bit string:  '+inttostr(i)+'*00,'+inttohex(bit, 2)+','+inttostr(63-i)+'*00',
           testString,
           NESSIE_SET_3_EXPECTED[testID]
          );

      // Increment, ready for next...
      inc(testID);
      end;
    end;

  TestFinish();
end;

procedure TfrmTigerTest.pbNESSIETestSet4Click(Sender: TObject);
const
  expectedFirst: string = 'CDDDCACFEA7B70B485655BA3DC3F60DEE4F6B8F861069E33';
  expectedLast:  string = '35C4F594F7E827FFC68BFECEBEDA314EDC6FE917BDF00B66';
var
  ha: THashArray;
  strHashGeneratedFirst: string;
  strHashGeneratedLast: string;
  i: integer;
  strStatus: string;
begin
  TestInit('NESSIE Tiger Test vectors -- set 4', TRUE);

  ha := HashAlgTiger.HashString(StringOfChar(#0, (192 div 8)));
  strHashGeneratedFirst := HashAlgTiger.HashToDisplay(ha);

  reResults.lines.add('Test description: Set 4, vector# 0: 192 zero bits; iterated 100000 times');

  // We continue the loop from 2, as we've already done the first
  for i:=2 to 100000 do
    begin
    ha := HashAlgTiger.HashString(HashAlgTiger.HashToDataString(ha));
    end;

  strHashGeneratedLast := HashAlgTiger.HashToDisplay(ha);

  reResults.lines.add('Expected first hash: '+expectedFirst);
  reResults.lines.add('Generated first hash: '+strHashGeneratedFirst);
  reResults.lines.add('Expected last hash: '+expectedLast);
  reResults.lines.add('Generated last hash: '+strHashGeneratedLast);

  strStatus := '';
  if ((expectedFirst = strHashGeneratedFirst) and (expectedLast = strHashGeneratedLast)) then
    begin
    strStatus := 'Pass';
    CountSuccess := CountSuccess + 1;
    end
  else
    begin
    strStatus := 'FAIL.';
    CountFailure := CountFailure + 1;
    end;

  reResults.lines.add('Result: '+strStatus);
  reResults.lines.add('');

  TestFinish();
end;


END.


