CREATE TABLE "individual"(
    "IndividualID" SERIAL NOT NULL,
    "Name" VARCHAR(255) NOT NULL,
    "Register date" DATE NOT NULL,
    "Passport Code" VARCHAR(255) NOT NULL,
    "Phone number" VARCHAR(255) NOT NULL,
    "Email" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "individual" ADD PRIMARY KEY("IndividualID");
CREATE TABLE "credit account"(
    "CreditAccountID" SERIAL,
    "IndividualID" BIGINT,
    "LegalID" BIGINT,
    "Percent" BIGINT NOT NULL,
    "Debt" BIGINT NOT NULL
);
ALTER TABLE
    "credit account" ADD PRIMARY KEY("CreditAccountID");
CREATE TABLE "checking/current account"(
    "CheckingAccountID" SERIAL,
    "IndividualID" BIGINT,
    "LegalID" BIGINT,
    "Balance" BIGINT NOT NULL
);
ALTER TABLE
    "checking/current account" ADD PRIMARY KEY("CheckingAccountID");
CREATE TABLE "legal entity"(
    "LegalID" SERIAL NOT NULL,
    "Entity Name" TEXT NOT NULL,
    "Entity Type" VARCHAR(255) NOT NULL,
    "business_email" VARCHAR(255) NOT NULL,
    "Phone number" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "legal entity" ADD PRIMARY KEY("LegalID");
CREATE TABLE "Operations"(
    "OperationID" SERIAL NOT NULL,
    "ChekingAccountID" BIGINT,
    "CreditAccountID" BIGINT,
    "Sum" DECIMAL(8, 2) NOT NULL,
    "valid_from" DATE NOT NULL,
    "valid_to" DATE NOT NULL
);
ALTER TABLE
    "Operations" ADD PRIMARY KEY("OperationID");
ALTER TABLE
    "checking/current account" ADD CONSTRAINT "checking/current account_legalid_foreign" FOREIGN KEY("LegalID") REFERENCES "legal entity"("LegalID");
ALTER TABLE
    "credit account" ADD CONSTRAINT "credit account_individualid_foreign" FOREIGN KEY("IndividualID") REFERENCES "individual"("IndividualID");
ALTER TABLE
    "Operations" ADD CONSTRAINT "operations_creditaccountid_foreign" FOREIGN KEY("CreditAccountID") REFERENCES "credit account"("CreditAccountID");
ALTER TABLE
    "credit account" ADD CONSTRAINT "credit account_legalid_foreign" FOREIGN KEY("LegalID") REFERENCES "legal entity"("LegalID");
ALTER TABLE
    "Operations" ADD CONSTRAINT "operations_chekingaccountid_foreign" FOREIGN KEY("ChekingAccountID") REFERENCES "checking/current account"("CheckingAccountID");
ALTER TABLE
    "checking/current account" ADD CONSTRAINT "checking/current account_idividualid_foreign" FOREIGN KEY("IndividualID") REFERENCES "individual"("IndividualID");

CREATE INDEX "checking_account_id_index" ON
    "Operations"("ChekingAccountID");
CREATE INDEX "credit_account_id_index" ON
    "Operations"("CreditAccountID");

CREATE VIEW IndividualView AS
    SELECT "IndividualID",
    "Name",
    "Register date",
    '********' AS "Passport Code",
    CONCAT('***-***-', SUBSTR("Phone number", LENGTH("Phone number") - 3)) AS "Phone number",
    CONCAT(SUBSTRING("Email", 1, 2), '****', SUBSTR("Email", LENGTH("Email") - 3)) AS "Email"
FROM "individual";

CREATE VIEW LegalView AS
    SELECT "LegalID",
    "Entity Name",
    "Phone number",
    CONCAT(SUBSTRING("business_email", 1, 2), '****', SUBSTR("business_email", LENGTH("business_email") - 3)) AS "business_email"
FROM "legal entity";

INSERT INTO "individual" ("IndividualID", "Name", "Register date", "Passport Code", "Phone number", "Email") 
VALUES
(1, 'Alice Johnson', '2022-01-10', 'AB123456', '123-456-7890', 'alice@email.com'),
(2, 'Bob Smith', '2021-12-15', 'CD789012', '234-567-8901', 'bob@email.com'),
(3, 'Charlie Brown', '2021-11-20', 'EF345678', '345-678-9012', 'charlie@email.com'),
(4, 'David Lee', '2021-10-25', 'GH901234', '456-789-0123', 'david@email.com'),
(5, 'Emma Davis', '2021-09-30', 'IJ567890', '567-890-1234', 'emma@email.com'),
(6, 'Frank Wilson', '2021-08-05', 'KL123456', '678-901-2345', 'frank@email.com'),
(7, 'Grace Martinez', '2021-07-10', 'MN789012', '789-012-3456', 'grace@email.com'),
(8, 'Henry Taylor', '2021-06-15', 'OP345678', '890-123-4567', 'henry@email.com'),
(9, 'Ivy Anderson', '2021-05-20', 'QR901234', '901-234-5678', 'ivy@email.com'),
(10, 'Jack Brown', '2021-04-25', 'ST567890', '012-345-6789', 'jack@email.com'),
(11, 'Kate Johnson', '2021-03-30', 'UV123456', '123-456-7890', 'kate@email.com'),
(12, 'Liam Davis', '2021-02-05', 'WX789012', '234-567-8901', 'liam@email.com'),
(13, 'Mia Garcia', '2021-01-10', 'YZ345678', '345-678-9012', 'mia@email.com'),
(14, 'Noah Martinez', '2020-12-15', 'AB901234', '456-789-0123', 'noah@email.com'),
(15, 'Olivia Wilson', '2020-11-20', 'CD567890', '567-890-1234', 'olivia@email.com'),
(16, 'Parker Brown', '2020-10-25', 'EF123456', '678-901-2345', 'parker@email.com'),
(17, 'Quinn Lee', '2020-09-30', 'GH789012', '789-012-3456', 'quinn@email.com'),
(18, 'Riley Johnson', '2020-08-05', 'IJ345678', '890-123-4567', 'riley@email.com'),
(19, 'Sophia Taylor', '2020-07-10', 'KL901234', '901-234-5678', 'sophia@email.com'),
(20, 'Tyler Garcia', '2020-06-15', 'MN567890', '012-345-6789', 'tyler@email.com');

INSERT INTO "legal entity" ("LegalID", "Entity Name", "Entity Type", "business_email", "Phone number") 
VALUES
(1, 'ABC Corporation', 'public', 'abc@example.com', '123-456-7890'),
(2, 'XYZ Co.', 'private', 'xyz@example.com', '456-789-0123'),
(3, '123 Industries', 'public', '123@example.com', '789-012-3456'),
(4, 'Tech Innovations', 'private', 'tech@example.com', '012-345-6789'),
(5, 'Global Solutions', 'public', 'global@example.com', '345-678-9012'),
(6, 'Sunshine Enterprises', 'private', 'sunshine@example.com', '678-901-2345'),
(7, 'Moonlight Co.', 'public', 'moonlight@example.com', '901-234-5678'),
(8, 'Blue Sky Corporation', 'private', 'blue@example.com', '234-567-8901'),
(9, 'Silver Lining Solutions', 'public', 'silver@example.com', '567-890-1234'),
(10, 'Green Earth Inc.', 'private', 'green@example.com', '890-123-4567'),
(11, 'Rainbow Enterprises', 'public', 'rainbow@example.com', '123-456-7890'),
(12, 'Golden Opportunities', 'private', 'golden@example.com', '456-789-0123'),
(13, 'Purple Mountains Co.', 'public', 'purple@example.com', '789-012-3456'),
(14, 'Black Diamond Corporation', 'private', 'black@example.com', '012-345-6789'),
(15, 'White Sands Enterprises', 'public', 'white@example.com', '345-678-9012'),
(16, 'Ocean Blue Solutions', 'private', 'ocean@example.com', '678-901-2345'),
(17, 'Red Fire Co.', 'public', 'red@example.com', '901-234-5678'),
(18, 'Yellow Sun Corporation', 'private', 'yellow@example.com', '234-567-8901'),
(19, 'Orange Sky Solutions', 'public', 'orange@example.com', '567-890-1234'),
(20, 'Pink Blossom Inc.', 'private', 'pink@example.com', '890-123-4567');

INSERT INTO "checking/current account" ("CheckingAccountID", "IndividualID", "LegalID", "Balance") 
VALUES 
(1, 5, NULL, 1300),
(2, 15, NULL, 350),
(3, NULL, 10, 800),
(4, 10, NULL, 1900),
(5, NULL, 8, 1050),
(6, 18, NULL, 1050),
(7, 3, NULL, 700),
(8, NULL, 17, 1650),
(9, 7, NULL, 550),
(10, 2, NULL, 600),
(11, 13, NULL,2850),
(12, 5, NULL, 0),
(13, 16, NULL, 1250),
(14, 4, NULL, 0),
(15, NULL, 20, 1550),
(16, 10, NULL, 50),
(17, 1, NULL, 1100),
(18, 11, NULL, 800),
(19, 9, NULL, 2000),
(20, NULL, 6, 800),
(21, 14, NULL, 450),
(22, 8, NULL, 0),
(23, 12, NULL, 450),
(24, NULL, 19, 0),
(25, 6, NULL, 0);

INSERT INTO "credit account" ("CreditAccountID", "IndividualID", "LegalID", "Percent", "Debt") 
VALUES 
(1, 5, NULL, 10, -5000),
(2, NULL, 12, 8, -7000),
(3, 7, NULL, 12, -3000),
(4, 15, NULL, 15, -9000),
(5, 10, NULL, 9, -4000),
(6, NULL, 8, 11, -6000),
(7, 3, NULL, 16, -2000),
(8, 20, NULL, 14, -8000),
(9, 13, NULL, 7, -7000),
(10, NULL, 4, 13, -5000),
(11, 2, NULL, 17, -7000),
(12, 1, NULL, 6, -2000),
(13, 6, NULL, 10, -6000),
(14, NULL, 16, 8, -7000),
(15, 18, NULL, 11, -3000),
(16, 11, NULL, 15, -9000),
(17, 17, NULL, 9, -4000),
(18, NULL, 14, 12, -6000),
(19, 9, NULL, 16, -2000),
(20, 19, NULL, 14, -8000),
(21, 5, NULL, 10, -5000),
(22, NULL, 12, 8, -7000),
(23, 7, NULL, 12, -3000),
(24, 15, NULL, 15, -9000),
(25, 10, NULL, 9, -4000),
(26, NULL, 8, 11, -6000),
(27, 3, NULL, 16, -7000),
(28, 20, NULL, 14, -8000),
(29, 13, NULL, 7, -1000),
(30, NULL, 4, 13, -5000),
(31, 2, NULL, 17, -10000),
(32, 1, NULL, 6, -2000),
(33, 6, NULL, 10, -6000),
(34, NULL, 16, 8, -7000),
(35, 18, NULL, 11, -3000);

INSERT INTO "Operations" ("OperationID", "ChekingAccountID", "CreditAccountID", "Sum", "valid_from", "valid_to") 
VALUES
(1, 5, NULL, 500, '2022-01-13', '2022-01-15'),
(2, NULL, 14, -7950, '2022-01-14', '2022-01-16'),
(3, 7, NULL, 700, '2022-01-15', '9999-12-31'),
(4, NULL, 22, -8000, '2022-01-16', '2022-01-18'),
(5, 10, NULL, 200, '2022-01-17', '2022-03-01'),
(6, NULL, 8, -8000, '2022-01-19', '9999-12-31'),
(7, 3, NULL, 800, '2022-01-20', '9999-12-31'),
(8, NULL, 20, -8250, '2022-01-21', '2022-03-02'),
(9, 16, NULL, 350, '2022-01-22', '2022-01-25'),
(10, NULL, 30, -5800, '2022-01-24', '2022-01-26'),
(11, 12, NULL, -750, '2022-01-25', '2022-01-29'),
(12, 1, NULL, 400, '2022-01-26', '2022-03-05'),
(13, NULL, 14, 550, '2022-01-16', '2022-01-28'),
(14, 8, NULL, 950, '2022-01-28', '2022-01-30'),
(15, NULL, 25, -4950, '2022-01-29', '2022-01-31'),
(16, 11, NULL, 850, '2022-01-30', '2022-02-01'),
(17, NULL, 18, -6500, '2022-01-31', '2022-03-10'),
(18, 18, NULL, 500, '2022-02-01', '2022-02-04'),
(19, NULL, 10, -4700, '2022-02-02', '2022-02-05'),
(20, 6, NULL, 600, '2022-02-03', '2022-02-07'),
(21, NULL, 33, -6850, '2022-02-04', '2022-02-06'),
(22, 15, NULL, 800, '2022-02-05', '2022-02-08'),
(23, NULL, 26, 350, '2022-02-06', '2022-03-16'),
(24, 17, NULL, 700, '2022-02-07', '2022-02-10'),
(25, NULL, 12, -2900, '2022-02-08', '2022-02-11'),
(26, 4, NULL, 900, '2022-02-09', '2022-02-13'),
(27, NULL, 29, -1300, '2022-02-10', '2022-03-20'),
(28, 13, NULL, 650, '2022-02-11', '2022-02-15'),
(29, NULL, 21, -5950, '2022-02-12', '2022-02-14'),
(30, 19, NULL, 1850, '2022-02-13', '2022-02-17'),
(31, NULL, 34, -7700, '2022-02-14', '2022-02-16'),
(32, 23, NULL, 200, '2022-02-15', '2022-02-19'),
(33, NULL, 15, -3000, '2022-02-16', '9999-12-31'),
(34, 9, NULL, 550, '2022-02-17', '9999-12-31'),
(35, NULL, 31, -10000, '2022-02-18', '9999-12-31'),
(36, 2, NULL, 350, '2022-02-19', '9999-12-31'),
(37, NULL, 16, -9000, '2022-02-20', '9999-12-31'),
(38, 20, NULL, 800, '2022-02-21', '9999-12-31'),
(39, NULL, 28, -8000, '2022-02-22', '9999-12-31'),
(40, 21, NULL, 450, '2022-02-23', '9999-12-31'),
(41, NULL, 35, -3000, '2022-02-24', '9999-12-31'),
(42, 5, NULL, 250, '2022-01-15', '2022-02-22'),
(43, NULL, 13, -6000, '2022-02-26', '9999-12-31'),
(44, 16, NULL, -300, '2022-01-25', '9999-12-31'),
(45, NULL, 22, 1000, '2022-01-18', '9999-12-31'),
(46, 10, NULL, 500, '2022-03-01', '9999-12-31'),
(47, NULL, 20, 250, '2022-03-02', '9999-12-31'),
(48, 12, NULL, 750, '2022-01-29', '9999-12-31'),
(49, NULL, 30, 800, '2022-01-26', '9999-12-31'),
(50, 1, NULL, 900, '2022-03-05', '9999-12-31'),
(51, NULL, 14, 400, '2022-01-28', '2022-03-08'),
(52, 8, NULL, 700, '2022-01-30', '9999-12-31'),
(53, NULL, 25, 950, '2022-01-31', '9999-12-31'),
(54, 11, NULL, 2000, '2022-02-01', '9999-12-31'),
(55, NULL, 18, 500, '2022-03-10', '9999-12-31'),
(56, 18, NULL, 300, '2022-02-04', '9999-12-31'),
(57, NULL, 10, 700, '2022-02-05', '9999-12-31'),
(58, 6, NULL, 450, '2022-02-07', '9999-12-31'),
(59, NULL, 33, 850, '2022-02-06', '9999-12-31'),
(60, 15, NULL, 750, '2022-02-08', '9999-12-31'),
(61, NULL, 26, 650, '2022-03-16', '9999-12-31'),
(62, 17, NULL, 400, '2022-02-10', '9999-12-31'),
(63, NULL, 12, 900, '2022-02-11', '9999-12-31'),
(64, 4, NULL, 500, '2022-02-13', '2022-03-23'),
(65, NULL, 29, 300, '2022-03-20', '9999-12-31'),
(66, 13, NULL, 600, '2022-02-15', '9999-12-31'),
(67, NULL, 21, 950, '2022-02-14', '9999-12-31'),
(68, 19, NULL, 150, '2022-02-17', '9999-12-31'),
(69, NULL, 34, 700, '2022-02-16', '9999-12-31'),
(70, 23, NULL, 250, '2022-02-19', '9999-12-31'),
(71, 5, NULL, 300, '2022-02-22', '9999-12-31'),
(72, 4, NULL, 500, '2022-03-23', '9999-12-31'),
(73, NULL, 1, -5000, '2022-03-23', '9999-12-31'),
(74, NULL, 2, -7000, '2022-01-23', '9999-12-31'),
(75, NULL, 3, -3000, '2022-01-22', '9999-12-31'),
(76, NULL, 4, -9000, '2022-01-20', '9999-12-31'),
(77, NULL, 5, -4000, '2022-01-21', '9999-12-31'),
(78, NULL, 6, -6000, '2022-01-16', '9999-12-31'),
(79, NULL, 7, -2000, '2022-01-11', '9999-12-31'),
(80, NULL, 9, -7000, '2022-01-10', '9999-12-31'),
(81, NULL, 11, -7000, '2022-01-13', '9999-12-31'),
(82, NULL, 17, -4000, '2022-01-18', '9999-12-31'),
(83, NULL, 19, -2000, '2022-01-23', '9999-12-31'),
(84, NULL, 23, -3000, '2022-01-22', '9999-12-31'),
(85, NULL, 24, -9000, '2022-01-21', '9999-12-31'),
(86, NULL, 27, -7000, '2022-01-20', '9999-12-31'),
(87, NULL, 32, -2000, '2022-01-26', '9999-12-31');

--Вывести все названия публичных компаний - клиентов банка

SELECT "legal entity"."Entity Name"
FROM "legal entity"
WHERE "legal entity"."Entity Type" = 'public';

--Вывести баланс по всем рассчетным счетам клиента Jack Brown

SELECT "checking/current account"."Balance"
FROM "checking/current account" 
JOIN "individual" ON "checking/current account"."IndividualID" = "individual"."IndividualID"
WHERE "individual"."Name" = 'Jack Brown';

--Вывести размер долга по имени клинета Emma Davis

SELECT "credit account"."Debt"
FROM "credit account" 
JOIN "individual" ON "credit account"."IndividualID" = "individual"."IndividualID"
WHERE "individual"."Name" = 'Emma Davis';

--Число активных счетов

SELECT COUNT("Operations"."OperationID")
FROM "Operations"
WHERE "Operations"."valid_to" = '9999-12-31';

--Сумма всех платежей в банк по кредитным счетам по дням в феврале

SELECT "Operations"."valid_from", SUM("Operations"."Sum") 
FROM "Operations"
WHERE ("Operations"."ChekingAccountID" IS NULL) AND ("Operations"."Sum" > 0)
GROUP BY "Operations"."valid_from"
HAVING "Operations"."valid_from" < '2022-03-01' AND "Operations"."valid_from" >= '2022-02-01';

--Топ 5 физических лиц по взятым кредитам

SELECT "Name", "Sum" 
FROM "individual"
JOIN (
    SELECT "IndividualID", "Sum"
    FROM "credit account"
    JOIN "Operations" ON "credit account"."CreditAccountID" = "Operations"."CreditAccountID"
) AS CurrentTable
ON "individual"."IndividualID" = CurrentTable."IndividualID"
ORDER BY "Sum"
LIMIT 5;

-- Вывести суммы которые частные и публичные компании внесли на свои текущие аккаунты

SELECT "Entity Type", SUM("Sum") AS Sum 
FROM "legal entity"
JOIN (
    SELECT "LegalID", "Sum"
    FROM "checking/current account"
    JOIN "Operations" ON "checking/current account"."CheckingAccountID" = "Operations"."ChekingAccountID"
) AS CurrentTable
ON "legal entity"."LegalID" = CurrentTable."LegalID"
GROUP BY "legal entity"."Entity Type";

--Физ лица банка, совершившие более 1 операции по кредитному счету, и количество операций

SELECT "Name", COUNT("Name") AS Amount_of_transactions
FROM "individual"
JOIN (
    SELECT "IndividualID"
    FROM "credit account"
    JOIN "Operations" ON "credit account"."CreditAccountID" = "Operations"."CreditAccountID"
) AS CurrentTable
ON "individual"."IndividualID" = CurrentTable."IndividualID"
GROUP BY "Name"
HAVING COUNT("Name") > 1
ORDER BY Amount_of_transactions DESC;

--Средняя сумма платежа по кредиту

SELECT AVG("Operations"."Sum") 
FROM "Operations"
WHERE ("Operations"."ChekingAccountID" IS NULL) AND ("Operations"."Sum" > 0);

--История операций компании Blue Sky Corporation по своему текущему счету
SELECT "Sum", "valid_from" AS "Date"
FROM "legal entity"
JOIN (
    SELECT "LegalID", "Sum", "valid_from"
    FROM "checking/current account"
    JOIN "Operations" ON "checking/current account"."CheckingAccountID" = "Operations"."ChekingAccountID"
) AS CurrentTable
ON "legal entity"."LegalID" = CurrentTable."LegalID"
WHERE "legal entity"."Entity Name" = 'Blue Sky Corporation';

SELECT * FROM IndividualView;

SELECT * FROM LegalView;

CREATE OR REPLACE FUNCTION transfer_funds (source_account BIGINT, target_account BIGINT, amount DECIMAL(8, 2))
RETURNS VOID AS $$
BEGIN
    UPDATE "checking/current account"
    SET "Balance" = "Balance" - amount
    WHERE "CheckingAccountID" = source_account;
    
    UPDATE "checking/current account"
    SET "Balance" = "Balance" + amount
    WHERE "CheckingAccountID" = target_account;
    
    INSERT INTO "Operations" ("ChekingAccountID", "Sum", "valid_from", "valid_to")
    VALUES (source_account, -amount, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day'),
           (target_account, amount, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day');
END;
$$ LANGUAGE PLPGSQL;
--Сделать перевод между накопительными счетами

CREATE OR REPLACE FUNCTION withdraw_funds (account_id BIGINT, amount DECIMAL(8, 2))
RETURNS VOID AS $$
BEGIN
    UPDATE "credit account"
    SET "Debt" = "Debt" - amount
    WHERE "CreditAccountID" = account_id;

    INSERT INTO "Operations" ("CreditAccountID", "Sum", "valid_from", "valid_to")
    VALUES (account_id, -amount, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day');
END;
$$ LANGUAGE PLPGSQL;

--Сделать дополнительный займ по кредитному счету

CREATE OR REPLACE FUNCTION calculate_interest ()
RETURNS VOID AS $$
DECLARE
    credit_id BIGINT;
    percent_rate BIGINT;
    debt_amount BIGINT;
BEGIN
    FOR credit_id IN SELECT "CreditAccountID" FROM "credit account" LOOP
        SELECT "Percent" INTO percent_rate FROM "credit account" WHERE "CreditAccountID" = credit_id;
        SELECT "Debt" INTO debt_amount FROM "credit account" WHERE "CreditAccountID" = credit_id;
        
        UPDATE "credit account"
        SET "Debt" = debt_amount * (1 + (percent_rate/100))
        WHERE "CreditAccountID" = credit_id;
        
        INSERT INTO "Operations" ("CreditAccountID", "Sum", "valid_from", "valid_to")
        VALUES (credit_id, debt_amount * (percent_rate/100), CURRENT_DATE, CURRENT_DATE + INTERVAL '1 day');
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;

--Начисление процента по долгу по всем кредитам всех счетов

CREATE OR REPLACE FUNCTION update_balance()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE "checking/current account" SET "Balance" = "Balance" + NEW."Sum" WHERE "CheckingAccountID" = NEW."ChekingAccountID";
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE "checking/current account" SET "Balance" = "Balance" - OLD."Sum" WHERE "CheckingAccountID" = OLD."ChekingAccountID";
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_balance_trigger
AFTER INSERT OR DELETE
ON "Operations"
FOR EACH ROW
EXECUTE FUNCTION update_balance();

--Триггер по начислению или  списанию средств с баланса при удалении или добавлении новой операции по счету

CREATE OR REPLACE FUNCTION delete_accounts()
RETURNS TRIGGER AS
$$
BEGIN
    DELETE FROM "credit account" 
    WHERE "IndividualID" = OLD."IndividualID";
    
    DELETE FROM "checking/current account" 
    WHERE "IndividualID" = OLD."IndividualID";
    
    RETURN OLD;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER delete_accounts_trigger
BEFORE DELETE ON "individual"
FOR EACH ROW
EXECUTE FUNCTION delete_accounts();

--Удаление всех кредитных и накопительных счетов при удалении пользователя из базы

CREATE OR REPLACE FUNCTION delete_operations_on_account()
    RETURNS TRIGGER AS $$
    BEGIN
        DELETE FROM "Operations"
        WHERE "ChekingAccountID" = OLD."CheckingAccountID"
            OR "CreditAccountID" = OLD."CreditAccountID";

        RETURN OLD;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_operations_trigger
    BEFORE DELETE ON "checking/current account"
    FOR EACH ROW
    EXECUTE FUNCTION delete_operations_on_account();

CREATE TRIGGER delete_operations_trigger
    BEFORE DELETE ON "credit account"
    FOR EACH ROW
    EXECUTE FUNCTION delete_operations_on_account();

--Удаляет все операции по счету из таблицы Операции при удалении счета