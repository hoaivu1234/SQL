/*============================== CREATE DATABASE =======================================*/
/*======================================================================================*/
DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;

/*============================== CREATE TABLE=== =======================================*/
/*======================================================================================*/

-- create table 1: Department
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	DepartmentID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    DepartmentName 			NVARCHAR(30) NOT NULL UNIQUE KEY
);

-- create table 2: Posittion
DROP TABLE IF EXISTS Position;
CREATE TABLE `Position` (
	PositionID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName			ENUM('Dev','Test','Scrum Master','PM') NOT NULL UNIQUE KEY
);

-- create table 3: Account
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	AccountID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email					VARCHAR(50) NOT NULL UNIQUE KEY,
    Username				VARCHAR(50) NOT NULL UNIQUE KEY,
    FullName				NVARCHAR(50) NOT NULL,
    DepartmentID 			TINYINT UNSIGNED NOT NULL,
    PositionID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

-- create table 4: Group
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName				NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID				TINYINT UNSIGNED,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CreatorID) 	REFERENCES `Account`(AccountId)
);

-- create table 5: GroupAccount
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
	GroupID					TINYINT UNSIGNED NOT NULL,
    AccountID				TINYINT UNSIGNED NOT NULL,
    JoinDate				DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID,AccountID),
    FOREIGN KEY(GroupID) 		REFERENCES `Group`(GroupID) 
);

-- create table 6: TypeQuestion
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
    TypeID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName 		ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);

-- create table 7: CategoryQuestion
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
    CategoryID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CategoryName			NVARCHAR(50) NOT NULL UNIQUE KEY
);

-- create table 8: Question
DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
    QuestionID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    TypeID					TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) 	REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) 		REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY(CreatorID) 		REFERENCES `Account`(AccountId) 
);

-- create table 9: Answer
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
    AnswerID				TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    QuestionID				TINYINT UNSIGNED NOT NULL,
    isCorrect				BIT DEFAULT 1,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

-- create table 10: Exam
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
    ExamID					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `Code`					CHAR(10) NOT NULL,
    Title					NVARCHAR(50) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    Duration				TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(CreatorID) 	REFERENCES `Account`(AccountId)
);

-- create table 11: ExamQuestion
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
    ExamID				TINYINT UNSIGNED NOT NULL,
	QuestionID			TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID),
    FOREIGN KEY(ExamID) REFERENCES Exam(ExamID) ,
    PRIMARY KEY (ExamID,QuestionID)
);

/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/
-- Add data Department
INSERT INTO Department(DepartmentName) 
VALUES
						(N'Marketing'	),
						(N'Sale'		),
						(N'Bảo vệ'		),
						(N'Nhân sự'		),
						(N'Kỹ thuật'	),
						(N'Tài chính'	),
						(N'Phó giám đốc'),
						(N'Giám đốc'	),
						(N'Thư kí'		),
						(N'Bán hàng'	);
    
-- Add data position
INSERT INTO Position	(PositionName	) 
VALUES 					('Dev'			),
						('Test'			),
						('Scrum Master'	),
						('PM'			); 


-- Add data Account
INSERT INTO `Account`(Email								, Username			, FullName				, DepartmentID	, PositionID, CreateDate)
VALUES 				('haidang29productions@gmail.com'	, 'dangblack'		,'Nguyễn hải Đăng'		,   '5'			,   '1'		,'2020-03-05'),
					('account1@gmail.com'				, 'quanganh'		,'Nguyen Chien Thang2'	,   '1'			,   '2'		,'2020-03-05'),
                    ('account2@gmail.com'				, 'vanchien'		,'Nguyen Van Chien'		,   '2'			,   '3'		,'2020-03-07'),
                    ('account3@gmail.com'				, 'cocoduongqua'	,'Duong Do'				,   '3'			,   '4'		,'2020-03-08'),
                    ('account4@gmail.com'				, 'doccocaubai'		,'Nguyen Chien Thang1'	,   '4'			,   '4'		,'2020-03-10'),
                    ('dapphatchetngay@gmail.com'		, 'khabanh'			,'Ngo Ba Kha'			,   '6'			,   '3'		,'2020-04-05'),
                    ('songcodaoly@gmail.com'			, 'huanhoahong'		,'Bui Xuan Huan'		,   '7'			,   '2'		, NULL		),
                    ('sontungmtp@gmail.com'				, 'tungnui'			,'Nguyen Thanh Tung'	,   '8'			,   '1'		,'2020-04-07'),
                    ('duongghuu@gmail.com'				, 'duongghuu'		,'Duong Van Huu'		,   '9'			,   '2'		,'2020-04-07'),
                    ('vtiaccademy@gmail.com'			, 'vtiaccademy'		,'Vi Ti Ai'				,   '10'		,   '1'		,'2020-04-09');

