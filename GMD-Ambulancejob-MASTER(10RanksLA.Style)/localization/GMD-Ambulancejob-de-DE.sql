-- Making by GMD 
______/\\\\\\\\\\\\__/\\\\____________/\\\\__/\\\\\\\\\\\\____        
_____/\\\//////////__\/\\\\\\________/\\\\\\_\/\\\////////\\\__       
_____/\\\_____________\/\\\//\\\____/\\\//\\\_\/\\\______\//\\\_      
_____\/\\\____/\\\\\\\_\/\\\\///\\\/\\\/_\/\\\_\/\\\_______\/\\\_     
______\/\\\___\/////\\\_\/\\\__\///\\\/___\/\\\_\/\\\_______\/\\\_    
_______\/\\\_______\/\\\_\/\\\____\///_____\/\\\_\/\\\_______\/\\\_   
________\/\\\_______\/\\\_\/\\\_____________\/\\\_\/\\\_______/\\\__  
_________\//\\\\\\\\\\\\/__\/\\\_____________\/\\\_\/\\\\\\\\\\\\/___ 
__________\////////////____\///______________\///__\////////////_____

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_ambulance', 'Ambulance', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('ambulance', 0, 'intern', 'Intern', 50, '{}', '{}'),
    ('ambulance', 1, 'emt_b', 'EMT-B', 1500, '{}', '{}'),
    ('ambulance', 2, 'emt_i', 'EMT-I', 1800, '{}', '{}'),
    ('ambulance', 3, 'emt_p', 'EMT-P', 2100, '{}', '{}'),
    ('ambulance', 4, 'ambulance_officer', 'Ambulance Officer', 2400, '{}', '{}'),
    ('ambulance', 5, 'captain', 'Captain', 2700, '{}', '{}'),
    ('ambulance', 6, 'medical_resident', 'Medical Resident', 3000, '{}', '{}'),
    ('ambulance', 7, 'medical_doctor', 'Medical Doctor', 3300, '{}', '{}'),
    ('ambulance', 8, 'chief_resident', 'Chief Resident', 3800, '{}', '{}'),
    ('ambulance', 9, 'head_of_department', 'Head of Department', 4100, '{}', '{}'),
    ('ambulance', 10, 'chief_of_rescue_operation', 'Chief of Rescue Operation', 4500, '{}', '{}'),
    ('ambulance', 11, 'chief_of_medicine', 'Chief of Medicine', 5000, '{}', '{}'),
    ('offambulance', 0, 'intern', 'Trainee', 0, '{}', '{}'),
    ('offambulance', 1, 'emt_b', 'EMT-B', 0, '{}', '{}'),
    ('offambulance', 2, 'emt_i', 'EMT-I', 0, '{}', '{}'),
    ('offambulance', 3, 'emt_p', 'EMT-P', 0, '{}', '{}'),
    ('offambulance', 4, 'ambulance_officer', 'Ambulance Officer', 0, '{}', '{}'),
    ('offambulance', 5, 'captain', 'Captain', 0, '{}', '{}'),
    ('offambulance', 6, 'medical_resident', 'Medical Resident', 0, '{}', '{}'),
    ('offambulance', 7, 'medical_doctor', 'Medical Doctor', 0, '{}', '{}'),
    ('offambulance', 8, 'chief_resident', 'Chief Resident', 0, '{}', '{}'),
    ('offambulance', 9, 'assistentchief', 'Head of Department', 0, '{}', '{}'),
    ('offambulance', 10, 'chief_of_rescue_operation', 'Chief of Rescue Operation', 0, '{}', '{}'),
;

INSERT INTO `jobs` (name, label) VALUES
	('ambulance','EMS')
;

INSERT INTO `items` (name, label, weight) VALUES
	('bandage','Bandage', 2),
	('medikit','Medikit', 2),
	('mexalen','Mexalen 500mg',1),
    ('marijuana2','Medizinisches CBD OIL',1),
    ('ibuprofen','Ibuprofen 600mg',1),
    ('aspirin','Aspirin 500mg',1),

;

ALTER TABLE `users`
	ADD `is_dead` TINYINT(1) NULL DEFAULT '0'
;
