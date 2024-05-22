CREATE TABLE SV (
    masv INT PRIMARY KEY,
    hoten NVARCHAR(50),
    ns DATE,
    qq NVARCHAR(50),
    
);

CREATE TABLE MON (
    mamon INT PRIMARY KEY,
    tenmon NVARCHAR(50),
    sotc INT
);
CREATE TABLE KETQUA (
    masv INT,
    mamon INT,
    diem FLOAT CHECK (diem >= 0 AND diem <= 10),
    PRIMARY KEY (masv, mamon),
    FOREIGN KEY (masv) REFERENCES SV(masv),
    FOREIGN KEY (mamon) REFERENCES MON(mamon) 
);
ALTER TABLE SV 
ADD gioitinh NVARCHAR(3) CHECK (gioitinh IN ('nam', 'nữ'));

ALTER TABLE SV
ADD ghichu NVARCHAR(255);
ALTER TABLE SV
DROP COLUMN ghichu;
ALTER TABLE SV
ADD Lop NVACHAR(30);
ALTER TABLE MON
ALTER COLUMN tenmon NVARCHAR(25);

ALTER TABLE SV
ADD CONSTRAINT NamSinh CHECK (YEAR(ns) < YEAR(GETDATE()));
ALTER TABLE SV
DROP CONSTRAINT NamSinh ;
INSERT INTO SV (masv,hoten,ns,qq)values ('1',N'Lê Thị Phương Hoa' ,'2003/10/26', N'bac giang '),
('2',N'Lê Thị Phương H' ,'2003/10/27', N'ninh binh '),('3',N'Tran thi hong anh' ,'2003/05/18', N'nam dinh '),
('4',N'pham thi kim dung' ,'2003/10/02', N'vp '),('5',N'do thi phuong thao' ,'2003/11/26', N'ninh binh '),
('6',N'Lê Thị thanh tam' ,'2003/04/24', N'bac giang '),('7',N'nhu quynh' ,'2003/01/01', N'bac giang '),
('8',N'thu huong' ,'2003/07/27', N'bac giang '),('9',N'huong' ,'2003/07/27', N'ninh binh ')
SELECT * FROM SV;
INSERT INTO MON (mamon,tenmon,sotc) values ('1',N'CSDL','3'),('2',N'CSDL phan tan','3'),
('3',N'sql','3'),('4',N'tin hoc','2'),('5',N'C++','1')
SELECT * FROM MON;
INSERT INTO KETQUA(masv,mamon,diem) values ('1','1','9'),('2','2','9'),('3','1','7'),('4','2','9'),
('5','1','10'),('6','1','8'),('7','1','6'),  ('8','3','5')
SELECT  * FROM KETQUA;
/* vd1 */
SELECT masv, hoten, ns,qq FROM SV
/* vd2*/
SELECT * FROM SV WHERE (qq='bac giang')
/* vd3*/
SELECT  QLyDiem.masv, hoten as 'thu huong'FROM SV as QlyDiem
/* VD 4.1: Cho danh sách các sinh viên có tên là ‘nhu quynh’*/
SELECT * FROM SV where hoten like N'% nhu quynh'
/* VD 4.2: Cho danh sách những sinh viên họ Lê*/
SELECT * FROM SV where hoten like N'Lê %'
/* vd5*/
SELECT masv, mamon FROM KETQUA WHERE  diem between 7 and 9
/* vd6*/
SELECT masv, mamon FROM ketqua WHERE diem is Null
/* vd7*/
SELECT * FROM SV where qq in (N'bac giang', N'nam dinh')
/* VD 8.1: Liệt kê danh sách các tỉnh có sinh viên theo học tại
trường*/
SELECT DISTINCT qq from SV
/* VD 8.2: Cho thông tin của hai sinh viên đầu tiên trong danh
sách sinh viên*/
select top (2) masv,hoten,ns,qq from SV
--VD 9:tổng điểm . điểm max/min, điểm TB--
SELECT SUM(diem) AS [TỔNG ĐIỂM], MAX(diem) AS [ĐIỂM CAO NHẤT],
MIN(diem) AS [ĐIỂM THẤP NHẤT], AVG(diem) AS[ĐIỂM TB] FROM KETQUA
/* dua ra sv co 2 đầu điểm trở lên */
SELECT masv, count (diem) AS [So sinh vien]
FROM KETQUA
GROUP BY masv
HAVING Count (diem) >= 2

--đưa ra mã sv của những sv có điểm cao nhất lớp
-- with ties laf tìm những gtri có cùng 1 giá trị min or max
SELECT TOP 1 WITH TIES diem , masv, mamon
from KETQUA
ORDER BY diem ASC