-- Add data Group
INSERT INTO `Group`	(  GroupName			, CreatorID		, CreateDate)
VALUES 				(N'Testing System'		,   5			,'2019-03-05'),
					(N'Development'			,   1			,'2020-03-07'),
                    (N'VTI Sale 01'			,   2			,'2020-03-09'),
                    (N'VTI Sale 02'			,   3			,'2020-03-10'),
                    (N'VTI Sale 03'			,   4			,'2020-03-28'),
                    (N'VTI Creator'			,   6			,'2020-04-06'),
                    (N'VTI Marketing 01'	,   7			,'2020-04-07'),
                    (N'Management'			,   8			,'2020-04-08'),
                    (N'Chat with love'		,   9			,'2020-04-09'),
                    (N'Vi Ti Ai'			,   10			,'2020-04-10');

-- Add data GroupAccount
INSERT INTO `GroupAccount`	(  GroupID	, AccountID	, JoinDate	 )
VALUES 						(	1		,    1		,'2019-03-05'),
							(	1		,    2		,'2020-03-07'),
							(	3		,    3		,'2020-03-09'),
							(	3		,    4		,'2020-03-10'),
							(	5		,    5		,'2020-03-28'),
							(	1		,    3		,'2020-04-06'),
							(	1		,    7		,'2020-04-07'),
							(	8		,    3		,'2020-04-08'),
							(	1		,    9		,'2020-04-09'),
							(	10		,    10		,'2020-04-10');


-- Add data TypeQuestion
INSERT INTO TypeQuestion	(TypeName			) 
VALUES 						('Essay'			), 
							('Multiple-Choice'	); 


-- Add data CategoryQuestion
INSERT INTO CategoryQuestion		(CategoryName	)
VALUES 								('Java'			),
									('ASP.NET'		),
									('ADO.NET'		),
									('SQL'			),
									('Postman'		),
									('Ruby'			),
									('Python'		),
									('C++'			),
									('C Sharp'		),
									('PHP'			);
													
