create schema myproject;
use myproject;

drop schema myproject;
    
CREATE TABLE IF NOT EXISTS `care_site_location` (
  `CareSiteID` INT NOT NULL,
  `CareSiteName` VARCHAR(45) NULL DEFAULT NULL,
  `ProviderID` INT NOT NULL,
  `ZipCode` INT NULL DEFAULT NULL,
  `DateOfService` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`CareSiteID`));

CREATE TABLE IF NOT EXISTS `provider` (
  `ProviderID` INT NOT NULL,
  `ProviderName` VARCHAR(45) NULL DEFAULT NULL,
  `CareSiteID` INT NULL DEFAULT NULL,
  `YearOfBirth` INT NULL DEFAULT NULL,
  `PhoneNumber` INT NULL DEFAULT NULL,
  `ZipCode` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ProviderID`),
  INDEX `CareSiteFK_idx` (`CareSiteID` ASC) VISIBLE,
  CONSTRAINT `CareSiteFK`
    FOREIGN KEY (`CareSiteID`)
    REFERENCES `care_site_location` (`CareSiteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `drug` (
  `DrugID` BIGINT NOT NULL,
  `DrugName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DrugID`));

CREATE TABLE IF NOT EXISTS `conditions` (
  `ConditionID` INT NOT NULL,
  `ConditionType` VARCHAR(45) NULL DEFAULT NULL,
  `DrugID` BIGINT NOT NULL,
  PRIMARY KEY (`ConditionID`),
  INDEX `DrugFk_idx` (`DrugID` ASC) VISIBLE,
  CONSTRAINT `DrugFk`
    FOREIGN KEY (`DrugID`)
    REFERENCES `drug` (`DrugID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `person` (
  `PersonID` INT NOT NULL,
  `ProviderID` INT NOT NULL,
  `CareSiteID` INT NOT NULL,
  `ConditionID` INT NOT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `DOB` DATE NOT NULL,
  `Gender` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`PersonID`),
  INDEX `ProviderFK_idx` (`ProviderID` ASC) VISIBLE,
  INDEX `CareSiteFK_idx` (`CareSiteID` ASC) VISIBLE,
  CONSTRAINT `ProviderFK`
    FOREIGN KEY (`ProviderID`)
    REFERENCES `provider` (`ProviderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CareSiteFK1`
    FOREIGN KEY (`CareSiteID`)
    REFERENCES `care_site_location` (`CareSiteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ConditionsFK2`
    FOREIGN KEY (`ConditionID`)
    REFERENCES `conditions` (`ConditionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `drug_exposure` (
  `DrugExposureID` INT NOT NULL,
  `PersonID` INT NOT NULL,
  `ProviderID` INT NOT NULL,
  `ConditionID` INT NOT NULL,
  `DrugExposureStartDate` DATE NOT NULL,
  `DrugExposureEndDate` DATE NOT NULL,
  `StopReason` VARCHAR(45) NULL DEFAULT NULL,
  `Refills` VARCHAR(45) NULL DEFAULT NULL,
  `Quantity` INT NOT NULL,
  `DaysOfSupply` INT NOT NULL,
  PRIMARY KEY (`DrugExposureID`),
  INDEX `PersonFK_idx` (`PersonID` ASC) VISIBLE,
  INDEX `ProviderFK_idx` (`ProviderID` ASC) VISIBLE,
  INDEX `ConditionFK_idx` (`ConditionID` ASC) VISIBLE,
  CONSTRAINT `PersonFK`
    FOREIGN KEY (`PersonID`)
    REFERENCES `person` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ProviderFK1`
    FOREIGN KEY (`ProviderID`)
    REFERENCES `provider` (`ProviderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ConditionsFK`
    FOREIGN KEY (`ConditionID`)
    REFERENCES `conditions` (`ConditionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `observation` (
  `ObservationID` INT NOT NULL,
  `PersonID` INT NOT NULL,
  `ConditionID` INT NOT NULL,
  `ObservationtDate` DATE NOT NULL,
  `ObservationType` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ObservationID`),
  INDEX `PersonFK_idx` (`PersonID` ASC) VISIBLE,
  INDEX `ConditionsFK_idx` (`ConditionID` ASC) VISIBLE,
  CONSTRAINT `PersonFK1`
    FOREIGN KEY (`PersonID`)
    REFERENCES `person` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ConditionsFK1`
    FOREIGN KEY (`ConditionID`)
    REFERENCES `conditions` (`ConditionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

INSERT INTO `care_site_location` (`CareSiteID`, `CareSiteName`, `ProviderID`, `ZipCode`, `DateOfService`) VALUES (1, 'Inpatient Facility', 519, 98074, '2016-11-23');
INSERT INTO `care_site_location` (`CareSiteID`, `CareSiteName`, `ProviderID`, `ZipCode`, `DateOfService`) VALUES (2, 'Outpatient Facility', 510, 97213, '2017-03-10');
INSERT INTO `care_site_location` (`CareSiteID`, `CareSiteName`, `ProviderID`, `ZipCode`, `DateOfService`) VALUES (3, 'Inpatient Facility', 507, 98749, '2016-01-20');
INSERT INTO `care_site_location` (`CareSiteID`, `CareSiteName`, `ProviderID`, `ZipCode`, `DateOfService`) VALUES (4, 'Outpatient Facility', 508, 96338, '2016-11-09');
INSERT INTO `care_site_location` (`CareSiteID`, `CareSiteName`, `ProviderID`, `ZipCode`, `DateOfService`) VALUES (5, 'Inpatient Facility', 523, 95607, '2017-08-14');
INSERT INTO `care_site_location` (`CareSiteID`, `CareSiteName`, `ProviderID`, `ZipCode`, `DateOfService`) VALUES (6, 'Inpatient Facility', 504, 95346, '2016-10-28');
INSERT INTO `care_site_location` (`CareSiteID`, `CareSiteName`, `ProviderID`, `ZipCode`, `DateOfService`) VALUES (7, 'Outpatient Facility', 524, 96479, '2016-04-29');
INSERT INTO `care_site_location` (`CareSiteID`, `CareSiteName`, `ProviderID`, `ZipCode`, `DateOfService`) VALUES (8, 'Outpatient Facility', 521, 96472, '2018-01-23');
INSERT INTO `care_site_location` (`CareSiteID`, `CareSiteName`, `ProviderID`, `ZipCode`, `DateOfService`) VALUES (9, 'Inpatient Facility', 512, 94312, '2017-09-04');
INSERT INTO `care_site_location` (`CareSiteID`, `CareSiteName`, `ProviderID`, `ZipCode`, `DateOfService`) VALUES (10, 'Inpatient Facility', 524, 96370, '2016-08-26');


INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (500, 'Provider1', 1, 1962, 422963402, 96343);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (501, 'Provider2', 2, 1951, 866239376, 97768);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (502, 'Provider3', 3, 1975, 623375844, 97514);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (503, 'Provider4', 4, 1964, 925402074, 95894);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (504, 'Provider5', 5, 1954, 248656383, 94746);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (505, 'Provider6', 6, 1968, 713930508, 96326);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (506, 'Provider7', 7, 1970, 664228742, 95896);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (507, 'Provider8', 8, 1970, 507724700, 98593);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (508, 'Provider9', 8, 1948, 521704357, 94407);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (509, 'Provider10', 9, 1949, 810022927, 96613);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (510, 'Provider11', 9, 1970, 463453706, 95176);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (511, 'Provider12', 9, 1984, 781738173, 94988);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (512, 'Provider13', 10, 1983, 668401416, 96245);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (513, 'Provider14', 10, 1962, 914842404, 95555);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (514, 'Provider15', 5, 1963, 919031240, 95301);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (515, 'Provider16', 6, 1972, 704597596, 96752);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (516, 'Provider17', 1, 1947, 163506025, 94439);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (517, 'Provider18', 3, 1952, 793561003, 94241);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (518, 'Provider19', 4, 1954, 369281009, 96086);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (519, 'Provider20', 7, 1957, 237648295, 98387);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (520, 'Provider21', 2, 1945, 487221097, 95559);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (521, 'Provider22', 9, 1975, 691656728, 97783);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (522, 'Provider23', 8, 1978, 737237094, 95595);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (523, 'Provider24', 2, 1967, 432836997, 97602);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (524, 'Provider25', 1, 1948, 435318290, 98688);
INSERT INTO `provider` (`ProviderID`, `ProviderName`, `CareSiteID`, `YearOfBirth`, `PhoneNumber`, `ZipCode`) VALUES (525, 'Provider26', 10, 1972, 278516469, 95817);

INSERT INTO `drug` (`DrugID`, `DrugName`) VALUES (893547593, 'Orencia');
INSERT INTO `drug` (`DrugID`, `DrugName`) VALUES (893548253, 'Fluoxetine');
INSERT INTO `drug` (`DrugID`, `DrugName`) VALUES (893548817, 'Amphetamine');
INSERT INTO `drug` (`DrugID`, `DrugName`) VALUES (893549391, 'Xeljnaz');
INSERT INTO `drug` (`DrugID`, `DrugName`) VALUES (893550031, 'Nitroglycerin');
INSERT INTO `drug` (`DrugID`, `DrugName`) VALUES (893550763, 'Aripiprazole');
INSERT INTO `drug` (`DrugID`, `DrugName`) VALUES (893551380, 'Albuterol');
INSERT INTO `drug` (`DrugID`, `DrugName`) VALUES (893552024, 'Ranitidine');
INSERT INTO `drug` (`DrugID`, `DrugName`) VALUES (893552549, 'Cetrizine');

INSERT INTO `conditions` (`ConditionID`, `ConditionType`, `DrugID`) VALUES (453453454, 'Rheumatoid Arthritis', 893547593);
INSERT INTO `conditions` (`ConditionID`, `ConditionType`, `DrugID`) VALUES (453453520, 'Bulimia Nervosa', 893548253);
INSERT INTO `conditions` (`ConditionID`, `ConditionType`, `DrugID`) VALUES (453453593, 'ADHD', 893548817);
INSERT INTO `conditions` (`ConditionID`, `ConditionType`, `DrugID`) VALUES (453453667, 'Auto Immune DS1', 893549391);
INSERT INTO `conditions` (`ConditionID`, `ConditionType`, `DrugID`) VALUES (453453723, 'Pulmonary Edema', 893550031);
INSERT INTO `conditions` (`ConditionID`, `ConditionType`, `DrugID`) VALUES (453453782, 'Depression', 893550763);
INSERT INTO `conditions` (`ConditionID`, `ConditionType`, `DrugID`) VALUES (453453858, 'Asthma', 893551380);
INSERT INTO `conditions` (`ConditionID`, `ConditionType`, `DrugID`) VALUES (453453926, 'Hives', 893552024);
INSERT INTO `conditions` (`ConditionID`, `ConditionType`, `DrugID`) VALUES (453453989, 'Allergies(Food)', 893552549);

INSERT INTO `person` (`PersonID`, `ProviderID`, `CareSiteID`, `ConditionID`, `Name`, `DOB`, `Gender`) VALUES (1, 519, 1, 453453454, 'Jack', '1923-05-01', 'F');
INSERT INTO `person` (`PersonID`, `ProviderID`, `CareSiteID`, `ConditionID`, `Name`, `DOB`, `Gender`) VALUES (2, 510, 2, 453453520, 'Ryan', '1943-01-01', 'Other');
INSERT INTO `person` (`PersonID`, `ProviderID`, `CareSiteID`, `ConditionID`, `Name`, `DOB`, `Gender`) VALUES (3, 507, 3, 453453593, 'Matt', '1936-09-01', 'M');
INSERT INTO `person` (`PersonID`, `ProviderID`, `CareSiteID`, `ConditionID`, `Name`, `DOB`, `Gender`) VALUES (4, 508, 4, 453453667, 'Damon', '1941-06-01', 'M');
INSERT INTO `person` (`PersonID`, `ProviderID`, `CareSiteID`, `ConditionID`, `Name`, `DOB`, `Gender`) VALUES (5, 523, 5, 453453723, 'Angelina', '1936-08-01', 'F');
INSERT INTO `person` (`PersonID`, `ProviderID`, `CareSiteID`, `ConditionID`, `Name`, `DOB`, `Gender`) VALUES (6, 504, 6, 453453782, 'Matt', '1943-10-01', 'Other');
INSERT INTO `person` (`PersonID`, `ProviderID`, `CareSiteID`, `ConditionID`, `Name`, `DOB`, `Gender`) VALUES (7, 524, 7, 453453858, 'Curtis', '1922-07-01', 'Other');
INSERT INTO `person` (`PersonID`, `ProviderID`, `CareSiteID`, `ConditionID`, `Name`, `DOB`, `Gender`) VALUES (8, 521, 8, 453453926, 'Alyssa', '1935-09-01', 'F');
INSERT INTO `person` (`PersonID`, `ProviderID`, `CareSiteID`, `ConditionID`, `Name`, `DOB`, `Gender`) VALUES (9, 512, 9, 453453989, 'Ellyse', '1976-09-01', 'F');
INSERT INTO `person` (`PersonID`, `ProviderID`, `CareSiteID`, `ConditionID`, `Name`, `DOB`, `Gender`) VALUES (10, 524, 10, 453453989, 'Meg', '1938-10-01', 'F');

INSERT INTO `drug_exposure` (`DrugExposureID`, `PersonID`, `ProviderID`, `ConditionID`, `DrugExposureStartDate`, `DrugExposureEndDate`, `StopReason`, `Refills`, `Quantity`, `DaysOfSupply`) VALUES (9, 1, 511, 453453858, '2016-11-25', '2017-08-03', 'Ineffective', '26', 93, 46);
INSERT INTO `drug_exposure` (`DrugExposureID`, `PersonID`, `ProviderID`, `ConditionID`, `DrugExposureStartDate`, `DrugExposureEndDate`, `StopReason`, `Refills`, `Quantity`, `DaysOfSupply`) VALUES (8, 7, 505, 453453593, '2016-04-23', '2017-06-24', 'Abused', '37', 120, 69);
INSERT INTO `drug_exposure` (`DrugExposureID`, `PersonID`, `ProviderID`, `ConditionID`, `DrugExposureStartDate`, `DrugExposureEndDate`, `StopReason`, `Refills`, `Quantity`, `DaysOfSupply`) VALUES (7, 9, 506, 453453593, '2018-02-28', '2019-03-19', 'Placebo', '13', 86, 42);
INSERT INTO `drug_exposure` (`DrugExposureID`, `PersonID`, `ProviderID`, `ConditionID`, `DrugExposureStartDate`, `DrugExposureEndDate`, `StopReason`, `Refills`, `Quantity`, `DaysOfSupply`) VALUES (6, 10, 520, 453453926, '2017-05-23', '2018-02-14', 'Recovered', '13', 84, 51);
INSERT INTO `drug_exposure` (`DrugExposureID`, `PersonID`, `ProviderID`, `ConditionID`, `DrugExposureStartDate`, `DrugExposureEndDate`, `StopReason`, `Refills`, `Quantity`, `DaysOfSupply`) VALUES (5, 5, 516, 453453858, '2016-02-19', '2017-06-19', 'Trial Period End', '18', 83, 55);
INSERT INTO `drug_exposure` (`DrugExposureID`, `PersonID`, `ProviderID`, `ConditionID`, `DrugExposureStartDate`, `DrugExposureEndDate`, `StopReason`, `Refills`, `Quantity`, `DaysOfSupply`) VALUES (4, 4, 504, 453453989, '2017-01-15', '2017-12-02', 'Ineffective', '16', 76, 46);
INSERT INTO `drug_exposure` (`DrugExposureID`, `PersonID`, `ProviderID`, `ConditionID`, `DrugExposureStartDate`, `DrugExposureEndDate`, `StopReason`, `Refills`, `Quantity`, `DaysOfSupply`) VALUES (3, 2, 507, 453453593, '2017-07-01', '2019-02-21', 'Abused', '39', 116, 61);
INSERT INTO `drug_exposure` (`DrugExposureID`, `PersonID`, `ProviderID`, `ConditionID`, `DrugExposureStartDate`, `DrugExposureEndDate`, `StopReason`, `Refills`, `Quantity`, `DaysOfSupply`) VALUES (2, 8, 512, 453453926, '2016-12-10', '2018-10-02', 'Abused', '22', 113, 33);
INSERT INTO `drug_exposure` (`DrugExposureID`, `PersonID`, `ProviderID`, `ConditionID`, `DrugExposureStartDate`, `DrugExposureEndDate`, `StopReason`, `Refills`, `Quantity`, `DaysOfSupply`) VALUES (1, 6, 506, 453453667, '2017-02-24', '2018-04-05', 'Recovered', '28', 107, 47);
INSERT INTO `drug_exposure` (`DrugExposureID`, `PersonID`, `ProviderID`, `ConditionID`, `DrugExposureStartDate`, `DrugExposureEndDate`, `StopReason`, `Refills`, `Quantity`, `DaysOfSupply`) VALUES (10, 3, 516, 453453723, '2018-01-10', '2018-04-16', 'Ineffective', '34', 92, 54);

INSERT INTO `observation` (`ObservationID`, `PersonID`, `ConditionID`, `ObservationtDate`, `ObservationType`) VALUES (1, 9, 453453593, '2018-07-16', 'Recheck');
INSERT INTO `observation` (`ObservationID`, `PersonID`, `ConditionID`, `ObservationtDate`, `ObservationType`) VALUES (2, 6, 453453667, '2018-10-23', 'Recheck');
INSERT INTO `observation` (`ObservationID`, `PersonID`, `ConditionID`, `ObservationtDate`, `ObservationType`) VALUES (3, 4, 453453989, '2018-04-04', 'Controlled Dose');
INSERT INTO `observation` (`ObservationID`, `PersonID`, `ConditionID`, `ObservationtDate`, `ObservationType`) VALUES (4, 8, 453453926, '2018-01-29', 'Controlled Dose');
INSERT INTO `observation` (`ObservationID`, `PersonID`, `ConditionID`, `ObservationtDate`, `ObservationType`) VALUES (5, 5, 453453858, '2016-02-10', 'New Trial');
INSERT INTO `observation` (`ObservationID`, `PersonID`, `ConditionID`, `ObservationtDate`, `ObservationType`) VALUES (6, 2, 453453593, '2018-05-09', 'Controlled Dose');
INSERT INTO `observation` (`ObservationID`, `PersonID`, `ConditionID`, `ObservationtDate`, `ObservationType`) VALUES (7, 7, 453453593, '2018-09-01', 'Recheck');
INSERT INTO `observation` (`ObservationID`, `PersonID`, `ConditionID`, `ObservationtDate`, `ObservationType`) VALUES (8, 3, 453453723, '2018-12-31', 'Recheck');
INSERT INTO `observation` (`ObservationID`, `PersonID`, `ConditionID`, `ObservationtDate`, `ObservationType`) VALUES (9, 1, 453453858, '2018-03-31', 'Controlled Dose');
INSERT INTO `observation` (`ObservationID`, `PersonID`, `ConditionID`, `ObservationtDate`, `ObservationType`) VALUES (10, 10, 453453926, '2018-01-04', 'New Trial');


select Name, DOB, CareSiteID, Gender from person p
left join observation o
on p.PersonID = o.PersonID
join conditions c on p.ConditionID = c.ConditionID
where c.ConditionType = 'Asthma';

select ProviderName, p1.CareSiteID, PhoneNumber from provider p1
join care_site_location c
on c.CareSiteID = p1.CareSiteID 
where c.CareSiteName = 'Inpatient Facility';

select StopReason, count(*) from drug_exposure
group by StopReason;

select Name, ConditionType, Drugname from person p 
inner join conditions c on p.ConditionID=c.ConditionID
inner join drug d on c.DrugID=d.DrugID;

select ConditionType, Drugname, Quantity, DaysOfSupply from conditions c 
inner join drug_exposure de on c.conditionID=de.conditionID
inner join drug d on d.DrugID=c.DrugID
order by ConditionType, DaysofSupply DESC;

select Name, ConditionType, Drugname, Quantity, DaysOfSupply from person p
inner join conditions c on p.conditionID= c.conditionID 
inner join drug_exposure de on p.PersonID=de.personID
inner join drug d on d.DrugID=c.DrugID
order by ConditionType, DaysofSupply DESC;