-- Add data Question
INSERT INTO Question	(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUES 					(N'Câu hỏi về Java ',	1		,   '1'			,   '2'		,'2020-04-05'),
						(N'Câu Hỏi về PHP'	,	10		,   '2'			,   '2'		,'2020-04-05'),
						(N'Hỏi về C#'		,	9		,   '2'			,   '3'		,'2020-04-06'),
						(N'Hỏi về Ruby'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(N'Hỏi về Postman'	,	5		,   '1'			,   '5'		,'2020-04-06'),
						(N'Hỏi về ADO.NET'	,	3		,   '2'			,   '6'		,'2020-04-06'),
						(N'Hỏi về ASP.NET'	,	2		,   '1'			,   '7'		,'2020-04-06'),
						(N'Hỏi về C++'		,	8		,   '1'			,   '8'		,'2020-04-07'),
						(N'Hỏi về SQL'		,	4		,   '2'			,   '9'		,'2020-04-07'),
						(N'Hỏi về Python'	,	7		,   '1'			,   '10'	,'2020-04-07');

-- Add data Answers
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUES 				(N'Trả lời 01'	,   1			,	0		),
					(N'Trả lời 02'	,   1			,	1		),
                    (N'Trả lời 03'	,   1			,	0		),
                    (N'Trả lời 04'	,   1			,	1		),
                    (N'Trả lời 05'	,   2			,	1		),
                    (N'Trả lời 06'	,   3			,	1		),
                    (N'Trả lời 07'	,   4			,	0		),
                    (N'Trả lời 08'	,   8			,	0		),
                    (N'Trả lời 09'	,   9			,	1		),
                    (N'Trả lời 10'	,   10			,	1		);
	
-- Add data Exam
INSERT INTO Exam	(`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('VTIQ001'		, N'Đề thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
					('VTIQ002'		, N'Đề thi PHP'			,	10			,	60		,   '2'			,'2019-04-05'),
                    ('VTIQ003'		, N'Đề thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
                    ('VTIQ004'		, N'Đề thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
                    ('VTIQ005'		, N'Đề thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
                    ('VTIQ006'		, N'Đề thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
                    ('VTIQ007'		, N'Đề thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
                    ('VTIQ008'		, N'Đề thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
                    ('VTIQ009'		, N'Đề thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
                    ('VTIQ010'		, N'Đề thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');
                    
                    
-- Add data ExamQuestion
INSERT INTO ExamQuestion(ExamID	, QuestionID	) 
VALUES 					(	1	,		5		),
						(	2	,		10		), 
						(	3	,		4		), 
						(	4	,		3		), 
						(	5	,		7		), 
						(	6	,		10		), 
						(	7	,		2		), 
						(	8	,		10		), 
						(	9	,		9		), 
						(	10	,		8		); 
                        
-- lấy ra thông tin account có full name dài nhất
SELECT 		* 
FROM 		`Account` 
WHERE 		LENGTH(FullName) = (SELECT MAX(LENGTH(FullName)) FROM `Account`)
ORDER BY 	Fullname DESC;

-- : Lấy ra thông tin account có full name dài nhất và thuộc PositionID có id= 4
WITH cte_dep3 AS
(
SELECT * FROM `Account` WHERE PositionID =4
)
SELECT * FROM `cte_dep3` 
WHERE LENGTH(Fullname) = (SELECT MAX(LENGTH(Fullname)) FROM `cte_dep3`) 
ORDER BY Fullname ASC;

-- Lấy ra tên group đã tạo trước ngày 7/4/2020
SELECT * FROM `Group`;
SELECT 		GROUPNAME 
FROM 		`Group`
WHERE 		CreateDate <'2020-04-07'

--  Lấy ra ID của question có >= 4 câu trả lời

SELECT * FROM Answer AS A INNER JOIN  (SELECT QuestionID FROM Answer
GROUP BY QuestionID HAVING COUNT(QuestionID)>=4) AS B WHERE A.QuestionID=B.QuestionID

-- Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT 		*
FROM 		EXAM
WHERE 		Duration>=60 AND CreateDate<'2019-12-20'

-- Lấy ra 5 group được tạo gần đây nhất
SELECT  	*
FROM 		`Group`
ORDER BY 	CreateDate DESC
LIMIT 5;

--  Đếm số nhân viên thuộc department có id = 2

SELECT 		DepartmentID,COUNT(AccountID) AS SL
FROM 		`ACCOUNT`
WHERE 		DepartmentID=2;
SELECT * FROM `ACCOUNT`;

--  Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT 		* 
FROM 		`ACCOUNT`
WHERE 		FullName LIKE "%DO%"

-- Xóa tất cả các exam được tạo trước ngày 20/12/2019
ALTER TABLE EXAM
DELETE		
FROM		EXAM
WHERE 		CreateDate <'2019-12-20'
select * from `GroupAccount` 
-- Question 13: xóa tất cả các Account có FullName bắt đầu bằng 2 từ "Nguyễn Hải"
DELETE 
FROM 		`Account`
WHERE 		(SUBSTRING_INDEX(FullName,' ',2)) = 'Nguyễn Hải';

-- Question 14: update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE 		`Account` 
SET 		Fullname 	= 	N'Nguyễn Bá Lộc', 
			Email 		= 	'loc.nguyenba@vti.com.vn'
WHERE 		AccountID = 5;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4
UPDATE 		`GroupAccount` 
SET 		AccountID = 5 
WHERE 		GroupID = 4;

-- buổi 4
-- : Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT 		*
FROM 		`Account` A
INNER JOIN 	DEPARTMENT D
ON 			A.DepartmentID = D.DepartmentID	

-- Viết lệnh để lấy ra thông tin các account được tạo sau ngày 9/3/2020
SELECT 		*
FROM 		`Account` A
WHERE 		CreateDate >'2020-03-09'
ORDER BY	CreateDate DESC

-- viết lệnh để lấy ra tất cả các developer 
SELECT		*
FROM		`Account` A 
INNER JOIN 	Position P 
ON			A.PositionID = P.PositionID
WHERE		P.PositionName = 'Dev';

--  Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT 		D.DepartmentID, D.DepartmentName, COUNT(A.DepartmentID) AS 'SO LUONG'
FROM 		`Account` A 
INNER JOIN 	Department  D ON D.DepartmentID = A.DepartmentID
GROUP BY 	A.DepartmentID
HAVING 		COUNT(A.DepartmentID) > 3;

--  Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
-- SELECT *FROM EXAM;
-- SELECT *FROM QUESTION;
SELECT 		Q.QuestionID,Q.Content,Q.CategoryID,Q.TypeID,Q.CreatorID,Q.CreateDate,COUNT(E.CategoryID) AS SL
FROM 		EXAM E
INNER JOIN 	QUESTION Q
ON 			E.CategoryID=Q.CategoryID
GROUP BY	E.CategoryID
ORDER BY  	COUNT(E.CategoryID) DESC
limit 		1

-- : Thông kê mỗi Category Question được sử dụng trong bao nhiêu Question
SELECT *FROM CategoryQuestion ORDER BY CategoryID ASC
SELECT *FROM Question

SELECT 		C.CategoryID,C.CategoryName,COUNT(Q.CategoryID) AS SL
FROM 		CategoryQuestion C
INNER JOIN	Question Q
ON 			C.CategoryID=Q.CategoryID
GROUP BY	Q.CategoryID

-- Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
I
SELECT *FROM Question,EXAMQuestion
SELECT *FROM EXAMQuestion

SELECT Q.Content, COUNT(EQ.QuestionID) AS 'SO LUONG'
FROM Question Q 
LEFT JOIN ExamQuestion EQ ON EQ.QuestionID = Q.QuestionID
GROUP BY Q.QuestionID
ORDER BY EQ.ExamID ASC;

-- Lấy ra Question có nhiều câu trả lời nhất
SELECT *FROM QUESTION
SELECT *FROM ANSWER
SELECT 		Q.QuestionID,Q.Content,COUNT(A.QuestionID) AS SL
FROM		QUESTION Q
INNER JOIN	ANSWER A
ON 			Q.QuestionID=A.QuestionID
GROUP BY 	A.QuestionID
ORDER BY	COUNT(A.QuestionID) DESC
LIMIT 		1

--  Thống kê số lượng account trong mỗi group
SELECT *FROM `GroupAccount`

SELECT 		GroupID,COUNT(AccountID) 
FROM		`GroupAccount`
GROUP BY	GroupID

-- Tìm chức vụ có ít người nhất
SELECT * FROM POSITION
SELECT * FROM `Account`


SELECT P.PositionID, P.PositionName, count( A.PositionID) AS SL FROM account A
INNER JOIN position P ON A.PositionID = P.PositionID
GROUP BY A.PositionID
HAVING count(A.PositionID)= (SELECT MIN(minP) FROM(
SELECT count(B.PositionID) AS minP FROM account B
GROUP BY B.PositionID) AS minPA);

--  Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT *FROM DEPARTMENT
SELECT * FROM POSITION
SELECT * FROM `Account`

SELECT d.DepartmentID,d.DepartmentName, p.PositionName, count(p.PositionName) FROM `account` a
INNER JOIN department d ON a.DepartmentID = d.DepartmentID
INNER JOIN position p ON a.PositionID = p.PositionID
GROUP BY d.DepartmentID, p.PositionID
ORDER BY d.DepartmentID ASC

-- Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …

SELECT 		Q.QuestionID, Q.Content, A.FullName, TQ.TypeName AS Author, ANS.Content FROM question Q
INNER JOIN 	categoryquestion CQ ON Q.CategoryID = CQ.CategoryID
INNER JOIN 	typequestion TQ ON Q.TypeID = TQ.TypeID
INNER JOIN 	account A ON A.AccountID = Q.CreatorID
INNER JOIN 	Answer AS ANS ON Q.QuestionID = ANS.QuestionID
ORDER BY 	Q.QuestionID ASC

--  Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm

SELECT * FROM QUESTION
SELECT *FROM TYPEQUESTION

SELECT 		TQ.TypeName, COUNT(Q.TypeID) AS SL
FROM 		QUESTION Q
INNER JOIN	TYPEQUESTION TQ
ON			Q.TypeID=TQ.TypeID
GROUP BY	Q.TypeID

-- Lấy ra group không có account nào

SELECT *FROM `GROUPACCOUNT`
SELECT *FROM `GROUP`

SELECT 		G.GroupID,G.GroupName 	
FROM		`GROUP` G
LEFT JOIN	`GROUPACCOUNT` GA
ON			GA.GroupID=G.GroupID
WHERE   	GA.AccountID IS NULL;	

--  Lấy ra question không có answer nào
SELECT * FROM QUESTION
SELECT * FROM ANSWER
SELECT 		Q.QuestionID,Q.Content
FROM		QUESTION Q
LEFT JOIN	ANSWER A
ON			A.QuestionID=Q.QuestionID
WHERE		A.Content IS NULL

-- Lấy các account thuộc nhóm thứ 1
SELECT *FROM `GroupAccount`
SELECT  	* 
FROM		`ACCOUNT` A
INNER JOIN	`GroupAccount` GA
ON 			GA.AccountID=A.AccountID
WHERE		GA.GROUPID =1
-- Lấy các account thuộc nhóm thứ 2
SELECT  	* 
FROM		`ACCOUNT` A
INNER JOIN	`GroupAccount` GA
ON 			GA.AccountID=A.AccountID
WHERE		GA.GROUPID =2
-- Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT A.FullName
FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1
UNION
SELECT A.FullName
FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;


SELECT g.GroupName, COUNT(ga.GroupID) AS SL
FROM GroupAccount ga
JOIN `Group` g ON ga.GroupID = g.GroupID
GROUP BY g.GroupID
HAVING COUNT(ga.GroupID) >= 5;

-- : Tạo view có chứa danh sách nhân viên thuộc phòng ban BAO VE

CREATE VIEW DSNV AS
	SELECT 		A.*, D.DepartmentName
	FROM		`ACCOUNT` A
	INNER JOIN	DEPARTMENT D
	ON 			A.DepartmentID=D.DepartmentID
	WHERE		D.DepartmentName='Bảo vệ'
SELECT *FROM	DSNV
-- Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
SELECT *FROM `ACCOUNT`
SELECT *FROM `GROUPACCOUNT`

CREATE VIEW TTAC AS
SELECT 		A.AccountID,A.FullName,COUNT(GA.AccountID) AS SL
FROM		`ACCOUNT` A
INNER JOIN	`GROUPACCOUNT` GA
ON 			A.AccountID=GA.AccountID
GROUP BY	GA.AccountID
HAVING		COUNT(GA.AccountID)=(SELECT MAX(SL) FROM(
									SELECT 		A.AccountID,COUNT(GA.AccountID) AS SL
									FROM		`ACCOUNT` A
									INNER JOIN	`GROUPACCOUNT` GA
									ON 			A.AccountID=GA.AccountID
									GROUP BY	GA.AccountID) AS K)
SELECT *FROM TTAC
--  Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
CREATE VIEW CONTENTDAI AS
SELECT		*
FROM		QUESTION Q
WHERE		LENGTH(Q.Content)>18
DELETE FROM CONTENTDAI

-- Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS PHONGBAN;
DELIMITER $$
CREATE PROCEDURE PHONGBAN(IN IN_DEPARTMENT_NAME VARCHAR(30),OUT OUT_DS_ACCOUNT VARCHAR(50))
	BEGIN
		SELECT 		A.FullName INTO OUT_DS_ACCOUNT
        FROM		`ACCOUNT` A
        INNER JOIN	DEPARTMENT D
        ON 			A.DepartmentID=D.DepartmentID
        WHERE		D.DepartmentName='Bán hàng';
	END$$
DELIMITER ;
SELECT *FROM DEPARTMENT
SELECT *FROM	`ACCOUNT`

--  Tạo store để in ra số lượng account trong mỗi group
SELECT *FROM `ACCOUNT`
SELECT *FROM `GROUPACCOUNT`

use testingsystem
DROP PROCEDURE IF EXISTS SLAC
DELIMITER $$
CREATE PROCEDURE SLAC()
	BEGIN
		SELECT 		GA.GroupID,COUNT(GA.AccountID) AS SL
        FROM		`GROUPACCOUNT` GA
        INNER JOIN	`ACCOUNT` A
        ON 			A.AccountID=GA.AccountID
        GROUP BY	GA.GroupID;
	END$$
DELIMITER ;

--  Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
SELECT *FROM QUESTION
SELECT *FROM TYPEQUESTION
DROP PROCEDURE IF EXISTS SLQS
DELIMITER $$
CREATE PROCEDURE SLQS()
	BEGIN	
		SELECT 		TQ.TypeName,COUNT(Q.TypeID)
        FROM 		QUESTION Q
        INNER JOIN	TYPEQUESTION TQ
        ON 			Q.TypeID=TQ.TypeID
	    WHERE 		month(q.CreateDate) = month(now()) 
        GROUP BY 	Q.TypeID;
	END$$
DELIMITER ;

--  Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào 
-- hoặc trả về user có username chứa  chuỗi của người dùng nhập vào

SELECT *FROM `GROUP`
SELECT *FROM `ACCOUNT`

DROP PROCEDURE IF EXISTS TRAVETEN
DELIMITER $$
CREATE PROCEDURE TRAVETEN(IN IN_CHUOI VARCHAR(50))
		BEGIN	
			SELECT 		GroupName
            FROM		`GROUP`
            WHERE 		GroupName LIKE CONCAT("%",IN_CHUOI,"%")
            UNION
            SELECT		Username
            FROM		`ACCOUNT`
            WHERE		Username LIKE CONCAT("%",IN_CHUOI,"%");
		END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_getNameAccOrNameGroup_Union;
DELIMITER $$
CREATE PROCEDURE sp_getNameAccOrNameGroup_Union
( IN var_String VARCHAR(50))
BEGIN
SELECT g.GroupName AS Name_Group_Username FROM `group` g WHERE 
g.GroupName LIKE CONCAT("%",var_String,"%")
 UNION
SELECT a.Username FROM `account` a WHERE a.Username LIKE 
CONCAT("%",var_String,"%");
END$$
DELIMITER ;

--  Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
-- trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công


DROP PROCEDURE IF EXISTS sp_insertAccount;
DELIMITER $$
CREATE PROCEDURE sp_insertAccount
( IN var_Email VARCHAR(50),
IN var_Fullname VARCHAR(50))
BEGIN
DECLARE v_Username VARCHAR(50) DEFAULT SUBSTRING_INDEX(var_Email, '@', 1);
DECLARE v_DepartmentID TINYINT UNSIGNED DEFAULT 11;
DECLARE v_PositionID TINYINT UNSIGNED DEFAULT 1;
 DECLARE v_CreateDate DATETIME DEFAULT now();
 
INSERT INTO `account` (`Email`, `Username`, `FullName`, 
`DepartmentID`, `PositionID`, `CreateDate`) 
VALUES (var_Email, v_Username, var_Fullname, 
v_DepartmentID, v_PositionID, v_CreateDate);
END$$
DELIMITER ;

-- Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo 
 -- trước 1 năm trước
 
DROP TRIGGER IF EXISTS Trg_CheckInsertGroup;
DELIMITER $$
CREATE TRIGGER Trg_CheckInsertGroup
 BEFORE INSERT ON `Group`
 FOR EACH ROW
 BEGIN
 DECLARE v_CreateDate DATETIME;
 SET v_CreateDate = DATE_SUB(NOW(), interval 1 year);
IF (NEW.CreateDate <= v_CreateDate) THEN
SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'Cant create this group';
END IF;
 END$$
DELIMITER ;
INSERT INTO `group` (`GroupName`, `CreatorID`, `CreateDate`) 
VALUES ('VAICALON', '1', '2018-04-10 00:00:00');
SELECT *FROM `GROUP`
